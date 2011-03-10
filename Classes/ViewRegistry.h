//
//  ViewRegistry.h
//  MultiSplitView
//
//  Created by Stephan Eletzhofer on 09.03.11.
//  Copyright 2011 Nexiles GmbH. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol ConfigurableViewController <NSObject>

-(void)configure:(NSDictionary *)info;

@end

@interface ViewRegistry : NSObject {
	NSMutableDictionary *_registry;
}

@property (readonly) NSMutableDictionary *registry;

+(ViewRegistry *)sharedViewRegistry;

// Single Controllers
-(void)registerViewController:(id <ConfigurableViewController>)controller forName:(NSString *)name;
-(id <ConfigurableViewController>)controllerForName:(NSString *)name;

// Root/Detail VCs
- (void)registerRootController:(id <ConfigurableViewController>)controller forName:(NSString *)name;
- (void)registerDetailController:(id <ConfigurableViewController>)controller forName:(NSString *)name;

@end

// vim: set ts=2 sw=2 expandtab:
