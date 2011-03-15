//
//  DocumentDetailViewController.m
//  MultiSplitView
//
//  Created by Stephan Eletzhofer on 15.03.11.
//  Copyright 2011 Nexiles GmbH. All rights reserved.
//

#import "DocumentDetailViewController.h"
#import "NXDataLoader.h"

enum {
	kDocDetailsSection = 0,
	kAttributesSection,
	kUsesSection,
	kUsedBySection,
	kMaxSections // !!! last
};


@implementation DocumentDetailViewController

@synthesize oid        = _oid;
@synthesize name       = _name;
@synthesize number     = _number;
@synthesize cadname    = _cadname;
@synthesize attributes = _attributes;
@synthesize uses       = _uses;
@synthesize usedBy     = _usedBy;

-(void)configure
{
  self.name       = [self.data objectForKey:@"name"];
  self.oid        = [self.data objectForKey:@"oid"];
  self.cadname    = [self.data objectForKey:@"cadname"];
  self.attributes = [self.data objectForKey:@"attributes"];
  self.uses       = [self.data objectForKey:@"uses"];
  self.usedBy     = [self.data objectForKey:@"usedBy"];

  if (self.popoverController != nil) {
    [self.popoverController dismissPopoverAnimated:YES];
  }

  self.title = self.name;
  [[self tableView] reloadData];
}

#pragma mark -
#pragma mark View lifecycle

- (void)viewDidLoad {
  [super viewDidLoad];

  // load default org
  NXDataLoader *loader = [NXDataLoader sharedLoader];
  NSDictionary *p = [loader loadBundledJSON:@"document-default"];
  self.data = p;
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
		case kDocDetailsSection:
			return @"Name and Number";
			break;
		case kAttributesSection:
			return @"Attributes";
			break;
		case kUsedBySection:
			return @"Used By";
			break;
		case kUsesSection:
			return @"Uses";
			break;
		default:
			return 0;
	}
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	// Return the number of rows in the section.
	switch (section) {
		case kDocDetailsSection:
			return 4;
			break;
		case kAttributesSection:
			return self.attributes.count;
			break;
		case kUsedBySection:
			return self.usedBy.count;
			break;
		case kUsesSection:
			return self.uses.count;
			break;
		default:
			return 0;
	}
}

-(UITableViewCell *)productDetailForRow:(NSInteger)row tableView:(UITableView *)tableView
{
  //NSLog(@"%s", __func__);
  static NSString *CellIdentifier = @"DocDetailCell";

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
      text = @"Number";
      detail = self.number;
      break;
    case 3:
      text = @"CAD Name";
      detail = self.cadname;
      break;
  }

  cell.textLabel.text = text;
  cell.detailTextLabel.text = detail;

  return cell;
}

-(UITableViewCell *)attributeCellForAttribute:(NSDictionary *)attr tableView:(UITableView *)tableView
{
  //NSLog(@"%s", __func__);
  static NSString *CellIdentifier = @"AttributeCell";

  UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
  if (cell == nil) {
    cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1
                                   reuseIdentifier:CellIdentifier] autorelease];
    //cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
  }

  cell.textLabel.text       = [attr objectForKey:@"name"];
  cell.detailTextLabel.text = [attr objectForKey:@"value"];

  return cell;
}

-(UITableViewCell *)refCellForRef:(NSDictionary *)reference tableView:(UITableView *)tableView
{
  //NSLog(@"%s", __func__);
  static NSString *CellIdentifier = @"ReferenceCell";

  UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
  if (cell == nil) {
    cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1
                                   reuseIdentifier:CellIdentifier] autorelease];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
  }

  cell.textLabel.text       = [reference objectForKey:@"name"];
  cell.detailTextLabel.text = [reference objectForKey:@"oid"];

  return cell;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell;

    NSInteger row = [indexPath row];
    NSInteger section = [indexPath section];

    switch (section) {
      case kDocDetailsSection:
          cell = [self productDetailForRow:row tableView:tableView];
          break;
      case kAttributesSection: {
            NSDictionary *attr = [[self attributes] objectAtIndex:row];
            cell = [self attributeCellForAttribute:attr tableView:tableView];
        }
        break;
      case kUsesSection: {
            NSDictionary *d = [[self uses] objectAtIndex:row];
            cell = [self refCellForRef:d tableView:tableView];
        }
        break;
      case kUsedBySection: {
            NSDictionary *d = [[self usedBy] objectAtIndex:row];
            cell = [self refCellForRef:d tableView:tableView];
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

    self.attributes = nil;
    self.uses = nil;
    self.usedBy = nil;
    self.name = nil;
    self.cadname = nil;
    self.number = nil;
    self.oid = nil;
}


@end
// vim: set sw=4 ts=4 expandtab:

