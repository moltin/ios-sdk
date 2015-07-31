//
//  MTCategory.h
//  MoltinSDK
//
//  Created by Moltin on 10/06/15.
//  Copyright (c) 2015 Moltin. All rights reserved.
//

#import "MTFacade.h"

@interface MTCategory : MTFacade

- (void)getTreeWithParameters:(NSDictionary *) parameters success:(MTSuccessCallback)success failure:(MTFailureCallback)failure;

@end
