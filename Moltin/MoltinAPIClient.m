//
//  Moltin.m
//  MoltinSDK
//
//  Created by Moltin on 08/06/15.
//  Copyright (c) 2015 Moltin. All rights reserved.
//

#import "MoltinAPIClient.h"
#import <AFNetworking/AFNetworkActivityIndicatorManager.h>

@interface MoltinAPIClient()


@end

@implementation MoltinAPIClient

- (id)initWithBaseURL:(NSURL *)url{
    self = [super initWithBaseURL:url];
    if (self){
        [[AFNetworkActivityIndicatorManager sharedManager] setEnabled:YES];

        self.requestSerializer = [AFHTTPRequestSerializer serializer];
        [self.requestSerializer setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
        self.responseSerializer = [AFJSONResponseSerializer serializer];
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

- (void)authenticateWithPublicId:(NSString *) publicId andCallback:(MTAuthenitactionCallback) completion
{
    //public id must be set
    NSParameterAssert(publicId);

    NSString *accessToken = [MoltinStorage getToken];
    if ([MoltinStorage isTokenExpired] || accessToken == nil || [accessToken isEqualToString:@""]) {
        NSDictionary *params = @{
                                 @"client_id" : publicId,
                                 @"grant_type": @"implicit"
                                 };

        __weak MoltinAPIClient *weekSelf = self;

        [self POST:[NSString stringWithFormat:@"%@oauth/access_token", kMoltinBaseApiURL] parameters:params progress:^(NSProgress * _Nonnull uploadProgress) {
            // No progress indiaction required in this implementation of the SDK.
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            [MoltinStorage setToken:[responseObject valueForKey:@"access_token"]];
            [MoltinStorage setTokenExpiration:[[responseObject valueForKey:@"expires_in"] doubleValue]];

            [weekSelf setAccessToken:[MoltinStorage getToken]];

            MTLog(@"Authentication success. TOKEN: %@", [MoltinStorage getToken]);
            if (completion) {
                completion(YES, nil);
            }
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            MTLog(@"Authenticate ERROR: %@", error);
            if (completion) {
                completion(NO, error);
            }
        }];

    }
    else{
        completion(YES, nil);
    }
}

- (void)setAccessToken:(NSString *)accessToken
{
    [self.requestSerializer setValue:[NSString stringWithFormat:@"Bearer %@", accessToken] forHTTPHeaderField:@"Authorization"];
}

- (void)get:(NSString *) URLString withParameters:(NSDictionary *) parameters success:(MTSuccessCallback)success failure:(MTFailureCallback)failure
{
    MTLog(@"GET: %@%@", self.baseURL.absoluteString, URLString);
    __weak MoltinAPIClient *weekSelf = self;
    MTAuthenitactionCallback authCallback = ^(BOOL sucess, NSError *error) {
        if (error) {
            MTLog(@"ERROR authenticating!!! %@", error);
        }
        else{

            [weekSelf GET:URLString parameters:parameters progress:^(NSProgress * _Nonnull downloadProgress) {
                // No progress required in this client SDK version, could be added here in future though.
            } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                if (success) {
                    success(responseObject);
                }
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                NSDictionary *serializedData = nil;
                NSData *errorData = error.userInfo[AFNetworkingOperationFailingURLResponseDataErrorKey];
                if (errorData) {
                    serializedData = [NSJSONSerialization JSONObjectWithData: errorData options:kNilOptions error:nil];
                }
                MTLog(@"ERROR GET: %@%@\nDATA: %@", self.baseURL.absoluteString, URLString, serializedData);
                if (failure) {
                    failure(serializedData, error);
                }
            }];


        }
    };

    [self authenticateWithPublicId:self.publicId andCallback:authCallback];

}

- (void)post:(NSString *) URLString withParameters:(NSDictionary *) parameters success:(MTSuccessCallback)success failure:(MTFailureCallback)failure
{
    MTLog(@"POST: %@%@", self.baseURL.absoluteString, URLString);
    __weak MoltinAPIClient *weekSelf = self;
    MTAuthenitactionCallback authCallback = ^(BOOL sucess, NSError *error) {
        if (error) {
            MTLog(@"ERROR authenticating!!! %@", error);
        }
        else{
            [weekSelf POST:URLString parameters:parameters progress:^(NSProgress * _Nonnull uploadProgress) {
                // Progress updates not required in this client SDK version, could be added in future though.
            } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                if (success) {
                    success(responseObject);
                }
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                NSDictionary *serializedData = nil;
                NSData *errorData = error.userInfo[AFNetworkingOperationFailingURLResponseDataErrorKey];
                if (errorData) {
                    serializedData = [NSJSONSerialization JSONObjectWithData: errorData options:kNilOptions error:nil];

                }

                MTLog(@"ERROR POST: %@%@\nDATA: %@", self.baseURL.absoluteString, URLString, serializedData);

                if (failure) {
                    failure(serializedData, error);
                }
            }];

        }
    };

    [self authenticateWithPublicId:self.publicId andCallback:authCallback];
}

- (void)put:(NSString *) URLString withParameters:(NSDictionary *) parameters success:(MTSuccessCallback)success failure:(MTFailureCallback)failure
{
    MTLog(@"PUT: %@%@", self.baseURL.absoluteString, URLString);
    __weak MoltinAPIClient *weekSelf = self;
    MTAuthenitactionCallback authCallback = ^(BOOL sucess, NSError *error) {
        if (error) {
            MTLog(@"ERROR authenticating!!! %@", error);
        }
        else{
            [weekSelf PUT:URLString parameters:parameters success:^(NSURLSessionDataTask *task, id responseObject) {
                if (success) {
                    success(responseObject);
                }
            } failure:^(NSURLSessionDataTask *task, NSError *error) {
                NSDictionary *serializedData = nil;
                NSData *errorData = error.userInfo[AFNetworkingOperationFailingURLResponseDataErrorKey];
                if (errorData) {
                    serializedData = [NSJSONSerialization JSONObjectWithData: errorData options:kNilOptions error:nil];
                }

                MTLog(@"ERROR PUT: %@%@\nDATA: %@", self.baseURL.absoluteString, URLString, serializedData);

                if (failure) {
                    failure(serializedData, error);
                }
            }];
        }
    };

    [self authenticateWithPublicId:self.publicId andCallback:authCallback];
}

- (void)delete:(NSString *) URLString withParameters:(NSDictionary *) parameters success:(MTSuccessCallback)success failure:(MTFailureCallback)failure
{
    MTLog(@"DELETE: %@%@", self.baseURL.absoluteString, URLString);
    __weak MoltinAPIClient *weekSelf = self;
    MTAuthenitactionCallback authCallback = ^(BOOL sucess, NSError *error) {
        if (error) {
            MTLog(@"ERROR authenticating!!! %@", error);
        }
        else{
            [weekSelf DELETE:URLString parameters:parameters success:^(NSURLSessionDataTask *task, id responseObject) {
                if (success) {
                    success(responseObject);
                }
            } failure:^(NSURLSessionDataTask *task, NSError *error) {
                NSDictionary *serializedData = nil;
                NSData *errorData = error.userInfo[AFNetworkingOperationFailingURLResponseDataErrorKey];
                if (errorData) {
                    serializedData = [NSJSONSerialization JSONObjectWithData: errorData options:kNilOptions error:nil];
                }

                MTLog(@"ERROR DELETE: %@%@\nDATA: %@", self.baseURL.absoluteString, URLString, serializedData);

                if (failure) {
                    failure(serializedData, error);
                }
            }];
        }
    };

    [self authenticateWithPublicId:self.publicId andCallback:authCallback];
}

@end
