//
//  ProductRootViewController.m
//  MultiSplitView
//
//  Created by Stephan Eletzhofer on 11.03.11.
//  Copyright 2011 Nexiles GmbH. All rights reserved.
//

#import "ProductRootViewController.h"

@interface ProductRootViewController ()
-(void)configureView;
@end

@implementation ProductRootViewController

@synthesize products   = _products;
@synthesize name       = _name;
@synthesize tableView  = _tableView;
@synthesize detailView = _detailView;


-(void)configure:(NSDictionary *)info
{
  NSLog(@"%s: info=%@", __func__, info);

  self.products = [info objectForKey:@"products"];
  [self configureView];
}


#pragma mark -
#pragma mark View lifecycle

- (void)viewDidLoad {
  [super viewDidLoad];
  self.name = @"Products";
}

-(void)configureView
{
  self.title = self.name;
  [[self tableView] reloadData];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Override to allow orientations other than the default portrait orientation.
    return YES;
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
  NSInteger row = [indexPath row];
  NSDictionary *product = [[self products] objectAtIndex: row];
  [self.detailView configure:product];
}


#pragma mark -
#pragma mark Memory management

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
}

- (void)viewDidUnload
{
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

