//
//  DocumentRootViewController.h
//  MultiSplitView
//
//  Created by Stephan Eletzhofer on 15.03.11.
//  Copyright 2011 Nexiles GmbH. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseDetailViewController.h"

@interface DocumentRootViewController : BaseRootViewController {
	NSString * _name;
	NSArray * _documents;
}

@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSArray  * documents;

@end
