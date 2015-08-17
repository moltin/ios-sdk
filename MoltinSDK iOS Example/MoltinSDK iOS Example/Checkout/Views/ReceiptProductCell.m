//
//  ReceiptProductCell.m
//  MoltinSDK iOS Example
//
//  Created by Moltin on 08/07/15.
//  Copyright (c) 2015 Moltin. All rights reserved.
//

#import "ReceiptProductCell.h"

@interface ReceiptProductCell()

@property (strong, nonatomic) NSDictionary *productDict;

@end

@implementation ReceiptProductCell

- (void)awakeFromNib {
    // Initialization code
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

- (void)prepareForReuse{
    _productDict = nil;
}

- (void)configureWithProductDict:(NSDictionary *) product
{
    
    if (!product) {
        self.lbTitle.text = @"";
        self.lbPrice.text = @"";
        self.lbQuantity.text = @"";
        return;
    }
    
    _productDict = product;
    
    self.lbTitle.text = [product valueForKey:@"title"];
    self.lbPrice.text = [product valueForKeyPath:@"totals.post_discount.formatted.with_tax"];
    self.lbQuantity.text = [NSString stringWithFormat:@"%@", [product valueForKeyPath:@"quantity"]];
    
    NSArray *tmpImages = [product objectForKey:@"images"];
    
    
    for (NSDictionary *image in tmpImages) {
        NSString *imageUrl = [image valueForKeyPath:@"url.https"];
        [self.productImageView sd_setImageWithURL:[NSURL URLWithString:imageUrl]];
        break;
    }
}

@end
