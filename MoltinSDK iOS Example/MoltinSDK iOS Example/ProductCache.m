//
//  ProductCache.m
//  MoltinSDK iOS Example
//
//  Created by Dylan McKee on 31/07/2015.
//  Copyright (c) 2015 Moltin. All rights reserved.
//

#import "ProductCache.h"

@interface ProductCache () {
    NSMutableDictionary *cacheDictionary;
}

@end

@implementation ProductCache

+ (instancetype)sharedCache {
    // ProductCache is a singleton, so we need to ensure it's only instantiated once.
    static ProductCache *sharedInstance = nil;
    
    static dispatch_once_t dispatchToken;
    
    dispatch_once(&dispatchToken, ^{
        sharedInstance = [[self alloc] init];
    });
    
    return sharedInstance;
}

- (id)init {
    if (self = [super init]) {
        // instantiate the internal cache dictionary
        cacheDictionary = [NSMutableDictionary dictionary];
    }
    return self;
}

- (NSDictionary*)cachedProductsInCollectionId:(NSString*)collectionId {

    return [cacheDictionary objectForKey:collectionId];
}

- (void)setCachedProducts:(NSArray*)productsToCache withOffset:(NSNumber*)offset andTotal:(NSNumber*)total ForCollectionId:(NSString*)collectionId {
    
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    [dict addEntriesFromDictionary:@{@"products": productsToCache, @"offset": offset, @"total": total}];
    
    [cacheDictionary setObject:dict forKey:collectionId];
}


@end
