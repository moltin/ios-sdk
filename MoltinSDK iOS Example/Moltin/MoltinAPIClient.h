//
//  Moltin.h
//  MoltinSDK iOS Example
//
//  Created by Gasper Rebernak on 08/06/15.
//  Copyright (c) 2015 Gasper Rebernak. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFNetworking/AFNetworking.h>
#import "MoltinConstants.h"

@interface MoltinAPIClient : AFHTTPSessionManager

+ (instancetype)sharedClient;
- (void)authenticateWithClientId:(NSString *) clientId andCallback:(void(^)(BOOL sucess, NSError *error)) completion;
- (void)setAccessToken:(NSString *)accessToken;

- (void)get:(NSString *) URLString withParameters:(NSDictionary *) parameters callback:(void(^)(NSDictionary *response, NSError *error)) completion;

- (void)post:(NSString *) URLString withParameters:(NSDictionary *) parameters callback:(void(^)(NSDictionary *response, NSError *error)) completion;

- (void)put:(NSString *) URLString withParameters:(NSDictionary *) parameters callback:(void(^)(NSDictionary *response, NSError *error)) completion;

- (void)delete:(NSString *) URLString withParameters:(NSDictionary *) parameters callback:(void(^)(NSDictionary *response, NSError *error)) completion;

@end
