//
//  OrgViewController.h
//  MultiSplitView
//
//  Created by Stephan Eletzhofer on 09.03.11.
//  Copyright 2011 Nexiles GmbH. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface OrgDetailViewController : UITableViewController {

    NSString * _name;
    NSArray  * _products;
}

@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSArray  * products;

-(void)configure:(NSDictionary *)info;

@end
// vim: set ts=2 sw=2 expandtab:
