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
@property (weak, nonatomic) IBOutlet UILabel *receiptAmountLabel;

- (void)setPurchaseDate:(NSDate*)date;
- (void)setPurchaseAmount:(NSUInteger)amount;

@end
