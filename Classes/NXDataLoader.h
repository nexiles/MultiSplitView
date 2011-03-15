//
//  NXDataLoader.h
//  MultiSplitView
//
//  Created by Stephan Eletzhofer on 09.03.11.
//  Copyright 2011 Nexiles GmbH. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NSString+SBJSON.h"


@interface NXDataLoader : NSObject {

}

+(NXDataLoader *)sharedLoader;

-(id)loadBundledJSON:(NSString *)name;

// load data using the OID key
-(id)loadOID:(NSString *)oid;

@end
