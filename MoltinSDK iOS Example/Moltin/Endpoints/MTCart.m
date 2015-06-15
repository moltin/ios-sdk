//
//  MTCart.m
//  MoltinSDK
//
//  Created by Gasper Rebernak on 10/06/15.
//  Copyright (c) 2015 Gasper Rebernak. All rights reserved.
//

#import "MTCart.h"
#import "MoltinStorage.h"

@interface MTCart()

@property (strong, nonatomic) NSString *identifier;

@end

@implementation MTCart

- (id)init{
    return [super initWithEndpoint:@"charts"];
}

- (NSString *)getIdentifier{
    _identifier = [MoltinStorage getCartId];
    
    if (_identifier == nil || _identifier.length > 0) {
        _identifier = [[NSUUID UUID] UUIDString];
        [MoltinStorage setCartId:_identifier];
    }
    
    return _identifier;
}

- (void)getContentsWithCallback:(void (^)(NSDictionary *, NSError *))completion{
    [super getWithId:self.identifier callback:completion];
}

- (void)insertItemWithId:(NSString *) itemId quantity:(NSInteger) quantity andModifiersOrNil:(NSDictionary *) modifiers callback:(void (^)(NSDictionary *, NSError *))completion
{
    NSDictionary *parameters;
    
    if (modifiers) {
        parameters = @{@"id" : itemId, @"quantity": [NSNumber numberWithInteger:quantity], @"modifier": modifiers};
    }
    else{
        parameters = @{@"id" : itemId, @"quantity": [NSNumber numberWithInteger:quantity]};
    }
    
    NSString *endpoint = [NSString stringWithFormat:@"%@/%@", self.endpoint, self.identifier];
    [super postWithEndpoint:endpoint andParameters:parameters callback:completion];
}

- (void)updateItemWithId:(NSString *) itemId parameters:(NSDictionary *) parameters callback:(void (^)(NSDictionary *, NSError *))completion
{
    NSString *endpoint = [NSString stringWithFormat:@"%@/%@/item/%@", self.endpoint, self.identifier, itemId];
    [super putWithEndpoint:endpoint andParameters:parameters callback:completion];
}

- (void)removeItemWithId:(NSString *) itemId callback:(void (^)(NSDictionary *, NSError *))completion
{
    NSString *endpoint = [NSString stringWithFormat:@"%@/%@/item/%@", self.endpoint, self.identifier, itemId];
    [super deleteWithEndpoint:endpoint callback:completion];
}

- (void)getItemWithId:(NSString *) itemId callback:(void (^)(NSDictionary *, NSError *))completion
{
    NSString *endpoint = [NSString stringWithFormat:@"%@/%@/item/%@", self.endpoint, self.identifier, itemId];
    [super getWithEndpoint:endpoint andParameters:nil callback:completion];
}

- (void)isItemInCart:(NSString *) itemId callback:(void (^)(NSDictionary *, NSError *))completion
{
    NSString *endpoint = [NSString stringWithFormat:@"%@/%@/has/%@", self.endpoint, self.identifier, itemId];
    [super getWithEndpoint:endpoint andParameters:nil callback:completion];
}

- (void)checkoutWithCallback:(void (^)(NSDictionary *, NSError *))completion{
    NSString *endpoint = [NSString stringWithFormat:@"%@/%@/checkout", self.endpoint, self.identifier];
    [super getWithEndpoint:endpoint andParameters:nil callback:completion];
}

- (void)orderWithParameters:(NSDictionary *) parameters callback:(void (^)(NSDictionary *, NSError *))completion{
    NSString *endpoint = [NSString stringWithFormat:@"%@/%@/checkout", self.endpoint, self.identifier];
    [super postWithEndpoint:endpoint andParameters:nil callback:completion];
}

- (void)discountWithCode:(NSString *) code callback:(void (^)(NSDictionary *, NSError *))completion{
    
    NSString *endpoint = [NSString stringWithFormat:@"%@/%@/discount", self.endpoint, self.identifier];
    
    if (code == nil || code.length == 0) {
        [super deleteWithEndpoint:endpoint callback:completion];
    }
    else{
        [super postWithEndpoint:endpoint andParameters:@{@"code":code} callback:completion];
    }
}

@end
