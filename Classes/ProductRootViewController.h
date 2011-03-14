//
//  ProductRootViewController.h
//  MultiSplitView
//
//  Created by Stephan Eletzhofer on 11.03.11.
//  Copyright 2011 Nexiles GmbH. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "ProductDetailViewController.h"

@interface ProductRootViewController : UITableViewController {
  NSString * _name;
  NSArray  * _products;

  NSDictionary *_data;

  ProductDetailViewController * _detailView;
  UITableView                 * _tableView;
}

@property (nonatomic, retain) IBOutlet ProductDetailViewController * detailView;
@property (nonatomic, retain) IBOutlet UITableView                 * tableView;

@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSArray  * products;
@property (nonatomic, retain) NSDictionary  * data;

-(void)configure;

@end
// vim: set ts=2 sw=2 expandtab:
