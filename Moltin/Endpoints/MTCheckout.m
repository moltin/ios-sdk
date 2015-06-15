//
//  MTCheckout.m
//  MoltinSDK
//
//  Created by Gasper Rebernak on 10/06/15.
//  Copyright (c) 2015 Gasper Rebernak. All rights reserved.
//

#import "MTCheckout.h"

@implementation MTCheckout

- (id)init{
    return [super initWithEndpoint:@"checkout"];
}

- (void)paymentWithMethod:(NSString *) method order:(NSString *) order parameters:(NSDictionary *) parameters callback:(void (^)(NSDictionary *response, NSError *error))completion{
    NSString *endpoint = [NSString stringWithFormat:@"%@/payment/%@/%@", self.endpoint, method, order];
    [super postWithEndpoint:endpoint andParameters:parameters callback:completion];
}

@end
