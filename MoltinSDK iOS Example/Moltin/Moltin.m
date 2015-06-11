//
//  Moltin.m
//  MoltinSDK
//
//  Created by Gasper Rebernak on 10/06/15.
//  Copyright (c) 2015 Gasper Rebernak. All rights reserved.
//

#import "Moltin.h"
#import "MoltinAPIClient.h"

@implementation Moltin

- (id)init{
    self = [super init];
    if (self) {
        self.address = [[MTAddress alloc] init];
        self.product = [[MTProduct alloc] init];
        self.category = [[MTCategory alloc] init];
    }
    return self;
}

+ (instancetype)sharedInstance {
    static Moltin *_sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedInstance = [[Moltin alloc] init];
    });
    
    return _sharedInstance;
}

- (void)setPublicId:(NSString *)publicId
{
    [MoltinAPIClient sharedClient].publicId = publicId;
}

@end
