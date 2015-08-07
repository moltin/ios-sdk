//
//  Receipt.h
//  MoltinSDK iOS Example
//
//  Created by Dylan McKee on 07/08/2015.
//  Copyright (c) 2015 Moltin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Receipt : NSObject <NSCoding>

@property NSArray *products;
@property NSDictionary *receiptData;
@property NSDate *creationDate;

@end
