//
//  MTEntry.m
//  MoltinSDK
//
//  Created by Gasper Rebernak on 10/06/15.
//  Copyright (c) 2015 Gasper Rebernak. All rights reserved.
//

#import "MTEntry.h"

@implementation MTEntry

- (id)init{
    return [super initWithEndpoint:@"entries"];
}

- (void)getWithFlowId:(NSString *) flowId andEntryId:(NSString *) entryId callback:(void (^)(NSDictionary *, NSError *))completion{
    NSString *endpoint = [NSString stringWithFormat:@"flows/%@/%@/%@", flowId, self.endpoint, entryId];
    [super getWithEndpoint:endpoint andParameters:nil callback:completion];
}

- (void)findWithFlowId:(NSString *) flowId andParameters:(NSDictionary *) parameters callback:(void(^)(NSDictionary *response, NSError *error)) completion{
    NSString *endpoint = [NSString stringWithFormat:@"flows/%@/%@/search", flowId, self.endpoint];
    [super getWithEndpoint:endpoint andParameters:parameters callback:completion];
}

- (void)listingWithFlowId:(NSString *) flowId andParameters:(NSDictionary *) parameters callback:(void(^)(NSDictionary *response, NSError *error)) completion{
    NSString *endpoint = [NSString stringWithFormat:@"flows/%@/%@", flowId, self.endpoint];
    [super getWithEndpoint:endpoint andParameters:parameters callback:completion];
}

@end
