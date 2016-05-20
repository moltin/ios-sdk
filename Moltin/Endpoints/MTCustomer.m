//
//  MTCustomer.m
//  MoltinSDK iOS Example
//
//  Created by Moltin on 15/06/15.
//  Copyright (c) 2015 Moltin. All rights reserved.
//

#import "MTCustomer.h"

@implementation MTCustomer

- (id)init{
    return [super initWithEndpoint:@"customers"];
}


-(void)loginWithEmail:(NSString *)email andPassword:(NSString *)password success:(MTSuccessCallback)success failure:(MTFailureCallback)failure{
    NSString *endpoint = [NSString stringWithFormat:@"%@/token", self.endpoint];

    NSDictionary *parameters = @{@"email": email, @"password": password};

    [super postWithEndpoint:endpoint andParameters:parameters success:^(NSDictionary *response) {
        if (success) {
            success(response);
        }
    } failure:^(NSDictionary *response, NSError *error) {
        if (failure) {
            failure(response, error);
        }
    }];
}

-(void)loginWithCustomerId:(NSString *)customerId andPassword:(NSString *)password success:(MTSuccessCallback)success failure:(MTFailureCallback)failure{
    NSString *endpoint = [NSString stringWithFormat:@"%@/token", self.endpoint];

    NSDictionary *parameters = @{@"id": customerId, @"password": password};

    [super postWithEndpoint:endpoint andParameters:parameters success:^(NSDictionary *response) {
        if (success) {
            success(response);
        }
    } failure:^(NSDictionary *response, NSError *error) {
        if (failure) {
            failure(response, error);
        }
    }];


}

-(void)updateCustomerWithToken:(NSString*)token andParameters:(NSDictionary*)parameters success:(MTSuccessCallback)success failure:(MTFailureCallback)failure{
    NSString *endpoint = [NSString stringWithFormat:@"%@/%@", self.endpoint, token];

    [super putWithEndpoint:endpoint andParameters:parameters success:^(NSDictionary *response) {
        if (success) {
            success(response);
        }
    } failure:^(NSDictionary *response, NSError *error) {
        if (failure) {
            failure(response, error);
        }
    }];


}

-(void)getCustomerAddressesWithToken:(NSString*)token success:(MTSuccessCallback)success failure:(MTFailureCallback)failure {
    NSString *endpoint = [NSString stringWithFormat:@"%@/%@/addresses", self.endpoint, token];

    [super getWithEndpoint:endpoint andParameters:nil success:^(NSDictionary *response) {
        if (success) {
            success(response);
        }
    } failure:^(NSDictionary *response, NSError *error) {
        if (failure) {
            failure(response, error);
        }
    }];


}

-(void)getCustomerOrdersWithToken:(NSString*)token success:(MTSuccessCallback)success failure:(MTFailureCallback)failure {
    NSString *endpoint = [NSString stringWithFormat:@"%@/orders", self.endpoint];

    NSDictionary *parameters = @{@"customer": token};

    [super getWithEndpoint:endpoint andParameters:parameters success:^(NSDictionary *response) {
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
