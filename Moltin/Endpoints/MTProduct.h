//
//  MTProduct.h
//  MoltinSDK
//
//  Created by Gasper Rebernak on 10/06/15.
//  Copyright (c) 2015 Gasper Rebernak. All rights reserved.
//

#import "MTFacade.h"

@interface MTProduct : MTFacade

- (void)searchWithParameters:(NSDictionary *) parameters success:(MTSuccessCallback)success failure:(MTFailureCallback)failure;

- (void)getModifiersWithId:(NSString *) productId success:(MTSuccessCallback)success failure:(MTFailureCallback)failure;

- (void)getVariationsWithId:(NSString *) productId success:(MTSuccessCallback)success failure:(MTFailureCallback)failure;

@end
