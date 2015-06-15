//
//  MTGateway.m
//  MoltinSDK
//
//  Created by Gasper Rebernak on 10/06/15.
//  Copyright (c) 2015 Gasper Rebernak. All rights reserved.
//

#import "MTGateway.h"

@implementation MTGateway

- (id)init{
    return [super initWithEndpoint:@"gateways"];
}

- (void)getWithSlug:(NSString *) slug callback:(void (^)(NSDictionary *response, NSError *error))completion{
    [super getWithId:slug callback:completion];
}

@end
