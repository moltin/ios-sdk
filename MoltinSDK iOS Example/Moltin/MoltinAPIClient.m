//
//  Moltin.m
//  MoltinSDK
//
//  Created by Gasper Rebernak on 08/06/15.
//  Copyright (c) 2015 Gasper Rebernak. All rights reserved.
//

#import "MoltinAPIClient.h"
#import "MoltinStorage.h"

@interface MoltinAPIClient()


@end

@implementation MoltinAPIClient

- (id)initWithBaseURL:(NSURL *)url{
    self = [super initWithBaseURL:url];
    if (self){
        self.requestSerializer = [AFHTTPRequestSerializer serializer];
        [self.requestSerializer setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
        
        NSString *accessToken = [MoltinStorage getToken];
        if (accessToken != nil && ![accessToken isEqualToString:@""]) {
            [self.requestSerializer setValue:[NSString stringWithFormat:@"Bearer %@", accessToken] forHTTPHeaderField:@"Authorization"];
        }
    }
    return self;
}

+ (instancetype)sharedClient {
    static MoltinAPIClient *_sharedClient = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedClient = [[MoltinAPIClient alloc] initWithBaseURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@", kMoltinBaseApiURL, kMoltinVersion]]];
    });
    
    return _sharedClient;
}

- (void)authenticateWithClientId:(NSString *) clientId andCallback:(void(^)(BOOL sucess, NSError *error)) completion
{
    NSDictionary *params = @{
                             @"client_id" : clientId,
                             @"grant_type": @"implicit"
                             };
    
    
    [self POST:[NSString stringWithFormat:@"%@oauth/access_token", kMoltinBaseApiURL] parameters:params success:^(NSURLSessionDataTask *task, id responseObject) {
        [MoltinStorage setToken:[responseObject valueForKey:@"access_token"]];
        [MoltinStorage setTokenExpiration:[[responseObject valueForKey:@"expires_in"] integerValue]];
        
        [self setAccessToken:[MoltinStorage getToken]];
        
        NSLog(@"com.moltin Authentication success. TOKEN: %@", [MoltinStorage getToken]);
        completion(YES, nil);
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"com.moltin Authenticate ERROR: %@", error);
        completion(NO, error);
    }];
    
}

- (void)setAccessToken:(NSString *)accessToken
{
    [self.requestSerializer setValue:[NSString stringWithFormat:@"Bearer %@", accessToken] forHTTPHeaderField:@"Authorization"];
}

- (void)get:(NSString *) URLString withParameters:(NSDictionary *) parameters callback:(void(^)(NSDictionary *response, NSError *error)) completion
{
    [super GET:URLString parameters:parameters success:^(NSURLSessionDataTask *task, id responseObject) {
        completion(responseObject, nil);
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        completion(nil, error);
    }];
}

- (void)post:(NSString *) URLString withParameters:(NSDictionary *) parameters callback:(void(^)(NSDictionary *response, NSError *error)) completion
{
    [super POST:URLString parameters:parameters success:^(NSURLSessionDataTask *task, id responseObject) {
        completion(responseObject, nil);
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        completion(nil, error);
    }];
}

- (void)put:(NSString *) URLString withParameters:(NSDictionary *) parameters callback:(void(^)(NSDictionary *response, NSError *error)) completion
{
    [super PUT:URLString parameters:parameters success:^(NSURLSessionDataTask *task, id responseObject) {
        completion(responseObject, nil);
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        completion(nil, error);
    }];
}

- (void)delete:(NSString *) URLString withParameters:(NSDictionary *) parameters callback:(void(^)(NSDictionary *response, NSError *error)) completion
{
    [super DELETE:URLString parameters:parameters success:^(NSURLSessionDataTask *task, id responseObject) {
        completion(responseObject, nil);
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        completion(nil, error);
    }];
}

@end
