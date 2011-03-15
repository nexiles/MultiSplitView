//
//  ProductDetailViewController.m
//  MultiSplitView
//
//  Created by Stephan Eletzhofer on 11.03.11.
//  Copyright 2011 Nexiles GmbH. All rights reserved.
//

#import "ProductDetailViewController.h"

#import "NXDataLoader.h"

enum {
  kProductDetailsSection = 0,
  kDocumentsSection,
  kMaxSections // !!! last
};


@implementation ProductDetailViewController

@synthesize name         = _name;
@synthesize owner        = _owner;
@synthesize oid          = _oid;
@synthesize EPMDocuments = _EPMDocuments;

-(void)configure
{
  NSLog(@"%s: data=%@", __func__, self.data);

  self.name         = [self.data objectForKey:@"name"];
  self.oid          = [self.data objectForKey:@"oid"];
  self.owner        = [self.data objectForKey:@"owner"];
  self.EPMDocuments = [self.data objectForKey:@"epm_documents"];

  if (self.popoverController != nil) {
    [self.popoverController dismissPopoverAnimated:YES];
  }

  self.title = self.name;
  [[self tableView] reloadData];
}

#pragma mark -
#pragma mark initialization

-(id)initWithNibName:(NSString *)name bundle:(NSBundle *)bundle
{
  NSLog(@"%s", __func__);
  self = [super initWithNibName:name bundle:bundle];
  if (self) {

    self.name = @"Product";
    self.controllerName = @"product";
    self.clearsSelectionOnViewWillAppear = NO;

    assert(self.tableView);

    // load default org
    NXDataLoader *loader     = [NXDataLoader sharedLoader];
    NSDictionary *d = [loader loadBundledJSON:@"product-default"];
    self.data = d;

    return self;
  }
  return nil;
}

#pragma mark -
#pragma mark View lifecycle

- (void)viewWillAppear:(BOOL)animated
{
  NSLog(@"%s", __func__);
  [super viewWillAppear:animated];
  [self configure];
}


#pragma mark -
#pragma mark Split View Controller Delegate

- (void)splitViewController:(UISplitViewController*)svc
     willHideViewController:(UIViewController *)aViewController
          withBarButtonItem:(UIBarButtonItem*)barButtonItem
       forPopoverController:(UIPopoverController*)pc
{
  [barButtonItem setTitle:@"Products"];
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
    return kMaxSections;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
  switch (section) {
    case kProductDetailsSection:
      return @"Product Details";

    case kDocumentsSection:
      return @"CAD Documents";
    default:
      return @"??";
  }
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
  // Return the number of rows in the section.
  switch (section) {
    case kProductDetailsSection:
      return 3; // name, oid, owner

    case kDocumentsSection:
      return self.EPMDocuments.count;

    default:
      return 0;
  }
}

-(UITableViewCell *)detailCellForRow:(NSInteger)row tableView:(UITableView *)tableView
{
  //NSLog(@"%s", __func__);
  static NSString *CellIdentifier = @"ProdDetailCell";

  UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
  if (cell == nil) {
    cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1
                                   reuseIdentifier:CellIdentifier] autorelease];
  }

  NSString *text;
  NSString *detail;
  switch (row) {
    case 0:
      text = @"Name";
      detail = self.name;
      break;
    case 1:
      text = @"OID";
      detail = self.oid;
      break;
    case 2:
      text = @"Owner";
      detail = self.owner;
      break;

  }

  cell.textLabel.text = text;
  cell.detailTextLabel.text = detail;

  return cell;
}

-(UITableViewCell *)docCellForDoc:(NSDictionary *)doc tableView:(UITableView *)tableView
{
  //NSLog(@"%s", __func__);
  static NSString *CellIdentifier = @"DocCell";

  UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
  if (cell == nil) {
    cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1
                                   reuseIdentifier:CellIdentifier] autorelease];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
  }

  NSString *detail = [NSString stringWithFormat:@"%@ (%@) @ %@",
                              [doc objectForKey:@"cadname"],
                              [doc objectForKey:@"number"],
                              [doc objectForKey:@"version"]
                                ];

  cell.textLabel.text = [doc objectForKey:@"name"];
  cell.detailTextLabel.text = detail;

  return cell;
}


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    UITableViewCell *cell;

    NSInteger row = [indexPath row];
    NSInteger section = [indexPath section];

    switch (section) {
      case kProductDetailsSection:
          cell = [self detailCellForRow:row tableView:tableView];
          break;
      case kDocumentsSection: {
            NSDictionary *doc = [[self EPMDocuments] objectAtIndex:row];
            cell = [self docCellForDoc:doc tableView:tableView];
        }
        break;
      default:
        break;
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

