//
//  OrgViewController.h
//  MultiSplitView
//
//  Created by Stephan Eletzhofer on 09.03.11.
//  Copyright 2011 Nexiles GmbH. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface OrgDetailViewController : UIViewController <UIPopoverControllerDelegate, UISplitViewControllerDelegate> {

  NSString    * _name;
  NSArray     * _products;
    NSDictionary * _data;

  UIToolbar   * _toolBar;
  UITableView * _tableView;
}

@property (nonatomic, retain) NSString    * name;
@property (nonatomic, retain) NSArray     * products;
@property (nonatomic, retain) NSDictionary    * data;

@property (nonatomic, retain) IBOutlet UITableView * tableView;
@property (nonatomic, retain) IBOutlet UIToolbar   * toolBar;

-(void)configure;

@end
// vim: set ts=2 sw=2 expandtab:
