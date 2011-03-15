//
//  ViewRegistry.m
//  MultiSplitView
//
//  Created by Stephan Eletzhofer on 09.03.11.
//  Copyright 2011 Nexiles GmbH. All rights reserved.
//

#import "ViewRegistry.h"

@implementation ViewRegistry
static ViewRegistry* _sharedViewRegistry = nil;

@synthesize registry = _registry;
 
#pragma mark -
#pragma mark Singleton

+(ViewRegistry*)sharedViewRegistry
{
	@synchronized([ViewRegistry class])
	{
		if (!_sharedViewRegistry)
			[[self alloc] init];
 
		return _sharedViewRegistry;
	}
 
	return nil;
}
 
+(id)alloc
{
	@synchronized([ViewRegistry class])
	{
		NSAssert(_sharedViewRegistry == nil, @"Attempted to allocate a second instance of a singleton.");
		_sharedViewRegistry = [super alloc];
		return _sharedViewRegistry;
	}
 
	return nil;
}
 
-(id)init {
  NSLog(@"%s", __func__);
	self = [super init];
	if (self != nil) {
		_registry = [[NSMutableDictionary alloc] init];
	}
 
	return self;
}


#pragma mark -
#pragma mark View Registration
 
-(void)registerViewController:(id)controller forName:(NSString *)name
{
  NSLog(@"%s: name=%@", __func__, name);
  NSLog(@"%s: controller=%@", __func__, controller);
  
  [_registry setObject:controller forKey:name];
}

- (void)registerRootController:(BaseRootViewController *)controller forName:(NSString *)name
{
  NSString *key = [NSString stringWithFormat:@"%@.root", name];
  [self registerViewController:controller forName:key];
}

- (void)registerDetailController:(BaseDetailViewController *)controller forName:(NSString *)name
{
  NSString *key = [NSString stringWithFormat:@"%@.detail", name];
  [self registerViewController:controller forName:key];
}

-(UIViewController *)controllerForName:(NSString *)name
{
  NSLog(@"%s: name=%@", __func__, name);
  return [_registry objectForKey:name];
}

-(BaseRootViewController *)rootControllerForName:(NSString *)name
{
  NSString *key = [NSString stringWithFormat:@"%@.root", name];
  return [_registry objectForKey:key];
}

-(BaseDetailViewController *)detailControllerForName:(NSString *)name
{
  NSString *key = [NSString stringWithFormat:@"%@.detail", name];
  return [_registry objectForKey:key];
}

@end

// vim: set ts=2 sw=2 expandtab:
