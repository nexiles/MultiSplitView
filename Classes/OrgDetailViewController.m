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


@implementation OrgDetailViewController

@synthesize name      = _name;
@synthesize products  = _products;

-(void)configure
{
  NSLog(@"%s: self=%@", __func__, self);

  self.name     = [self.data objectForKey:@"name"];
  self.products = [self.data objectForKey:@"products"];

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

    self.name = @"Organization";
    self.controllerName = @"organization";
    self.clearsSelectionOnViewWillAppear = NO;

    assert(self.tableView);

    // load default org
    NXDataLoader *loader     = [NXDataLoader sharedLoader];
    NSDictionary *defaultOrg = [loader loadBundledJSON:@"organization-default"];
    self.data = defaultOrg;

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


//- (void)splitViewController: (UISplitViewController*)svc willHideViewController:(UIViewController *)aViewController withBarButtonItem:(UIBarButtonItem*)barButtonItem forPopoverController: (UIPopoverController*)pc {

    //barButtonItem.title = @"Root List";
    //NSMutableArray *items = [self.toolBar.items mutableCopy];
    //[items insertObject:barButtonItem atIndex:0];
    //[[self toolBar] setItems:items animated:YES];
    //[items release];
    //self.popoverController = pc;
//}


//// Called when the view is shown again in the split view, invalidating the button and popover controller.
//- (void)splitViewController: (UISplitViewController*)svc willShowViewController:(UIViewController *)aViewController invalidatingBarButtonItem:(UIBarButtonItem *)barButtonItem {

    //NSMutableArray *items = [[[self toolBar] items] mutableCopy];
    //[items removeObjectAtIndex:0];
    //[[self toolBar] setItems:items animated:YES];
    //[items release];
    //self.popoverController = nil;
//}


/*
- (void)splitViewController:(UISplitViewController*)svc
     willHideViewController:(UIViewController *)aViewController
          withBarButtonItem:(UIBarButtonItem*)barButtonItem
       forPopoverController:(UIPopoverController*)pc
{
  NSLog(@"%s", __func__);
  NSLog(@"%s: aViewController=%@", __func__, aViewController);
  NSLog(@"%s: barButtonItem=%@", __func__, barButtonItem);

  NSLog(@"%s: pc=%@", __func__, pc);

  [barButtonItem setTitle:@"Organizations"];
  [[self navigationItem] setLeftBarButtonItem:barButtonItem];
  [self setPopoverController:pc];
}


- (void)splitViewController:(UISplitViewController*)svc
     willShowViewController:(UIViewController *)aViewController
  invalidatingBarButtonItem:(UIBarButtonItem *)barButtonItem
{
  NSLog(@"%s", __func__);
  [[self navigationItem] setLeftBarButtonItem:nil];
  [self setPopoverController:nil];
}
*/


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
  //NSLog(@"%s", __func__);

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
  //NSLog(@"%s", __func__);
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
  //NSLog(@"%s", __func__);
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
  //NSLog(@"%s: self=%@", __func__, self);
  //NSLog(@"%s: indexPath=%@", __func__, indexPath);

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
  if (section == kProductsSection) {
    NSDictionary *products = [NSDictionary dictionaryWithObjectsAndKeys:
              [self products], @"products",
              indexPath, @"selection",
              nil];
    NSDictionary *info = [NSDictionary dictionaryWithObjectsAndKeys:
              @"product", @"controller_name",
              products, @"data",
              nil];
    NSNotification *note = [NSNotification notificationWithName:@"new_root_controller"
                                                         object:self
                                                       userInfo:info];
    [[NSNotificationCenter defaultCenter] postNotification: note];
  }
}


#pragma mark -
#pragma mark Memory management

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)viewDidUnload {
}

- (void)dealloc
{
  self.products = nil;
  self.name = nil;

  [super dealloc];
}


@end

// vim: set ts=2 sw=2 expandtab:
