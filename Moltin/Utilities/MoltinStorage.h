//
//  MoltinDeviceStorage.h
//  MoltinSDK
//
//  Created by Gasper Rebernak on 09/06/15.
//  Copyright (c) 2015 Gasper Rebernak. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MoltinStorage : NSObject

+ (void)setToken:(NSString *) accessToken;
+ (NSString *)getToken;

+ (void)setTokenExpiration:(NSInteger) expiresIn;
+ (BOOL)isTokenExpired;

@end
