//
//  CollectionCache.h
//  MoltinSDK iOS Example
//
//  Created by Dylan McKee on 31/07/2015.
//  Copyright (c) 2015 Gasper Rebernak. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CollectionCache : NSObject

+ (instancetype)sharedCache;

@property (nonatomic, retain) NSArray *collectionArray;


@end
