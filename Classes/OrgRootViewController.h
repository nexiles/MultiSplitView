//
//  OrgRootViewController.h
//  MultiSplitView
//
//  Created by Stephan Eletzhofer on 09.03.11.
//  Copyright 2011 Nexiles GmbH. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "BaseRootViewController.h"

@interface OrgRootViewController : BaseRootViewController {
  NSString                         * _name;
  NSArray                          * _organizations;
}

@property (nonatomic, retain) NSString                * name;
@property (nonatomic, retain) NSArray                 * organizations;

-(void)configure;

@end

// vim: set ts=2 sw=2 expandtab:
