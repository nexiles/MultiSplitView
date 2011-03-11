//
//  OrgViewController.h
//  MultiSplitView
//
//  Created by Stephan Eletzhofer on 09.03.11.
//  Copyright 2011 Nexiles GmbH. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface OrgDetailViewController : UITableViewController <UIPopoverControllerDelegate, UISplitViewControllerDelegate> {

  NSString             * _name;
  NSArray              * _products;

  IBOutlet UITableView * tableView;
}

@property (nonatomic, retain) NSString    * name;
@property (nonatomic, retain) NSArray     * products;

@property (nonatomic, retain) UITableView * tableView;

-(void)configure:(NSDictionary *)info;

@end
// vim: set ts=2 sw=2 expandtab:
