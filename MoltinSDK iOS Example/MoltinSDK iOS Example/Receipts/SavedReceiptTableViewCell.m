//
//  SavedReceiptTableViewCell.m
//  MoltinSDK iOS Example
//
//  Created by Dylan McKee on 10/08/2015.
//  Copyright (c) 2015 Moltin. All rights reserved.
//

#import "SavedReceiptTableViewCell.h"

@implementation SavedReceiptTableViewCell

- (void)awakeFromNib {
    // Initialization code
    formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:NSDateFormatterShortStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setPurchaseAmount:(NSUInteger)amount {
    if (amount == 1) {
        self.receiptAmountLabel.text = [NSString stringWithFormat:@"%lu item", (unsigned long)amount];

    } else {
        self.receiptAmountLabel.text = [NSString stringWithFormat:@"%lu items", (unsigned long)amount];

    }
}

- (void)setPurchaseDate:(NSDate*)date {
    self.receiptNameLabel.text = [NSString stringWithFormat:@"Your order on %@", [formatter stringFromDate:date]];
    
}

@end
