//
//  ReceiptManager.m
//  MoltinSDK iOS Example
//
//  Created by Dylan McKee on 07/08/2015.
//  Copyright (c) 2015 Moltin. All rights reserved.
//

#import "ReceiptManager.h"

@implementation ReceiptManager

static NSString *DirectoryName = @"com.moltin.saved_receipt_store";
static NSString *FileDataKey = @"com.moltin.saved_receipt_data";

+ (NSString*)pathToStoreDirectory {
    NSArray *documentsPath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *storeDirectoryPath = [[documentsPath objectAtIndex:0] stringByAppendingPathComponent:DirectoryName];
    
    // make sure it exists, if not, create it...
    if (![[NSFileManager defaultManager] fileExistsAtPath:storeDirectoryPath]) {
        // create directory
        [[NSFileManager defaultManager] createDirectoryAtPath:storeDirectoryPath withIntermediateDirectories:NO attributes:nil error:nil];
    }
    
    return storeDirectoryPath;
}

+ (NSArray*)savedReceipts {
    NSMutableArray *receipts = [NSMutableArray array];
    NSArray *dataFiles = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:[self pathToStoreDirectory] error:nil];
    
    for(NSString *fileName in dataFiles){
        NSString *savedFilePath = [NSString stringWithFormat:@"%@/%@", [self pathToStoreDirectory], fileName];
        
        NSData *encodedData = [[NSData alloc] initWithContentsOfFile:savedFilePath];

        Receipt *savedReceipt = [NSKeyedUnarchiver unarchiveObjectWithData:encodedData];
        
        [receipts addObject:savedReceipt];
        
    }
    
    return receipts;
}

+ (BOOL)saveReceipt:(Receipt*)receipt {
    NSString *newFilePath = [NSString stringWithFormat:@"%@/%@.moltinreceipt", [self pathToStoreDirectory], [receipt.creationDate description]];
    
    return [NSKeyedArchiver archiveRootObject:receipt toFile:newFilePath];

}



@end
