//
//  MoltinFacade.m
//  MoltinSDK
//
//  Created by Moltin on 10/06/15.
//  Copyright (c) 2015 Moltin. All rights reserved.
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
- (void)getWithId:(NSString *) ID success:(MTSuccessCallback)success failure:(MTFailureCallback)failure{
    NSString *endpoint = [NSString stringWithFormat:@"%@/%@", self.endpoint, ID];
    [[MoltinAPIClient sharedClient] get:endpoint withParameters:nil success:success failure:failure];
}

- (void)createWithParameters:(NSDictionary *) parameters success:(MTSuccessCallback)success failure:(MTFailureCallback)failure{
    NSString *endpoint = self.endpoint;
    [[MoltinAPIClient sharedClient] post:endpoint withParameters:parameters success:success failure:failure];
}

- (void)updateWithId:(NSString *) ID andParameters:(NSDictionary *) parameters success:(MTSuccessCallback)success failure:(MTFailureCallback)failure{
    NSString *endpoint = [NSString stringWithFormat:@"%@/%@", self.endpoint, ID];
    [[MoltinAPIClient sharedClient] put:endpoint withParameters:parameters success:success failure:failure];
}

- (void)deleteWithId:(NSString *) ID success:(MTSuccessCallback)success failure:(MTFailureCallback)failure{
    NSString *endpoint = [NSString stringWithFormat:@"%@/%@", self.endpoint, ID];
    [[MoltinAPIClient sharedClient] delete:endpoint withParameters:nil success:success failure:failure];
}

- (void)findWithParameters:(NSDictionary *) parameters success:(MTSuccessCallback)success failure:(MTFailureCallback)failure{
    NSString *endpoint = self.endpoint;
    [[MoltinAPIClient sharedClient] get:endpoint withParameters:parameters success:success failure:failure];
}

- (void)listingWithParameters:(NSDictionary *) parameters success:(MTSuccessCallback)success failure:(MTFailureCallback)failure{
    NSString *endpoint = self.endpoint;
    [[MoltinAPIClient sharedClient] get:endpoint withParameters:parameters success:success failure:failure];
}

- (void)fieldsWithId:(NSString *) ID success:(MTSuccessCallback)success failure:(MTFailureCallback)failure{
    NSString *endpoint = [self appendEndpointWith:@"fields" andIdOrNil:ID];
    [[MoltinAPIClient sharedClient] get:endpoint withParameters:nil success:success failure:failure];
}

- (NSString *)appendEndpointWith:(NSString *) appdend andIdOrNil:(NSString *) ID{
    NSString *_append = appdend;
    if (ID != nil && ID.length > 0) {
        _append = [NSString stringWithFormat:@"%@/%@", ID, appdend];
    }
    return [NSString stringWithFormat:@"%@/%@", self.endpoint, _append];
}


- (void)getWithEndpoint:(NSString *) endpoint andParameters:(NSDictionary *) parameters success:(MTSuccessCallback)success failure:(MTFailureCallback)failure
{
    [[MoltinAPIClient sharedClient] get:endpoint withParameters:parameters success:success failure:failure];
}

-(void)postWithEndpoint:(NSString *)endpoint andParameters:(NSDictionary *)parameters success:(MTSuccessCallback)success failure:(MTFailureCallback)failure
{
    [[MoltinAPIClient sharedClient] post:endpoint withParameters:parameters success:success failure:failure];
}

-(void)putWithEndpoint:(NSString *)endpoint andParameters:(NSDictionary *)parameters success:(MTSuccessCallback)success failure:(MTFailureCallback)failure
{
    [[MoltinAPIClient sharedClient] put:endpoint withParameters:parameters success:success failure:failure];
}

-(void)deleteWithEndpoint:(NSString *)endpoint success:(MTSuccessCallback)success failure:(MTFailureCallback)failure
{
    [[MoltinAPIClient sharedClient] delete:endpoint withParameters:nil success:success failure:failure];
}

-(void)raiseUnsupportedException
{
    [NSException raise:self.endpoint.uppercaseString format:@"Unsupported call for endpoint"];
}

@end
