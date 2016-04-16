//
//  MTCustomer.h
//  MoltinSDK iOS Example
//
//  Created by Moltin on 15/06/15.
//  Copyright (c) 2015 Moltin. All rights reserved.
//

#import "MTFacade.h"

@interface MTCustomer : MTFacade

-(void)loginWithEmail:(NSString *)email andPassword:(NSString *)password success:(MTSuccessCallback)success failure:(MTFailureCallback)failure;
-(void)loginWithCustomerId:(NSString *)customerId andPassword:(NSString *)password success:(MTSuccessCallback)success failure:(MTFailureCallback)failure;
-(void)updateCustomerWithToken:(NSString*)token andParameters:(NSDictionary*)parameters success:(MTSuccessCallback)success failure:(MTFailureCallback)failure;
-(void)getCustomerAddressesWithToken:(NSString*)token success:(MTSuccessCallback)success failure:(MTFailureCallback)failure;
-(void)getCustomerOrdersWithToken:(NSString*)token success:(MTSuccessCallback)success failure:(MTFailureCallback)failure;


@end
