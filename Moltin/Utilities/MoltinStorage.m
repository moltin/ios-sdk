//
//  MoltinDeviceStorage.m
//  MoltinSDK
//
//  Created by Gasper Rebernak on 09/06/15.
//  Copyright (c) 2015 Gasper Rebernak. All rights reserved.
//

#import "MoltinStorage.h"
#import "MoltinConstants.h"

@implementation MoltinStorage

+ (NSString *)getCurrencyId{
    return [self getStringForKey:@"mcurrency"];
}
+ (void)setCurrencyId:(NSString *) currencyId{
    [self setString:currencyId forKey:@"mcurrency"];
}

+ (NSString *)getCartId{
    return [self getStringForKey:@"mcart"];
}
+ (void)setCartId:(NSString *) cartId
{
    [self setString:cartId forKey:@"mcart"];
}


+ (void)setToken:(NSString *)accessToken{
    [self setString:accessToken forKey:@"mtoken"];
}

+ (NSString *)getToken{
    return [self getStringForKey:@"mtoken"];
}

+ (void)setTokenExpiration:(NSInteger)expiresIn{
    
    NSDate *expireDate = [NSDate dateWithTimeIntervalSinceNow:expiresIn];
    
    [self setDouble:[expireDate timeIntervalSinceReferenceDate] forKey:@"mexpires"];
}

+ (BOOL)isTokenExpired{
    
    double expiresTimeInterval = [self getDoubleForKey:@"mexpires"];
    
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
