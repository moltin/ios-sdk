//
//  MoltinDeviceStorage.m
//  MoltinSDK
//
//  Created by Moltin on 09/06/15.
//  Copyright (c) 2015 Moltin. All rights reserved.
//

#import "MoltinStorage.h"
#import "MoltinConstants.h"

@implementation MoltinStorage

NSString * const kMoltinStorageCurrencyKey = @"com.moltin.mcurrency";
NSString * const kMoltinStorageCartKey = @"com.moltin.mcart";
NSString * const kMoltinStorageTokenKey = @"com.moltin.mtoken";
NSString * const kMoltinStorageExpirationKey = @"com.moltin.mexpires";


+ (NSString *)getCurrencyId{
    return [self getStringForKey:kMoltinStorageCurrencyKey];
}
+ (void)setCurrencyId:(NSString *) currencyId{
    [self setString:currencyId forKey:kMoltinStorageCurrencyKey];
}

+ (NSString *)getCartId{
    return [self getStringForKey:kMoltinStorageCartKey];
}
+ (void)setCartId:(NSString *) cartId
{
    [self setString:cartId forKey:kMoltinStorageCartKey];
}


+ (void)setToken:(NSString *)accessToken{
    [self setString:accessToken forKey:kMoltinStorageTokenKey];
}

+ (NSString *)getToken{
    return [self getStringForKey:kMoltinStorageTokenKey];
}

+ (void)setTokenExpiration:(NSInteger)expiresIn{
    
    NSDate *expireDate = [NSDate dateWithTimeIntervalSinceNow:expiresIn];
    
    [self setDouble:[expireDate timeIntervalSinceReferenceDate] forKey:kMoltinStorageExpirationKey];
}

+ (BOOL)isTokenExpired{
    
    double expiresTimeInterval = [self getDoubleForKey:kMoltinStorageExpirationKey];
    
    double currentTimeInterval = [[NSDate date] timeIntervalSinceReferenceDate];
    
    return currentTimeInterval > expiresTimeInterval;
}

+ (void)setLoggingEnabled:(BOOL) enabled{
    [self setBool:enabled forKey:kMoltinLoggingEnabled];
}

+ (BOOL)loggingEnabled{
    return [self getBoolForKey:kMoltinLoggingEnabled];
}


+ (NSString *)getStringForKey:(NSString *) key{
    return [[NSUserDefaults standardUserDefaults] stringForKey:key];
}

+ (void)setString:(NSString *) value forKey:(NSString *) key{
    [[NSUserDefaults standardUserDefaults] setValue:value forKey:key];
}

+ (NSInteger)getIntegerForKey:(NSString *) key{
    return [[NSUserDefaults standardUserDefaults] integerForKey:key];
}

+ (void)setInteger:(NSInteger) value forKey:(NSString *) key{
    [[NSUserDefaults standardUserDefaults] setInteger:value forKey:key];
}

+ (double)getDoubleForKey:(NSString *) key{
    return [[NSUserDefaults standardUserDefaults] doubleForKey:key];
}

+ (void)setDouble:(double) value forKey:(NSString *) key{
    [[NSUserDefaults standardUserDefaults] setDouble:value forKey:key];
}

+ (void)setBool:(BOOL) value forKey:(NSString *)key{
    [[NSUserDefaults standardUserDefaults] setBool:value forKey:key];
}

+ (BOOL)getBoolForKey:(NSString *) key{
    return [[NSUserDefaults standardUserDefaults] boolForKey:key];
}

@end
