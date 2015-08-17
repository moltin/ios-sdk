//
//  MTCategory.m
//  MoltinSDK
//
//  Created by Moltin on 10/06/15.
//  Copyright (c) 2015 Moltin. All rights reserved.
//

#import "MTCategory.h"

@implementation MTCategory

- (id)init{
    return [super initWithEndpoint:@"categories"];
}

- (void)getTreeWithParameters:(NSDictionary *) parameters success:(MTSuccessCallback)success failure:(MTFailureCallback)failure{
    NSString *endpoint = [NSString stringWithFormat:@"%@/tree", self.endpoint];
    [super getWithEndpoint:endpoint andParameters:parameters success:success failure:failure];
}

@end
