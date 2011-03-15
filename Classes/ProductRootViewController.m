//
//  ProductRootViewController.m
//  MultiSplitView
//
//  Created by Stephan Eletzhofer on 11.03.11.
//  Copyright 2011 Nexiles GmbH. All rights reserved.
//

#import "ProductRootViewController.h"

#import "ViewRegistry.h"
#import "NXDataLoader.h"

@implementation ProductRootViewController

@synthesize products   = _products;
@synthesize name       = _name;

-(void)configure
{
  self.products = [self.data objectForKey:@"products"];
  self.title = self.name;
  [[self tableView] reloadData];

  // select row
  NSIndexPath *selection = [self.data objectForKey:@"selection"];
  NSIndexPath *path = [NSIndexPath indexPathForRow:selection.row inSection:0];
  NSLog(@"%s: selection=%@", __func__, selection);
  NSLog(@"%s: path=%@", __func__, path);
  [self.tableView selectRowAtIndexPath:path
                              animated:YES
                        scrollPosition:UITableViewScrollPositionMiddle];
  [self tableView:self.tableView didSelectRowAtIndexPath:path];
}

#pragma mark -
#pragma mark initialization

-(id)initWithNibName:(NSString *)name bundle:(NSBundle *)bundle
{
  NSLog(@"%s", __func__);
  self = [super initWithNibName:name bundle:bundle];
  if (self) {

    self.name = @"Products";
    self.controllerName = @"product";
    self.clearsSelectionOnViewWillAppear = NO;

    assert(self.tableView);

    // default data
    NXDataLoader *loader = [NXDataLoader sharedLoader];
    self.data = [loader loadBundledJSON:@"product-default"];

    return self;
  }
  return nil;
}

#pragma mark -
#pragma mark View lifecycle

- (void)viewDidAppear:(BOOL)animated
{
  NSLog(@"%s", __func__);
  [super viewDidAppear:animated];
  [self configure];
}

- (void)viewWillDisappear:(BOOL)animated
{
  NSLog(@"%s", __func__);
  [super viewWillDisappear:animated];
  [self.detailView.navigationController popViewControllerAnimated:YES];
}

#pragma mark -
#pragma mark Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return self.products.count;
}


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{

  static NSString *CellIdentifier = @"Cell";

  UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
  if (cell == nil) {
    cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
  }

  NSInteger row = [indexPath row];
  NSDictionary *product = [[self products] objectAtIndex: row];
  cell.textLabel.text = [product objectForKey:@"name"];

  return cell;
}

#pragma mark -
#pragma mark Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
  NSLog(@"%s: indexPath=%@", __func__, indexPath);

  NSInteger row = [indexPath row];
  NSDictionary *product = [[self products] objectAtIndex: row];

  // Try to load Product Data
  NXDataLoader *loader = [NXDataLoader sharedLoader];
  NSDictionary *product_data = [loader loadBundledJSON:[product objectForKey:@"name"]];
  if (!product_data) {
    product_data = [loader loadBundledJSON:@"product-default"];
  }

  self.detailView.data = product_data;
  [self.detailView configure];
}


#pragma mark -
#pragma mark Memory management

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
}

- (void)viewDidUnload
{
  [super viewDidUnload];
  self.name = nil;
  self.products = nil;
}


- (void)dealloc {
  self.name = nil;
  self.products = nil;

  [super dealloc];
}

@end
// vim: set ts=2 sw=2 expandtab:

