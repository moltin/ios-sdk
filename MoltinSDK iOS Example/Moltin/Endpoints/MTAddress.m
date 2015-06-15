//
//  MTAddress.m
//  MoltinSDK
//
//  Created by Gasper Rebernak on 10/06/15.
//  Copyright (c) 2015 Gasper Rebernak. All rights reserved.
//

#import "MTAddress.h"

@implementation MTAddress

- (id)init{
    return [super initWithEndpoint:@"addresses"];
}

-(void)getWithId:(NSString *)ID callback:(void (^)(NSDictionary *, NSError *))completion
{
    [super raiseUnsupportedException];
}

- (void)getWithCustomerId:(NSString *)customerId andAddressId:(NSString *) addressId callback:(void (^)(NSDictionary *response, NSError *error))completion
{
    NSString *endpoint = [NSString stringWithFormat:@"customers/%@/%@/%@", customerId, self.endpoint, addressId];
    [super getWithEndpoint:endpoint andParameters:nil callback:completion];
}

-(void)createWithCustomerId:(NSString *)customerId Parameters:(NSDictionary *)parameters callback:(void (^)(NSDictionary *response, NSError *error))completion
{
    NSString *endpoint = [NSString stringWithFormat:@"customers/%@/%@", customerId, self.endpoint];
    [super postWithEndpoint:endpoint andParameters:parameters callback:completion];
}

-(void)updateWithCustomerId:(NSString *)customerId Parameters:(NSDictionary *)parameters callback:(void (^)(NSDictionary *response, NSError *error))completion
{
    NSString *endpoint = [NSString stringWithFormat:@"customers/%@/%@", customerId, self.endpoint];
    [super putWithEndpoint:endpoint andParameters:parameters callback:completion];
}

- (void)findWithCustomerId:(NSString *)customerId andParameters:(NSDictionary *) parameters callback:(void (^)(NSDictionary *response, NSError *error))completion{
    NSString *endpoint = [NSString stringWithFormat:@"customers/%@/%@", customerId, self.endpoint];
    [super getWithEndpoint:endpoint andParameters:parameters callback:completion];
}

- (void)listingWithCustomerId:(NSString *)customerId andParameters:(NSDictionary *) parameters callback:(void (^)(NSDictionary *response, NSError *error))completion{
    NSString *endpoint = [NSString stringWithFormat:@"customers/%@/%@", customerId, self.endpoint];
    [super getWithEndpoint:endpoint andParameters:parameters callback:completion];
}

- (void)fieldsWithCustomerId:(NSString *)customerId andAddressId:(NSString *) addressId callback:(void (^)(NSDictionary *response, NSError *error))completion
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
    [super getWithEndpoint:endpoint andParameters:nil callback:completion];
}

@end
