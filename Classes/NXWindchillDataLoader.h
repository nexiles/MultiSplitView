//
//  NXWindchillDataLoader.h
//  MultiSplitView
//
//  Created by Stephan Eletzhofer on 17.03.11.
//  Copyright 2011 Nexiles GmbH. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "ASIHTTPRequest.h"


@interface NXWindchillDataLoader : NSObject {

    NSString * _baseURL;
    NSString * _username;
    NSString * _password;

}

@property (retain) NSString *baseURL;
@property (retain) NSString *username;
@property (retain) NSString *password;

+(NXWindchillDataLoader *)sharedLoader;

-(void)fireRequestForURL:(NSURL *)url success:(void (^)(NSDictionary *data))success failure:(void (^)(ASIHTTPRequest *))failure;
-(void)getOrganizationsWithSuccess:(void (^)(NSDictionary *data))success failure:(void (^)(ASIHTTPRequest *))failure;
-(void)getProductsForOrganization:(NSString *)oid success:(void (^)(NSDictionary *data))success failure:(void (^)(ASIHTTPRequest *))failure;
-(void)getDocumentInfoForOID:(NSString *)oid success:(void (^)(NSDictionary *data))success failure:(void (^)(ASIHTTPRequest *))failure;
@end
// vim: set sw=4 ts=4 expandtab:
