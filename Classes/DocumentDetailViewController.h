//
//  DocumentDetailViewController.h
//  MultiSplitView
//
//  Created by Stephan Eletzhofer on 15.03.11.
//  Copyright 2011 Nexiles GmbH. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseDetailViewController.h"

@interface DocumentDetailViewController : BaseDetailViewController {
    NSString * _oid;
    NSString * _name;
    NSString * _number;
    NSString * _cadname;

    NSArray  * _attributes;
    NSArray  * _uses;
    NSArray  * _usedBy;
}

@property (nonatomic,retain) NSString * oid;
@property (nonatomic,retain) NSString * name;
@property (nonatomic,retain) NSString * number;
@property (nonatomic,retain) NSString * cadname;
@property (nonatomic,retain) NSArray  * attributes;
@property (nonatomic,retain) NSArray  * uses;
@property (nonatomic,retain) NSArray  * usedBy;

@end
// vim: set sw=4 ts=4 expandtab:
