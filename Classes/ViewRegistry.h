//
//  ViewRegistry.h
//  MultiSplitView
//
//  Created by Stephan Eletzhofer on 09.03.11.
//  Copyright 2011 Nexiles GmbH. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface ViewRegistry : NSObject {
	NSMutableDictionary *_registry;
}

@property (readonly) NSMutableDictionary *registry;

+(ViewRegistry *)sharedViewRegistry;

-(void)registerViewController:(id)controller forName:(NSString *)name;
-(id)controllerForName:(NSString *)name;

@end

// vim: set ts=2 sw=2 expandtab:
