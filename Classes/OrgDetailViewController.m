//
//  OrgViewController.m
//  MultiSplitView
//
//  Created by Stephan Eletzhofer on 09.03.11.
//  Copyright 2011 Nexiles GmbH. All rights reserved.
//

#import "OrgDetailViewController.h"
#import "NXDataLoader.h"

@interface OrgDetailViewController ()
-(void)configureView;
@property (nonatomic, retain) UIPopoverController *popoverController;
@end

@implementation OrgDetailViewController

@synthesize name     = _name;
@synthesize products = _products;
@synthesize popoverController;

-(void)configure:(NSDictionary *)info
{
  NSLog(@"%s", __func__);

  self.name = [info objectForKey:@"name"];
  self.products = [info objectForKey:@"products"];

  if (self.popoverController != nil) {
    [self.popoverController dismissPopoverAnimated:YES];
  }        

  [self configureView];
}

#pragma mark -
#pragma mark View lifecycle

- (void)viewDidLoad {
  NSLog(@"%s", __func__);
  [super viewDidLoad];

  // load default org
  NXDataLoader *loader = [NXDataLoader sharedLoader];
  NSDictionary *defaultOrg = [loader loadBundledJSON:@"organization-default"];
  [self configure:defaultOrg];
}


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Override to allow orientations other than the default portrait orientation.
    return YES;
}

- (void)configureView
{
   NSLog(@"%s", __func__);
   self.title = self.name;
}

#pragma mark -
#pragma mark Split View Controller Delegate

- (void)splitViewController:(UISplitViewController*)svc 
     willHideViewController:(UIViewController *)aViewController 
          withBarButtonItem:(UIBarButtonItem*)barButtonItem 
       forPopoverController:(UIPopoverController*)pc
{  
  [barButtonItem setTitle:@"Organizations"];
  [[self navigationItem] setLeftBarButtonItem:barButtonItem];
  [self setPopoverController:pc];
}
 
 
- (void)splitViewController:(UISplitViewController*)svc 
     willShowViewController:(UIViewController *)aViewController 
  invalidatingBarButtonItem:(UIBarButtonItem *)barButtonItem
{
  [[self navigationItem] setLeftBarButtonItem:nil];
  [self setPopoverController:nil];
}


#pragma mark -
#pragma mark Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 2;
}

//- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView
//{
  //return [NSArray arrayWithObjects: @"Organization details", @"Products", nil];
//}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
  switch (section) {
    case 0:
      return @"Organization details";

    case 1:
      return @"Products";
    default:
      return @"??";
  }
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
  NSLog(@"%s", __func__);

  switch (section) {
    case 0:
      return 1;
      break;
    case 1:
      return self.products.count;
      break;
    default:
      return 0;
  }
}

-(UITableViewCell *)orgCellWithLabel:(NSString *)label andDetail:(NSString *)detail tableView:(UITableView *)tableView
{
  NSLog(@"%s", __func__);
  static NSString *CellIdentifier = @"ProductCell";

  UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
  if (cell == nil) {
    cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1
                                   reuseIdentifier:CellIdentifier] autorelease];
  }

  cell.textLabel.text = label;
  cell.detailTextLabel.text = detail;

  return cell;
}

-(UITableViewCell *)productCellwithLabel:(NSString *)label andDetail:(NSString *)detail tableView:(UITableView *)tableView
{
  NSLog(@"%s", __func__);
  static NSString *CellIdentifier = @"OrgCell";

  UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
  if (cell == nil) {
    cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                   reuseIdentifier:CellIdentifier] autorelease];
  }

  cell.textLabel.text = label;

  if (detail) 
    cell.detailTextLabel.text = detail;

  return cell;
}

// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
  NSLog(@"%s: indexPath=%@", __func__, indexPath);
  
  NSInteger section = [indexPath section];
  NSInteger row = [indexPath row];
  UITableViewCell *cell = nil;

  if (section == 0) {
    cell = [self orgCellWithLabel: @"Name"
                        andDetail: self.name
                        tableView: tableView];
  } else {
    cell = [self productCellwithLabel: [[self products] objectAtIndex: row]
                            andDetail: nil
                            tableView: tableView];
  }

  return cell;
}

#pragma mark -
#pragma mark Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    // Navigation logic may go here. Create and push another view controller.
    /*
    <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
    // ...
    // Pass the selected object to the new view controller.
    [self.navigationController pushViewController:detailViewController animated:YES];
    [detailViewController release];
    */
}


#pragma mark -
#pragma mark Memory management

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];

    // Relinquish ownership any cached data, images, etc. that aren't in use.
}

- (void)viewDidUnload {
    // Relinquish ownership of anything that can be recreated in viewDidLoad or on demand.
    // For example: self.myOutlet = nil;
}


- (void)dealloc {
    [super dealloc];
}


@end

// vim: set ts=2 sw=2 expandtab:
