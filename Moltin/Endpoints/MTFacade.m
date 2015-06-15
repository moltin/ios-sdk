//
//  MoltinFacade.m
//  MoltinSDK
//
//  Created by Gasper Rebernak on 10/06/15.
//  Copyright (c) 2015 Gasper Rebernak. All rights reserved.
//

#import "MTFacade.h"
#import "MoltinAPIClient.h"

@interface MTFacade()

@end

@implementation MTFacade

- (id)initWithEndpoint:(NSString *)endpoint
{
    self = [super init];
    if (self) {
        _endpoint = endpoint;
    }
    return self;
}
- (void)getWithId:(NSString *) ID callback:(void(^)(NSDictionary *response, NSError *error)) completion{
    NSString *endpoint = [NSString stringWithFormat:@"%@/%@", self.endpoint, ID];
    [[MoltinAPIClient sharedClient] get:endpoint withParameters:nil callback:completion];
}

- (void)createWithParameters:(NSDictionary *) parameters callback:(void(^)(NSDictionary *response, NSError *error)) completion{
    NSString *endpoint = self.endpoint;
    [[MoltinAPIClient sharedClient] post:endpoint withParameters:parameters callback:completion];
}

- (void)updateWithId:(NSString *) ID andParameters:(NSDictionary *) parameters callback:(void(^)(NSDictionary *response, NSError *error)) completion{
    NSString *endpoint = [NSString stringWithFormat:@"%@/%@", self.endpoint, ID];
    [[MoltinAPIClient sharedClient] put:endpoint withParameters:parameters callback:completion];
}

- (void)deleteWithId:(NSString *) ID callback:(void(^)(NSDictionary *response, NSError *error)) completion{
    NSString *endpoint = [NSString stringWithFormat:@"%@/%@", self.endpoint, ID];
    [[MoltinAPIClient sharedClient] delete:endpoint withParameters:nil callback:completion];
}

- (void)findWithParameters:(NSDictionary *) parameters callback:(void(^)(NSDictionary *response, NSError *error)) completion{
    NSString *endpoint = self.endpoint;
    [[MoltinAPIClient sharedClient] get:endpoint withParameters:parameters callback:completion];
}

- (void)listingWithParameters:(NSDictionary *) parameters callback:(void(^)(NSDictionary *response, NSError *error)) completion{
    NSString *endpoint = self.endpoint;
    [[MoltinAPIClient sharedClient] get:endpoint withParameters:parameters callback:completion];
}

- (void)fieldsWithId:(NSString *) ID callback:(void(^)(NSDictionary *response, NSError *error)) completion{
    NSString *endpoint = [self appendEndpointWith:@"fields" andIdOrNil:ID];
    [[MoltinAPIClient sharedClient] get:endpoint withParameters:nil callback:completion];
}

- (NSString *)appendEndpointWith:(NSString *) appdend andIdOrNil:(NSString *) ID{
    NSString *_append = appdend;
    if (ID != nil && ID.length > 0) {
        _append = [NSString stringWithFormat:@"%@/%@", ID, appdend];
    }
    return [NSString stringWithFormat:@"%@/%@", self.endpoint, _append];
}


- (void)getWithEndpoint:(NSString *) endpoint andParameters:(NSDictionary *) parameters callback:(void(^)(NSDictionary *response, NSError *error)) completion
{
    [[MoltinAPIClient sharedClient] get:endpoint withParameters:parameters callback:completion];
}

-(void)postWithEndpoint:(NSString *)endpoint andParameters:(NSDictionary *)parameters callback:(void (^)(NSDictionary *, NSError *))completion
{
    [[MoltinAPIClient sharedClient] post:endpoint withParameters:parameters callback:completion];
}

-(void)putWithEndpoint:(NSString *)endpoint andParameters:(NSDictionary *)parameters callback:(void (^)(NSDictionary *, NSError *))completion
{
    [[MoltinAPIClient sharedClient] put:endpoint withParameters:parameters callback:completion];
}

-(void)deleteWithEndpoint:(NSString *)endpoint callback:(void (^)(NSDictionary *, NSError *))completion
{
    [[MoltinAPIClient sharedClient] delete:endpoint withParameters:nil callback:completion];
}

-(void)raiseUnsupportedException
{
    [NSException raise:[NSString stringWithFormat:@"Unsupported call for %@ endpoint", self.endpoint.uppercaseString] format:nil];
}

@end
