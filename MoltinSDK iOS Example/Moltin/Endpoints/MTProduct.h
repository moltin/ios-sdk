//
//  MTProduct.h
//  MoltinSDK
//
//  Created by Gasper Rebernak on 10/06/15.
//  Copyright (c) 2015 Gasper Rebernak. All rights reserved.
//

#import "MTFacade.h"

@interface MTProduct : MTFacade

- (void)searchWithParameters:(NSDictionary *) parameters callback:(void(^)(NSDictionary *response, NSError *error)) completion;

- (void)getModifiersWithId:(NSString *) productId callback:(void(^)(NSDictionary *response, NSError *error)) completion;

- (void)getVariationsWithId:(NSString *) productId callback:(void(^)(NSDictionary *response, NSError *error)) completion;

@end
