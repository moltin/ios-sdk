//
//  MTEntry.h
//  MoltinSDK
//
//  Created by Gasper Rebernak on 10/06/15.
//  Copyright (c) 2015 Gasper Rebernak. All rights reserved.
//

#import "MTFacade.h"

@interface MTEntry : MTFacade

- (void)getWithFlowId:(NSString *) flowId andEntryId:(NSString *) entryId callback:(void (^)(NSDictionary *response, NSError *error))completion;
- (void)findWithFlowId:(NSString *) flowId andParameters:(NSDictionary *) parameters callback:(void(^)(NSDictionary *response, NSError *error)) completion;
- (void)listingWithFlowId:(NSString *) flowId andParameters:(NSDictionary *) parameters callback:(void(^)(NSDictionary *response, NSError *error)) completion;

@end
