//
//  NXWindchillDataLoader.m
//  MultiSplitView
//
//  Created by Stephan Eletzhofer on 17.03.11.
//  Copyright 2011 Nexiles GmbH. All rights reserved.
//

#import "NXWindchillDataLoader.h"
#import "NSString+SBJSON.h"


static NXWindchillDataLoader *_sharedLoader = nil;

@implementation NXWindchillDataLoader

@synthesize baseURL = _baseURL;
@synthesize password = _password;
@synthesize username = _username;

-(NSURL *)URLForModule:(NSString *)m method:(NSString *)f parameters:(NSDictionary *)params
{
    NSLog(@"%s: self.baseURL=%@", __func__, self.baseURL);
    NSLog(@"%s: m=%@", __func__, m);
    NSLog(@"%s: f=%@", __func__, f);



    NSString *query = @"";
    for (NSString *key in params) {
        query = [query stringByAppendingFormat:@"&%@=%@",
                          key,
                          [[params objectForKey:key] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    }

    NSString *path = [NSString stringWithFormat:@"%@/json.jsp?m=%@&f=%@", self.baseURL, m, f];
    if (query) {
       path = [path stringByAppendingString:query];
    }
    NSLog(@"%s: path=%@", __func__, path);

    NSURL *url = [NSURL URLWithString:path];

    NSLog(@"%s: url=%@", __func__, url);
    return url;
}

-(void)fireRequestForURL:(NSURL *)url success:(void (^)(NSDictionary *data))success failure:(void (^)(ASIHTTPRequest *))failure
{
    __block ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url];

    request.username = self.username;
    request.password = self.password;

    [request setDelegate:self];
    [request setCompletionBlock:^{
        NSLog(@"%s: (CompletionBlock) request=%@", __func__, request);
        NSString *responseString = [request responseString];
        NSLog(@"%s: responseString=%@", __func__, responseString);

        success([responseString JSONValue]);
    }];
    [request setFailedBlock:^{
        NSLog(@"%s: (FailureBlock) request=%@", __func__, request);
        if (failure) {
            failure(request);
        }
    }];
    [request startAsynchronous];
}

-(void)getOrganizationsWithSuccess:(void (^)(NSDictionary *data))success failure:(void (^)(ASIHTTPRequest *))failure
{
    NSLog(@"%s", __func__);
    NSURL *url = [self URLForModule:@"list" method:@"get_organizations" parameters:nil];
    NSLog(@"%s: url=%@", __func__, url);

    [self fireRequestForURL:url success:success failure:failure];
}

-(void)getProductsForOrganization:(NSString *)oid success:(void (^)(NSDictionary *data))success failure:(void (^)(ASIHTTPRequest *))failure;
{
    NSLog(@"%s", __func__);
    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys: oid, @"oid", nil];
    NSURL *url = [self URLForModule:@"list" method:@"get_product" parameters:params];
    NSLog(@"%s: url=%@", __func__, url);

    [self fireRequestForURL:url success:success failure:failure];
}

-(void)getDocumentInfoForOID:(NSString *)oid success:(void (^)(NSDictionary *data))success failure:(void (^)(ASIHTTPRequest *))failure;
{
    NSLog(@"%s", __func__);
    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys: oid, @"oid", nil];
    NSURL *url = [self URLForModule:@"list" method:@"get_epm_document" parameters:params];
    NSLog(@"%s: url=%@", __func__, url);

    [self fireRequestForURL:url success:success failure:failure];
}

#pragma mark -
#pragma mark singleton
+(NXWindchillDataLoader *)sharedLoader
{
  @synchronized([NXWindchillDataLoader class])
  {
    if (!_sharedLoader)
      [[self alloc] init];
    return _sharedLoader;
  }
  return nil;
}

+(id)alloc
{
  @synchronized([NXWindchillDataLoader class])
  {
    NSAssert(_sharedLoader == nil, @"Attempted to allocate a second instance of a singleton.");
    _sharedLoader = [super alloc];
    return _sharedLoader;
  }

  return nil;
}

-(id)init {
  NSLog(@"%s", __func__);
  self = [super init];
  if (self != nil) {
    self.baseURL = @"http://wc.nexiles.com/Windchill";
    self.username = @"wcadmin";
    self.password = @"wcadmin";
  }

  return self;
}

@end
// vim: set sw=4 ts=4 expandtab:
