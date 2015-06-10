//
//  MoltinDeviceStorage.m
//  MoltinSDK
//
//  Created by Gasper Rebernak on 09/06/15.
//  Copyright (c) 2015 Gasper Rebernak. All rights reserved.
//

#import "MoltinStorage.h"

@implementation MoltinStorage

+ (void)setToken:(NSString *)accessToken{
    [self setString:accessToken forKey:@"mtoken"];
}

+ (NSString *)getToken{
    return [self getStringForKey:@"mtoken"];
}

+ (void)setTokenExpiration:(NSInteger)expiresIn{
    [self setInteger:expiresIn forKey:@"mexpires"];
}

+ (BOOL)isTokenExpired{
    return NO;
}

+ (NSString *)getStringForKey:(NSString *) key{
    return [[NSUserDefaults standardUserDefaults] stringForKey:key];
}

+ (void)setString:(NSString *) value forKey:(NSString *) key{
    [[NSUserDefaults standardUserDefaults] setObject:value forKey:key];
}

+ (void)setInteger:(NSInteger) value forKey:(NSString *) key{
    [[NSUserDefaults standardUserDefaults] setInteger:value forKey:key];
}

@end
