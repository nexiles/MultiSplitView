//
//  OrgViewController.h
//  MultiSplitView
//
//  Created by Stephan Eletzhofer on 09.03.11.
//  Copyright 2011 Nexiles GmbH. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "BaseDetailViewController.h"

@interface OrgDetailViewController : BaseDetailViewController {
  NSString    * _name;
  NSArray     * _products;
}

@property (nonatomic, retain) NSString    * name;
@property (nonatomic, retain) NSArray     * products;

-(void)configure;

@end
// vim: set ts=2 sw=2 expandtab:
