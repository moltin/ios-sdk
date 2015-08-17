//
//  MoltinDeviceStorage.h
//  MoltinSDK
//
//  Created by Moltin on 09/06/15.
//  Copyright (c) 2015 Moltin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MoltinStorage : NSObject

+ (NSString *)getCurrencyId;
+ (void)setCurrencyId:(NSString *) currencyId;

+ (NSString *)getCartId;
+ (void)setCartId:(NSString *) cartId;

+ (void)setToken:(NSString *) accessToken;
+ (NSString *)getToken;

+ (void)setTokenExpiration:(NSInteger) expiresIn;
+ (BOOL)isTokenExpired;

+ (void)setLoggingEnabled:(BOOL) enabled;
+ (BOOL)loggingEnabled;

@end
