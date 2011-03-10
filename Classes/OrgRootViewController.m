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


@implementation OrgRootViewController

@synthesize organizations = _organizations;
@synthesize name = _name;
@synthesize detailView;

-(void)configure:(NSDictionary *)info
{
  NSLog(@"%s", __func__);

  NSArray *orgs = [info objectForKey:self.name];
  self.organizations = orgs;
}

#pragma mark -
#pragma mark initialization

- (id)init
{
  if (self = [super init]) {
    _name = @"organizations";
  }
  return self;
}

#pragma mark -
#pragma mark View lifecycle

- (void)viewDidLoad
{
  NSLog(@"%s", __func__);
  [super viewDidLoad];

  NXDataLoader *loader = [NXDataLoader sharedLoader];
  [self configure: [loader loadBundledJSON:@"organizations"]];
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

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
  NSLog(@"%s", __func__);

  ViewRegistry *registry = [ViewRegistry sharedViewRegistry];
  id<ConfigurableViewController> viewController = [registry controllerForName:@"organization.detail"];
  NSLog(@"%s: viewController=%@", __func__, viewController);


  NSInteger row = [indexPath row];
  NSDictionary *org = [[self organizations] objectAtIndex: row];
  NSLog(@"%s: org=%@", __func__, org);

  [viewController configure:org];
  //[self.navigationController pushViewController:viewController animated:YES];
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
