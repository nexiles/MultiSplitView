//
//  NXDataLoader.m
//  MultiSplitView
//
//  Created by Stephan Eletzhofer on 09.03.11.
//  Copyright 2011 Nexiles GmbH. All rights reserved.
//

#import "NXDataLoader.h"
#import "NSString+SBJSON.h"

@implementation NXDataLoader

#pragma mark -
#pragma mark Data Loading

static NXDataLoader *_sharedNXDataLoader = nil;

-(id)loadBundledJSON:(NSString *)name
{
  NSLog(@"%s: name=%@", __func__, name);
  
  NSString *filePath    = [[NSBundle mainBundle] pathForResource:name ofType:@"json"];  
  NSData *data          = [NSData dataWithContentsOfFile:filePath];  
  NSString *jsonString  = [[[NSString alloc] initWithData:data
                                                 encoding:NSUTF8StringEncoding] autorelease];

  id json = [jsonString JSONValue];
  NSLog(@"%s: json=%@", __func__, json);
  
  return json;
}

#pragma mark -
#pragma mark Singleton

+(NXDataLoader *)sharedLoader
{
  @synchronized([NXDataLoader class])
  {
    if (!_sharedNXDataLoader)
      [[self alloc] init];

    return _sharedNXDataLoader;
  }

  return nil;
}

+(id)alloc
{
  @synchronized([NXDataLoader class])
  {
    NSAssert(_sharedNXDataLoader == nil, @"Attempted to allocate a second instance of a singleton.");
    _sharedNXDataLoader = [super alloc];
    return _sharedNXDataLoader;
  }

  return nil;
}

-(id)init {
  NSLog(@"%s", __func__);
  self = [super init];
  if (self != nil) {
    //
  }

  return self;
}

@end

// vim: set ts=2 sw=2 expandtab:
