//
//  MTAddress.h
//  MoltinSDK
//
//  Created by Moltin on 10/06/15.
//  Copyright (c) 2015 Moltin. All rights reserved.
//

#import "MTFacade.h"

@interface MTAddress : MTFacade

- (void)getWithCustomerId:(NSString *)customerId andAddressId:(NSString *) addressId success:(MTSuccessCallback)success failure:(MTFailureCallback)failure;
- (void)findWithCustomerId:(NSString *)customerId andParameters:(NSDictionary *) parameters success:(MTSuccessCallback)success failure:(MTFailureCallback)failure;
- (void)listingWithCustomerId:(NSString *)customerId andParameters:(NSDictionary *) parameters success:(MTSuccessCallback)success failure:(MTFailureCallback)failure;
- (void)fieldsWithCustomerId:(NSString *)customerId andAddressId:(NSString *) addressId success:(MTSuccessCallback)success failure:(MTFailureCallback)failure;

@end
