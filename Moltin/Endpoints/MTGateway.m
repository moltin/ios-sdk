//
//  MTGateway.m
//  MoltinSDK
//
//  Created by Moltin on 10/06/15.
//  Copyright (c) 2015 Moltin. All rights reserved.
//

#import "MTGateway.h"

@implementation MTGateway

- (id)init{
    return [super initWithEndpoint:@"gateways"];
}

- (void)getWithSlug:(NSString *) slug success:(MTSuccessCallback)success failure:(MTFailureCallback)failure{
    [super getWithId:slug success:success failure:failure];
}

@end
