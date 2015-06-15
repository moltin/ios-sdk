//
//  MTCategory.h
//  MoltinSDK
//
//  Created by Gasper Rebernak on 10/06/15.
//  Copyright (c) 2015 Gasper Rebernak. All rights reserved.
//

#import "MTFacade.h"

@interface MTCategory : MTFacade

- (void)getTreeWithParameters:(NSDictionary *) parameters callback:(void (^)(NSDictionary *response, NSError *error))completion;

@end
