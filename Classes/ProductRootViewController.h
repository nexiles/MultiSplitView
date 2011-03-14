//
//  ProductRootViewController.h
//  MultiSplitView
//
//  Created by Stephan Eletzhofer on 11.03.11.
//  Copyright 2011 Nexiles GmbH. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "BaseRootViewController.h"

@interface ProductRootViewController : BaseRootViewController {
  NSString * _name;
  NSArray  * _products;
}

@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSArray  * products;

-(void)configure;

@end
// vim: set ts=2 sw=2 expandtab:
