//
//  OrgRootViewController.m
//  MultiSplitView
//
//  Created by Stephan Eletzhofer on 09.03.11.
//  Copyright 2011 Nexiles GmbH. All rights reserved.
//

#import "OrgRootViewController.h"


@implementation OrgRootViewController

@synthesize organizations = _organizations;

-(void)configure:(NSDictionary *)info
{
  NSLog(@"%s", __func__);

  NSArray *orgs = [info objectForKey:@"organizations"];
  self.organizations = orgs;
}

#pragma mark -
#pragma mark View lifecycle

- (void)viewDidLoad
{
  NSLog(@"%s", __func__);
  [super viewDidLoad];

  //NXDataLoader *loader = [NXDataLoader sharedLoader];
  //[self configure: [loader loadJSONFromBundle:@"organizations"]];
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
  return self.organizations.count;
}


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

  static NSString *CellIdentifier = @"Cell";

  UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
  if (cell == nil) {
    cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
  }

  NSInteger row = [indexPath row];
  NSDictionary *org = [[self organizations] objectAtIndex: row];

  cell.textLabel.text = [org objectForKey:@"name"];
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
