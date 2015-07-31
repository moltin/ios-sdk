//
//  MTAddress.m
//  MoltinSDK
//
//  Created by Moltin on 10/06/15.
//  Copyright (c) 2015 Moltin. All rights reserved.
//

#import "MTAddress.h"

@implementation MTAddress

- (id)init{
    return [super initWithEndpoint:@"addresses"];
}

-(void)getWithId:(NSString *)ID success:(MTSuccessCallback)success failure:(MTFailureCallback)failure
{
    [super raiseUnsupportedException];
}

- (void)getWithCustomerId:(NSString *)customerId andAddressId:(NSString *) addressId success:(MTSuccessCallback)success failure:(MTFailureCallback)failure
{
    NSString *endpoint = [NSString stringWithFormat:@"customers/%@/%@/%@", customerId, self.endpoint, addressId];
    [super getWithEndpoint:endpoint andParameters:nil success:success failure:failure];
}

-(void)createWithCustomerId:(NSString *)customerId Parameters:(NSDictionary *)parameters success:(MTSuccessCallback)success failure:(MTFailureCallback)failure
{
    NSString *endpoint = [NSString stringWithFormat:@"customers/%@/%@", customerId, self.endpoint];
    [super postWithEndpoint:endpoint andParameters:parameters success:success failure:failure];
}

-(void)updateWithCustomerId:(NSString *)customerId Parameters:(NSDictionary *)parameters success:(MTSuccessCallback)success failure:(MTFailureCallback)failure
{
    NSString *endpoint = [NSString stringWithFormat:@"customers/%@/%@", customerId, self.endpoint];
    [super putWithEndpoint:endpoint andParameters:parameters success:success failure:failure];
}

- (void)findWithCustomerId:(NSString *)customerId andParameters:(NSDictionary *) parameters success:(MTSuccessCallback)success failure:(MTFailureCallback)failure{
    NSString *endpoint = [NSString stringWithFormat:@"customers/%@/%@", customerId, self.endpoint];
    [super getWithEndpoint:endpoint andParameters:parameters success:success failure:failure];
}

- (void)listingWithCustomerId:(NSString *)customerId andParameters:(NSDictionary *) parameters success:(MTSuccessCallback)success failure:(MTFailureCallback)failure{
    NSString *endpoint = [NSString stringWithFormat:@"customers/%@/%@", customerId, self.endpoint];
    [super getWithEndpoint:endpoint andParameters:parameters success:success failure:failure];
}

- (void)fieldsWithCustomerId:(NSString *)customerId andAddressId:(NSString *) addressId success:(MTSuccessCallback)success failure:(MTFailureCallback)failure
{
    NSString *endpoint;
    if (customerId != nil && customerId.length > 0 && (addressId == nil || addressId.length == 0)) {
        endpoint = [NSString stringWithFormat:@"customers/%@/%@/fields", customerId, self.endpoint];
    }
    else if (customerId != nil && customerId.length > 0 && addressId != nil && addressId.length > 0) {
        endpoint = [NSString stringWithFormat:@"customers/%@/%@/%@/fields", customerId, self.endpoint, addressId];
    }
    else if ((customerId == nil && customerId.length == 0) && addressId != nil && addressId.length > 0) {
        endpoint = [NSString stringWithFormat:@"%@/%@/fields", self.endpoint, addressId];
    }
    else{
        endpoint = [NSString stringWithFormat:@"%@/fields", self.endpoint];
    }
    [super getWithEndpoint:endpoint andParameters:nil success:success failure:failure];
}

@end
