//
//  MoltinProduct.m
//  MoltinSDK
//
//  Created by Moltin on 10/06/15.
//  Copyright (c) 2015 Moltin. All rights reserved.
//

#import "MTProduct.h"
#import "MoltinAPIClient.h"

@implementation MTProduct

- (id)init{
    return [super initWithEndpoint:@"products"];
}

- (void)searchWithParameters:(NSDictionary *) parameters success:(MTSuccessCallback)success failure:(MTFailureCallback)failure{
    NSString *endpoint = [NSString stringWithFormat:@"%@/search", self.endpoint];
    [[MoltinAPIClient sharedClient] get:endpoint withParameters:parameters success:success failure:failure];
}

- (void)getModifiersWithId:(NSString *) productId success:(MTSuccessCallback)success failure:(MTFailureCallback)failure{
    NSString *endpoint = [NSString stringWithFormat:@"%@/%@/modifiers", self.endpoint, productId];
    [[MoltinAPIClient sharedClient] get:endpoint withParameters:nil success:success failure:failure];
}

- (void)getVariationsWithId:(NSString *) productId success:(MTSuccessCallback)success failure:(MTFailureCallback)failure
{
    NSString *endpoint = [NSString stringWithFormat:@"%@/%@/variations", self.endpoint, productId];
    [[MoltinAPIClient sharedClient] get:endpoint withParameters:nil success:success failure:failure];
}

@end
