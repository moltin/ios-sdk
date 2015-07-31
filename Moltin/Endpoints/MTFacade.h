//
//  MoltinFacade.h
//  MoltinSDK
//
//  Created by Moltin on 10/06/15.
//  Copyright (c) 2015 Moltin. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^MTSuccessCallback)(NSDictionary *response);
typedef void (^MTFailureCallback)(NSDictionary *response, NSError *error);

@interface MTFacade : NSObject

@property (strong, nonatomic) NSString *endpoint;

- (id)initWithEndpoint:(NSString *) endpoint;

- (void)getWithId:(NSString *) ID success:(MTSuccessCallback)success failure:(MTFailureCallback)failure;

- (void)createWithParameters:(NSDictionary *) parameters success:(MTSuccessCallback)success failure:(MTFailureCallback)failure;
- (void)updateWithId:(NSString *) ID andParameters:(NSDictionary *) parameters success:(MTSuccessCallback)success failure:(MTFailureCallback)failure;
- (void)deleteWithId:(NSString *) ID success:(MTSuccessCallback)success failure:(MTFailureCallback)failure;

- (void)findWithParameters:(NSDictionary *) parameters success:(MTSuccessCallback)success failure:(MTFailureCallback)failure;
- (void)listingWithParameters:(NSDictionary *) parameters success:(MTSuccessCallback)success failure:(MTFailureCallback)failure;

- (void)fieldsWithId:(NSString *) ID success:(MTSuccessCallback)success failure:(MTFailureCallback)failure;

- (void)getWithEndpoint:(NSString *) endpoint andParameters:(NSDictionary *) parameters success:(MTSuccessCallback)success failure:(MTFailureCallback)failure;
- (void)postWithEndpoint:(NSString *) endpoint andParameters:(NSDictionary *) parameters success:(MTSuccessCallback)success failure:(MTFailureCallback)failure;
- (void)putWithEndpoint:(NSString *) endpoint andParameters:(NSDictionary *) parameters success:(MTSuccessCallback)success failure:(MTFailureCallback)failure;
- (void)deleteWithEndpoint:(NSString *)endpoint success:(MTSuccessCallback)success failure:(MTFailureCallback)failure;

- (void)raiseUnsupportedException;

@end
