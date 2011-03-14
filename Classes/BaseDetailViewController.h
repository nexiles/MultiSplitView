//
//  BaseDetailViewController.h
//  MultiSplitView
//
//  Created by Stephan Eletzhofer on 14.03.11.
//  Copyright 2011 Nexiles GmbH. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseRootViewController.h"

@interface BaseDetailViewController : BaseRootViewController <UIPopoverControllerDelegate, UISplitViewControllerDelegate> {

}

@property (nonatomic, retain) UIPopoverController * popoverController;
@property (nonatomic, retain) IBOutlet UIToolbar  * toolBar;

@end
