//
//  MTCart.h
//  MoltinSDK
//
//  Created by Moltin on 10/06/15.
//  Copyright (c) 2015 Moltin. All rights reserved.
//

#import "MTFacade.h"

@interface MTCart : MTFacade


- (NSString*)generateNewCartIdentifier;
- (NSString *)identifier;
- (void)getContentsWithsuccess:(MTSuccessCallback)success failure:(MTFailureCallback)failure;
- (void)insertItemWithId:(NSString *) itemId quantity:(NSInteger) quantity andModifiersOrNil:(NSDictionary *) modifiers success:(MTSuccessCallback)success failure:(MTFailureCallback)failure;
- (void)updateItemWithId:(NSString *) itemId parameters:(NSDictionary *) parameters success:(MTSuccessCallback)success failure:(MTFailureCallback)failure;
- (void)removeItemWithId:(NSString *) itemId success:(MTSuccessCallback)success failure:(MTFailureCallback)failure;
- (void)getItemWithId:(NSString *) itemId success:(MTSuccessCallback)success failure:(MTFailureCallback)failure;
- (void)isItemInCart:(NSString *) itemId success:(MTSuccessCallback)success failure:(MTFailureCallback)failure;
- (void)checkoutWithsuccess:(MTSuccessCallback)success failure:(MTFailureCallback)failure;
- (void)orderWithParameters:(NSDictionary *) parameters success:(MTSuccessCallback)success failure:(MTFailureCallback)failure;
- (void)discountWithCode:(NSString *) code success:(MTSuccessCallback)success failure:(MTFailureCallback)failure;

@end
