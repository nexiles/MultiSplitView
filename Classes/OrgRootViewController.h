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

  NSArray          * _organizations;

  IBOutlet OrgRootViewController * detailView;
}

@property (nonatomic, retain) OrgRootViewController * detailView;
@property (nonatomic, retain) NSArray               * organizations;

-(void)configure:(NSDictionary *)info;

@end

// vim: set ts=2 sw=2 expandtab:
