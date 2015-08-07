//
//  ProductCache.h
//  MoltinSDK iOS Example
//
//  Created by Dylan McKee on 31/07/2015.
//  Copyright (c) 2015 Moltin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ProductCache : NSObject

+ (instancetype)sharedCache;
- (NSDictionary*)cachedProductsInCollectionId:(NSString*)collectionId;
- (void)setCachedProducts:(NSArray*)productsToCache withOffset:(NSNumber*)offset andTotal:(NSNumber*)total ForCollectionId:(NSString*)collectionId;

@end
