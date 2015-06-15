//
//  MTAddress.h
//  MoltinSDK
//
//  Created by Gasper Rebernak on 10/06/15.
//  Copyright (c) 2015 Gasper Rebernak. All rights reserved.
//

#import "MTFacade.h"

@interface MTAddress : MTFacade

- (void)getWithCustomerId:(NSString *)customerId andAddressId:(NSString *) addressId callback:(void (^)(NSDictionary *, NSError *))completion;
- (void)findWithCustomerId:(NSString *)customerId andParameters:(NSDictionary *) parameters callback:(void (^)(NSDictionary *, NSError *))completion;
- (void)listingWithCustomerId:(NSString *)customerId andParameters:(NSDictionary *) parameters callback:(void (^)(NSDictionary *, NSError *))completion;
- (void)fieldsWithCustomerId:(NSString *)customerId andAddressId:(NSString *) addressId callback:(void (^)(NSDictionary *, NSError *))completion;

@end
