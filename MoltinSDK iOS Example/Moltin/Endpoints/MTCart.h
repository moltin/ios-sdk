//
//  MTCart.h
//  MoltinSDK
//
//  Created by Gasper Rebernak on 10/06/15.
//  Copyright (c) 2015 Gasper Rebernak. All rights reserved.
//

#import "MTFacade.h"

@interface MTCart : MTFacade

- (void)getContentsWithCallback:(void (^)(NSDictionary *, NSError *))completion;
- (void)insertItemWithId:(NSString *) itemId quantity:(NSInteger) quantity andModifiersOrNil:(NSDictionary *) modifiers callback:(void (^)(NSDictionary *, NSError *))completion;
- (void)updateItemWithId:(NSString *) itemId parameters:(NSDictionary *) parameters callback:(void (^)(NSDictionary *, NSError *))completion;
- (void)removeItemWithId:(NSString *) itemId callback:(void (^)(NSDictionary *, NSError *))completion;
- (void)getItemWithId:(NSString *) itemId callback:(void (^)(NSDictionary *, NSError *))completion;
- (void)isItemInCart:(NSString *) itemId callback:(void (^)(NSDictionary *, NSError *))completion;
- (void)checkoutWithCallback:(void (^)(NSDictionary *, NSError *))completion;
- (void)orderWithParameters:(NSDictionary *) parameters callback:(void (^)(NSDictionary *, NSError *))completion;
- (void)discountWithCode:(NSString *) code callback:(void (^)(NSDictionary *, NSError *))completion;

@end
