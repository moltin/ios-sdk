//
//  Receipt.m
//  MoltinSDK iOS Example
//
//  Created by Dylan McKee on 07/08/2015.
//  Copyright (c) 2015 Moltin. All rights reserved.
//

#import "Receipt.h"

@implementation Receipt

static NSString *ProductsArrayKey = @"products";
static NSString *ReceiptDataKey = @"receipt_data";
static NSString *DateKey = @"date";

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    
    if(self = [super init]) {
        self.products = [aDecoder decodeObjectForKey:ProductsArrayKey];
        self.receiptData = [aDecoder decodeObjectForKey:ReceiptDataKey];
        self.creationDate = [aDecoder decodeObjectForKey:DateKey];
        
    }
    
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeObject:self.products forKey:ProductsArrayKey];
    [aCoder encodeObject:self.receiptData forKey:ReceiptDataKey];
    [aCoder encodeObject:self.creationDate forKey:DateKey];
    
    
}

@end
