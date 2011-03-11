//
//  OrgRootViewController.m
//  MultiSplitView
//
//  Created by Stephan Eletzhofer on 09.03.11.
//  Copyright 2011 Nexiles GmbH. All rights reserved.
//

#import "OrgRootViewController.h"

#import "ViewRegistry.h"
#import "NXDataLoader.h"

@interface OrgRootViewController ()
-(void)configureView;
@end

@implementation OrgRootViewController

@synthesize organizations = _organizations;
@synthesize name = _name;
@synthesize detailView;

-(void)configure:(NSDictionary *)info
{
  NSLog(@"%s: info=%@", __func__, info);

  NSArray *orgs = [info objectForKey:@"organizations"];
  NSLog(@"%s: orgs=%@", __func__, orgs);

  self.organizations = orgs;

  [self configureView];
}

#pragma mark -
#pragma mark initialization

#pragma mark -
#pragma mark View lifecycle

- (void)viewDidLoad
{
  NSLog(@"%s", __func__);
  [super viewDidLoad];

  self.name = @"Organizations";

  NXDataLoader *loader = [NXDataLoader sharedLoader];
  [self configure: [loader loadBundledJSON:@"organizations"]];
}

-(void)configureView
{
  self.title = self.name;

  [[self view] reloadData];
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
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
  NSLog(@"%s: indexPath=%@", __func__, indexPath);

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

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
  NSLog(@"%s", __func__);

  NSInteger row = [indexPath row];
  NSDictionary *org = [[self organizations] objectAtIndex: row];
  NSLog(@"%s: org=%@", __func__, org);

  [self.detailView configure:org];
}


#pragma mark -
#pragma mark Memory management

- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
}

- (void)viewDidUnload {
}

- (void)dealloc {
  [super dealloc];
}

@end

// vim: set ts=2 sw=2 expandtab:
