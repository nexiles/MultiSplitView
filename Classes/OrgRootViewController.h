//
//  OrgRootViewController.h
//  MultiSplitView
//
//  Created by Stephan Eletzhofer on 09.03.11.
//  Copyright 2011 Nexiles GmbH. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "OrgDetailViewController.h"

@interface OrgRootViewController : UITableViewController {

  NSString                         * _name;
  NSArray                          * _organizations;

  IBOutlet OrgDetailViewController * detailView;
}

@property (nonatomic, retain) NSString                * name;
@property (nonatomic, retain) OrgDetailViewController * detailView;
@property (nonatomic, retain) NSArray                 * organizations;

-(void)configure:(NSDictionary *)info;

@end

// vim: set ts=2 sw=2 expandtab:
