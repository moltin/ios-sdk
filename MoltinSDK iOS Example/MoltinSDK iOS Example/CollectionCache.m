//
//  CollectionCache.m
//  MoltinSDK iOS Example
//
//  Created by Dylan McKee on 31/07/2015.
//  Copyright (c) 2015 Gasper Rebernak. All rights reserved.
//

#import "CollectionCache.h"

@implementation CollectionCache

+ (instancetype)sharedCache {
    // CollectionCache is a singleton, so we need to ensure it's only instantiated once.
    static CollectionCache *sharedInstance = nil;
    
    static dispatch_once_t dispatchToken;
    
    dispatch_once(&dispatchToken, ^{
        sharedInstance = [[self alloc] init];
    });
    
    return sharedInstance;
}

@end
