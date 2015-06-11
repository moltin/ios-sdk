//
//  Moltin.h
//  MoltinSDK
//
//  Created by Gasper Rebernak on 10/06/15.
//  Copyright (c) 2015 Gasper Rebernak. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MTAddress.h"
#import "MTBrand.h"
#import "MTProduct.h"
#import "MTCurrency.h"
#import "MTCategory.h"
#import "MTCart.h"
#import "MTCheckout.h"
#import "MTCollection.h"
#import "MTEntry.h"
#import "MTGateway.h"
#import "MTOrder.h"
#import "MTProduct.h"
#import "MTShipping.h"
#import "MTTax.h"

@interface Moltin : NSObject

@property (strong, nonatomic) MTAddress *address;
@property (strong, nonatomic) MTProduct *product;
@property (strong, nonatomic) MTCategory *category;

+ (instancetype)sharedInstance;
- (void)setPublicId:(NSString *)publicId;

@end
