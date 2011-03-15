//
//  ViewRegistry.h
//  MultiSplitView
//
//  Created by Stephan Eletzhofer on 09.03.11.
//  Copyright 2011 Nexiles GmbH. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#import "BaseRootViewController.h"
#import "BaseDetailViewController.h"

@interface ViewRegistry : NSObject {
	NSMutableDictionary *_registry;
}

@property (readonly) NSMutableDictionary *registry;

+(ViewRegistry *)sharedViewRegistry;

// Single Controllers
-(void)registerViewController:(UIViewController *)controller forName:(NSString *)name;
-(UIViewController *)controllerForName:(NSString *)name;

// Root/Detail VCs
- (void)registerRootController:(BaseRootViewController *)controller forName:(NSString *)name;
- (void)registerDetailController:(BaseDetailViewController *)controller forName:(NSString *)name;

-(BaseRootViewController *)rootControllerForName:(NSString *)name;
-(BaseDetailViewController *)detailControllerForName:(NSString *)name;

@end

// vim: set ts=2 sw=2 expandtab:
