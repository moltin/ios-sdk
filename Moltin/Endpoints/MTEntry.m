//
//  MTEntry.m
//  MoltinSDK
//
//  Created by Moltin on 10/06/15.
//  Copyright (c) 2015 Moltin. All rights reserved.
//

#import "MTEntry.h"

@implementation MTEntry

- (id)init{
    return [super initWithEndpoint:@"entries"];
}

- (void)getWithFlowId:(NSString *) flowId andEntryId:(NSString *) entryId success:(MTSuccessCallback)success failure:(MTFailureCallback)failure{
    NSString *endpoint = [NSString stringWithFormat:@"flows/%@/%@/%@", flowId, self.endpoint, entryId];
    [super getWithEndpoint:endpoint andParameters:nil success:success failure:failure];
}

- (void)findWithFlowId:(NSString *) flowId andParameters:(NSDictionary *) parameters success:(MTSuccessCallback)success failure:(MTFailureCallback)failure{
    NSString *endpoint = [NSString stringWithFormat:@"flows/%@/%@/search", flowId, self.endpoint];
    [super getWithEndpoint:endpoint andParameters:parameters success:success failure:failure];
}

- (void)listingWithFlowId:(NSString *) flowId andParameters:(NSDictionary *) parameters success:(MTSuccessCallback)success failure:(MTFailureCallback)failure{
    NSString *endpoint = [NSString stringWithFormat:@"flows/%@/%@", flowId, self.endpoint];
    [super getWithEndpoint:endpoint andParameters:parameters success:success failure:failure];
}

@end
