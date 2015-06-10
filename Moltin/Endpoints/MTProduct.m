//
//  MoltinProduct.m
//  MoltinSDK
//
//  Created by Gasper Rebernak on 10/06/15.
//  Copyright (c) 2015 Gasper Rebernak. All rights reserved.
//

#import "MTProduct.h"
#import "MoltinAPIClient.h"

@implementation MTProduct

- (id)init{
    return [super initWithEndpoint:@"products"];
}

- (void)searchWithParameters:(NSDictionary *) parameters callback:(void(^)(NSDictionary *response, NSError *error)) completion{
    NSString *endpoint = [NSString stringWithFormat:@"%@/search", self.endpoint];
    [[MoltinAPIClient sharedClient] get:endpoint withParameters:parameters callback:completion];
}

@end
