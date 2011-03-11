//
//  OrgViewController.m
//  MultiSplitView
//
//  Created by Stephan Eletzhofer on 09.03.11.
//  Copyright 2011 Nexiles GmbH. All rights reserved.
//

#import "OrgDetailViewController.h"
#import "ViewRegistry.h"
#import "NXDataLoader.h"

enum {
  kOrgDetailSection = 0,
  kProductsSection,
  kMaxSections // last
};

@interface OrgDetailViewController ()
-(void)configureView;
@property (nonatomic, retain) UIPopoverController *popoverController;
@end

@implementation OrgDetailViewController

@synthesize name     = _name;
@synthesize products = _products;
@synthesize popoverController;
@synthesize tableView;

-(void)configure:(NSDictionary *)info
{
  NSLog(@"%s: self=%@", __func__, self);

  self.name     = [info objectForKey:@"name"];
  self.products = [info objectForKey:@"products"];

  if (self.popoverController != nil) {
    [self.popoverController dismissPopoverAnimated:YES];
  }

  [self configureView];
}

#pragma mark -
#pragma mark View lifecycle

- (void)viewDidLoad {
  NSLog(@"%s: self=%@", __func__, self);
  [super viewDidLoad];

  // load default org
  NXDataLoader *loader     = [NXDataLoader sharedLoader];
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

   [[self tableView] reloadData];
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

- (NSInteger)numberOfSectionsInTableView:(UITableView *)theTableView {
    // Return the number of sections.
    return kMaxSections;
}

//- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)theTableView
//{
  //return [NSArray arrayWithObjects: @"Organization details", @"Products", nil];
//}

- (NSString *)tableView:(UITableView *)theTableView titleForHeaderInSection:(NSInteger)section
{
  switch (section) {
    case kOrgDetailSection:
      return @"Organization details";

    case kProductsSection:
      return @"Products";
    default:
      return @"??";
  }
}


- (NSInteger)tableView:(UITableView *)theTableView numberOfRowsInSection:(NSInteger)section
{
  NSLog(@"%s", __func__);

  switch (section) {
    case kOrgDetailSection:
      return 1;
      break;
    case kProductsSection:
      return self.products.count;
      break;
    default:
      return 0;
  }
}

-(UITableViewCell *)productCellForProduct:(NSDictionary *)product tableView:(UITableView *)theTableView
{
  NSLog(@"%s", __func__);
  static NSString *CellIdentifier = @"ProductCell";

  UITableViewCell *cell = [theTableView dequeueReusableCellWithIdentifier:CellIdentifier];
  if (cell == nil) {
    cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1
                                   reuseIdentifier:CellIdentifier] autorelease];

    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
  }

  cell.textLabel.text       = [product objectForKey:@"name"];
  cell.detailTextLabel.text = [product objectForKey:@"oid"];

  return cell;
}

-(UITableViewCell *)orgCellWithLabel:(NSString *)label andDetail:(NSString *)detail tableView:(UITableView *)theTableView
{
  NSLog(@"%s", __func__);
  static NSString *CellIdentifier = @"OrgCell";

  UITableViewCell *cell = [theTableView dequeueReusableCellWithIdentifier:CellIdentifier];
  if (cell == nil) {
    cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1
                                   reuseIdentifier:CellIdentifier] autorelease];
  }

  cell.textLabel.text = label;

  if (detail)
    cell.detailTextLabel.text = detail;

  return cell;
}

// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)theTableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
  NSLog(@"%s: self=%@", __func__, self);
  NSLog(@"%s: indexPath=%@", __func__, indexPath);

  NSInteger section = [indexPath section];
  NSInteger row = [indexPath row];
  UITableViewCell *cell = nil;

  if (section == kOrgDetailSection) {
    cell = [self orgCellWithLabel: @"Name"
                        andDetail: self.name
                        tableView: theTableView];
  } else {
    cell = [self productCellForProduct: [[self products] objectAtIndex: row]
                            tableView: theTableView];
  }

  return cell;
}

#pragma mark -
#pragma mark Table view delegate

- (void)tableView:(UITableView *)theTableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
  NSInteger section = [indexPath section];
  NSInteger row     = [indexPath row];
  if (section == kProductsSection) {
    NSDictionary *products = [NSDictionary dictionaryWithObjectsAndKeys: [self products], @"products", nil];
    NSDictionary *info = [NSDictionary dictionaryWithObjectsAndKeys:
      @"product", @"controller_name",
      products, @"data",
      nil];
    NSNotification *note = [NSNotification notificationWithName:@"push_notification"
                                                         object:self
                                                       userInfo:info];
    [[NSNotificationCenter defaultCenter] postNotification: note];
  }
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


- (void)dealloc
{
  self.products = nil;
  self.name = nil;

  [super dealloc];
}


@end

// vim: set ts=2 sw=2 expandtab:
