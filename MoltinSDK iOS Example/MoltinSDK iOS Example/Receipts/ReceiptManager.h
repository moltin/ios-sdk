//
//  ReceiptManager.h
//  MoltinSDK iOS Example
//
//  Created by Dylan McKee on 07/08/2015.
//  Copyright (c) 2015 Moltin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Receipt.h"


@interface ReceiptManager : NSObject

+ (NSArray*)savedReceipts;
+ (BOOL)saveReceipt:(Receipt*)receipt;

@end
