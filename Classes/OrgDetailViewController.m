//
//  OrgViewController.m
//  MultiSplitView
//
//  Created by Stephan Eletzhofer on 09.03.11.
//  Copyright 2011 Nexiles GmbH. All rights reserved.
//

#import "OrgDetailViewController.h"


@implementation OrgDetailViewController

@synthesize name     = _name;
@synthesize products = _products;

-(void)configure:(NSDictionary *)info
{
	NSLog(@"%s", __func__);

  self.name = [info objectForKey:@"name"];
  self.products = [info objectForKey:@"products"];

}


#pragma mark -
#pragma mark View lifecycle

- (void)viewDidLoad {
  NSLog(@"%s", __func__);
  [super viewDidLoad];
}


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Override to allow orientations other than the default portrait orientation.
    return YES;
}


#pragma mark -
#pragma mark Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 2;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
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
    static NSString *CellIdentifier = @"OrgCell";

    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                       reuseIdentifier:CellIdentifier] autorelease];
    }

    cell.textLabel.text = label;
    cell.detailTextLabel.text = detail;

    return cell;
}

// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
  NSInteger row = [indexPath row];
  UITableViewCell *cell = nil;

  if (row == 0) {
    cell = [self orgCellWithLabel: self.name
                        andDetail: @"foo"
                        tableView: tableView];
  } else {
    cell = [self productCellwithLabel: [[self products] objectAtIndex: row]
                            andDetail: @"foo"
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
