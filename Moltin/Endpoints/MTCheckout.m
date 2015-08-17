//
//  MTCheckout.m
//  MoltinSDK
//
//  Created by Moltin on 10/06/15.
//  Copyright (c) 2015 Moltin. All rights reserved.
//

#import "MTCheckout.h"
#import "MoltinStorage.h"

@implementation MTCheckout

- (id)init{
    return [super initWithEndpoint:@"checkout"];
}

- (void)paymentWithMethod:(NSString *) method order:(NSString *) order parameters:(NSDictionary *) parameters success:(MTSuccessCallback)success failure:(MTFailureCallback)failure{
    NSString *endpoint = [NSString stringWithFormat:@"%@/payment/%@/%@", self.endpoint, method, order];
    
    [super postWithEndpoint:endpoint andParameters:parameters success:^(NSDictionary *response) {
        //order completed reset cart id
        [MoltinStorage setCartId:nil];
        if (success) {
            success(response);
        }
    } failure:^(NSDictionary *response, NSError *error) {
        
        if (failure) {
            failure(response, error);
        }
    }];
}

@end
