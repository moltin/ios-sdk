//
//  MTCart.h
//  MoltinSDK
//
//  Created by Gasper Rebernak on 10/06/15.
//  Copyright (c) 2015 Gasper Rebernak. All rights reserved.
//

#import "MTFacade.h"

@interface MTCart : MTFacade

- (void)getContentsWithCallback:(void (^)(NSDictionary *response, NSError *error))completion;
- (void)insertItemWithId:(NSString *) itemId quantity:(NSInteger) quantity andModifiersOrNil:(NSDictionary *) modifiers callback:(void (^)(NSDictionary *response, NSError *error))completion;
- (void)updateItemWithId:(NSString *) itemId parameters:(NSDictionary *) parameters callback:(void (^)(NSDictionary *response, NSError *error))completion;
- (void)removeItemWithId:(NSString *) itemId callback:(void (^)(NSDictionary *response, NSError *error))completion;
- (void)getItemWithId:(NSString *) itemId callback:(void (^)(NSDictionary *response, NSError *error))completion;
- (void)isItemInCart:(NSString *) itemId callback:(void (^)(NSDictionary *response, NSError *error))completion;
- (void)checkoutWithCallback:(void (^)(NSDictionary *response, NSError *error))completion;
- (void)orderWithParameters:(NSDictionary *) parameters callback:(void (^)(NSDictionary *response, NSError *error))completion;
- (void)discountWithCode:(NSString *) code callback:(void (^)(NSDictionary *response, NSError *error))completion;

@end
