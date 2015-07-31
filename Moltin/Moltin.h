//
//  Moltin.h
//  MoltinSDK
//
//  Created by Moltin on 10/06/15.
//  Copyright (c) 2015 Moltin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MTAddress.h"
#import "MTBrand.h"
#import "MTCart.h"
#import "MTCategory.h"
#import "MTCheckout.h"
#import "MTCollection.h"
#import "MTCustomer.h"
#import "MTCurrency.h"
#import "MTEntry.h"
#import "MTGateway.h"
#import "MTOrder.h"
#import "MTProduct.h"
#import "MTShipping.h"
#import "MTTax.h"

@interface Moltin : NSObject

@property (strong, nonatomic) MTAddress *address;
@property (strong, nonatomic) MTBrand *brand;
@property (strong, nonatomic) MTCart *cart;
@property (strong, nonatomic) MTCategory *category;
@property (strong, nonatomic) MTCheckout *checkout;
@property (strong, nonatomic) MTCollection *collection;
@property (strong, nonatomic) MTCustomer *customer;
@property (strong, nonatomic) MTCurrency *currency;
@property (strong, nonatomic) MTEntry *entry;
@property (strong, nonatomic) MTGateway *gateway;
@property (strong, nonatomic) MTOrder *order;
@property (strong, nonatomic) MTProduct *product;
@property (strong, nonatomic) MTShipping *shipping;
@property (strong, nonatomic) MTTax *tax;


+ (instancetype)sharedInstance;
- (void)setPublicId:(NSString *)publicId;
- (void)setLoggingEnabled:(BOOL) enabled;

@end
