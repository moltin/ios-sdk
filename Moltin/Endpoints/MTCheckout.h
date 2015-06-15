//
//  MTCheckout.h
//  MoltinSDK
//
//  Created by Gasper Rebernak on 10/06/15.
//  Copyright (c) 2015 Gasper Rebernak. All rights reserved.
//

#import "MTFacade.h"

@interface MTCheckout : MTFacade

- (void)paymentWithMethod:(NSString *) method order:(NSString *) order parameters:(NSDictionary *) parameters callback:(void (^)(NSDictionary *response, NSError *error))completion;

@end
