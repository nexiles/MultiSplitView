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
#import "NXWindchillDataLoader.h"

@implementation OrgRootViewController

@synthesize organizations = _organizations;
@synthesize name          = _name;

-(void)configure
{
  NSLog(@"%s", __func__);
  NSArray *orgs = [self.data objectForKey:@"organizations"];
  self.organizations = orgs;
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

    self.name = @"Organizations";
    self.controllerName = @"organization";
    self.clearsSelectionOnViewWillAppear = NO;

    assert(self.tableView);

    // default data
    NXDataLoader *loader = [NXDataLoader sharedLoader];
    self.data = [loader loadBundledJSON:@"organizations"];

    [[NSNotificationCenter defaultCenter]
      addObserver:self
         selector:@selector(dataLoadNotification:)
             name:@"load-organizations"
           object:nil];

    return self;
  }
  return nil;
}

-(void)dataLoadNotification:(NSNotification *)note
{
  NSLog(@"%s", __func__);
  self.data = note.userInfo;
  [self configure];
}

#pragma mark -
#pragma mark View lifecycle

- (void)viewDidAppear:(BOOL)animated
{
  NSLog(@"%s", __func__);
  [super viewDidAppear:animated];
  [self configure];
}

#pragma mark -
#pragma mark Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
  return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  return self.organizations.count;
}


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
  //NSLog(@"%s: indexPath=%@", __func__, indexPath);

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
  //NSLog(@"%s", __func__);

  NSInteger row = [indexPath row];
  NSDictionary *org = [[self organizations] objectAtIndex: row];
  //NSLog(@"%s: org=%@", __func__, org);

  self.detailView.data = org;
  [self.detailView configure];
}


#pragma mark -
#pragma mark Memory management

- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
}

- (void)viewDidUnload
{
  self.name = nil;
  self.organizations = nil;
}

- (void)dealloc {
  [[NSNotificationCenter defaultCenter] removeObserver:self];
  self.name = nil;
  self.organizations = nil;
  [super dealloc];
}

@end

// vim: set ts=2 sw=2 expandtab:
