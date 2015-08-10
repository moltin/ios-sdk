//
//  SavedReceiptTableViewCell.h
//  MoltinSDK iOS Example
//
//  Created by Dylan McKee on 10/08/2015.
//  Copyright (c) 2015 Moltin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SavedReceiptTableViewCell : UITableViewCell {
    NSDateFormatter *formatter;
}

@property (weak, nonatomic) IBOutlet UILabel *receiptNameLabel;

- (void)setPurchaseDate:(NSDate*)date;

@end
