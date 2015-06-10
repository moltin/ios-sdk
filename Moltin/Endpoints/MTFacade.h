//
//  MoltinFacade.h
//  MoltinSDK
//
//  Created by Gasper Rebernak on 10/06/15.
//  Copyright (c) 2015 Gasper Rebernak. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MTFacade : NSObject

@property (strong, nonatomic) NSString *endpoint;

- (id)initWithEndpoint:(NSString *) endpoint;

- (void)getWithId:(NSString *) ID callback:(void(^)(NSDictionary *response, NSError *error)) completion;
- (void)createWithParameters:(NSDictionary *) parameters callback:(void(^)(NSDictionary *response, NSError *error)) completion;
- (void)updateWithId:(NSString *) ID andParameters:(NSDictionary *) parameters callback:(void(^)(NSDictionary *response, NSError *error)) completion;
- (void)deleteWithId:(NSString *) ID callback:(void(^)(NSDictionary *response, NSError *error)) completion;

- (void)findWithParameters:(NSDictionary *) parameters callback:(void(^)(NSDictionary *response, NSError *error)) completion;
- (void)listingWithParameters:(NSDictionary *) parameters callback:(void(^)(NSDictionary *response, NSError *error)) completion;

- (void)fieldsWithId:(NSString *) ID callback:(void(^)(NSDictionary *response, NSError *error)) completion;

@end
