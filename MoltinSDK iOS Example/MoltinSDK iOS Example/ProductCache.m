//
//  ProductCache.m
//  MoltinSDK iOS Example
//
//  Created by Dylan McKee on 31/07/2015.
//  Copyright (c) 2015 Moltin. All rights reserved.
//

#import "ProductCache.h"

@interface ProductCache (Private)
    @property (nonatomic, strong) NSMutableDictionary *cacheDictionary;
@end

@implementation ProductCache

+ (id)sharedCache {
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
        self.cacheDictionary = [NSMutableDictionary new];
    }
    return self;
}

- (NSArray*)cachedProductsInCollectionId:(NSString*)collectionId {
    return [self.cacheDictionary objectForKey:collectionId];
}

- (void)setCachedProducts:(NSArray*)productsToCache ForCollectionId:(NSString*)collectionId {
    [self.cacheDictionary setObject:productsToCache forKey:collectionId];
}


@end
