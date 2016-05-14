//
//  MTCart.m
//  MoltinSDK
//
//  Created by Moltin on 10/06/15.
//  Copyright (c) 2015 Moltin. All rights reserved.
//

#import "MTCart.h"
#import "MoltinStorage.h"

@interface MTCart()

@property (strong, nonatomic) NSString *identifier;

@end

@implementation MTCart

- (id)init{
    return [super initWithEndpoint:@"carts"];
}

- (NSString*)generateNewCartIdentifier {
    NSString *identifier = [[[NSUUID UUID] UUIDString] stringByReplacingOccurrencesOfString:@"-" withString:@""].lowercaseString;

    // Persist new card ID.
    [MoltinStorage setCartId:identifier];

    return identifier;
}

- (NSString *)identifier{
    _identifier = [MoltinStorage getCartId];

    // If there's no existing identifier, generate and persist a new ID.
    if (_identifier == nil || _identifier.length == 0) {
        _identifier = [self generateNewCartIdentifier];
    }

    return _identifier;
}

- (void)getContentsWithsuccess:(MTSuccessCallback)success failure:(MTFailureCallback)failure{
    [super getWithId:self.identifier success:success failure:failure];
}

- (void)insertItemWithId:(NSString *) itemId quantity:(NSInteger) quantity andModifiersOrNil:(NSDictionary *) modifiers success:(MTSuccessCallback)success failure:(MTFailureCallback)failure
{
    NSDictionary *parameters;

    if (modifiers) {
        parameters = @{@"id" : itemId, @"quantity": [NSNumber numberWithInteger:quantity], @"modifier": modifiers};
    }
    else{
        parameters = @{@"id" : itemId, @"quantity": [NSNumber numberWithInteger:quantity]};
    }

    NSString *endpoint = [NSString stringWithFormat:@"%@/%@", self.endpoint, self.identifier];
    [super postWithEndpoint:endpoint andParameters:parameters success:success failure:failure];
}

- (void)updateItemWithId:(NSString *) itemId parameters:(NSDictionary *) parameters success:(MTSuccessCallback)success failure:(MTFailureCallback)failure
{
    NSString *endpoint = [NSString stringWithFormat:@"%@/%@/item/%@", self.endpoint, self.identifier, itemId];
    [super putWithEndpoint:endpoint andParameters:parameters success:success failure:failure];
}

- (void)removeItemWithId:(NSString *) itemId success:(MTSuccessCallback)success failure:(MTFailureCallback)failure
{
    NSString *endpoint = [NSString stringWithFormat:@"%@/%@/item/%@", self.endpoint, self.identifier, itemId];
    [super deleteWithEndpoint:endpoint success:success failure:failure];
}

- (void)getItemWithId:(NSString *) itemId success:(MTSuccessCallback)success failure:(MTFailureCallback)failure
{
    NSString *endpoint = [NSString stringWithFormat:@"%@/%@/item/%@", self.endpoint, self.identifier, itemId];
    [super getWithEndpoint:endpoint andParameters:nil success:success failure:failure];
}

- (void)isItemInCart:(NSString *) itemId success:(MTSuccessCallback)success failure:(MTFailureCallback)failure
{
    NSString *endpoint = [NSString stringWithFormat:@"%@/%@/has/%@", self.endpoint, self.identifier, itemId];
    [super getWithEndpoint:endpoint andParameters:nil success:success failure:failure];
}

- (void)checkoutWithsuccess:(MTSuccessCallback)success failure:(MTFailureCallback)failure{
    NSString *endpoint = [NSString stringWithFormat:@"%@/%@/checkout", self.endpoint, self.identifier];
    [super getWithEndpoint:endpoint andParameters:nil success:success failure:failure];
}

- (void)orderWithParameters:(NSDictionary *) parameters success:(MTSuccessCallback)success failure:(MTFailureCallback)failure{
    NSString *endpoint = [NSString stringWithFormat:@"%@/%@/checkout", self.endpoint, self.identifier];

    [super postWithEndpoint:endpoint andParameters:parameters success:success failure:failure];
}

- (void)discountWithCode:(NSString *) code success:(MTSuccessCallback)success failure:(MTFailureCallback)failure{

    NSString *endpoint = [NSString stringWithFormat:@"%@/%@/discount", self.endpoint, self.identifier];

    if (code == nil || code.length == 0) {
        [super deleteWithEndpoint:endpoint success:success failure:failure];
    }
    else{
        [super postWithEndpoint:endpoint andParameters:@{@"code":code} success:success failure:failure];
    }
}

@end
