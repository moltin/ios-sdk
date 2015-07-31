//
//  ReceiptProductCell.h
//  MoltinSDK iOS Example
//
//  Created by Moltin on 08/07/15.
//  Copyright (c) 2015 Moltin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ReceiptProductCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *productImageView;
@property (weak, nonatomic) IBOutlet UILabel *lbQuantity;
@property (weak, nonatomic) IBOutlet UILabel *lbTitle;
@property (weak, nonatomic) IBOutlet UILabel *lbPrice;

- (void)configureWithProductDict:(NSDictionary *) product;

@end
