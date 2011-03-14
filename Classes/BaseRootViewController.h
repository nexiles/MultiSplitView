//
//  BaseRootViewController.h
//  MultiSplitView
//
//  Created by Stephan Eletzhofer on 14.03.11.
//  Copyright 2011 Nexiles GmbH. All rights reserved.
//

#import <UIKit/UIKit.h>


@class BaseDetailViewController;

@interface BaseRootViewController : UITableViewController {
    NSString     * _controllerName;
    NSDictionary * _data;

    BaseDetailViewController * detailView;
}

@property (nonatomic, retain) NSString     * controllerName;
@property (nonatomic, retain) NSDictionary * data;

@property (nonatomic, retain) IBOutlet BaseRootViewController * detailView;

-(void)configure;

@end
// vim: set sw=4 ts=4 expandtab:
