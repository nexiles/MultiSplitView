//
//  DocumentRootViewController.m
//  MultiSplitView
//
//  Created by Stephan Eletzhofer on 15.03.11.
//  Copyright 2011 Nexiles GmbH. All rights reserved.
//

#import "DocumentRootViewController.h"

#import "ViewRegistry.h"
#import "NXDataLoader.h"

@implementation DocumentRootViewController

@synthesize name      = _name;
@synthesize documents = _documents;

- (void)configure
{
  self.documents = [self.data objectForKey:@"epm_documents"];
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

    self.name = @"Documents";
    self.controllerName = @"document";
    self.clearsSelectionOnViewWillAppear = NO;

    assert(self.tableView);

    // default data
    NXDataLoader *loader = [NXDataLoader sharedLoader];
    self.data = [loader loadBundledJSON:@"document-default"];

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
    return self.documents.count;
}


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
    
  NSInteger row = [indexPath row];
  NSDictionary *document = [self.documents objectAtIndex: row];
  cell.textLabel.text = [document objectForKey:@"name"];
  cell.detailTextLabel.text = [NSString stringWithFormat:@"%@ (%@)",
				  [document objectForKey:@"cadname"],
				  [document objectForKey:@"number"]];
    
    return cell;
}

#pragma mark -
#pragma mark Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

  NSInteger row = [indexPath row];
  NSDictionary *document = [self.documents objectAtIndex: row];
  self.detailView.data = document;
  [self.detailView configure];
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
    self.documents = nil;
    self.name = nil;
}


@end
// vim: set sw=4 ts=4 expandtab:

