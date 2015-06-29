//
//  CartListCell.m
//  MoltinSDK iOS Example
//
//  Created by Gasper Rebernak on 22/06/15.
//  Copyright (c) 2015 Gasper Rebernak. All rights reserved.
//

#import "CartListCell.h"

@interface CartListCell()

@property (strong, nonatomic) NSDictionary *cartItem;

@end

@implementation CartListCell

- (void)awakeFromNib {
    // Initialization code
}

- (IBAction)btnMinusTap:(id)sender {
    NSInteger currentQuantity = self.lbQuantity.text.integerValue;
    self.lbQuantity.text = [NSString stringWithFormat:@"%d", (currentQuantity-1)];
    [self updateCart];
}

- (IBAction)btnPlusTap:(id)sender {
    NSInteger currentQuantity = self.lbQuantity.text.integerValue;
    self.lbQuantity.text = [NSString stringWithFormat:@"%d", (currentQuantity+1)];
    [self updateCart];
}

- (void)updateCart{
    NSNumber *currentQuantity = [NSNumber numberWithInteger:self.lbQuantity.text.integerValue];
    if (self.delegate && [self.delegate respondsToSelector:@selector(updateCartWithProductId:andQuantity:)]) {
        [self.delegate updateCartWithProductId:[self.cartItem valueForKey:@"id"] andQuantity:currentQuantity];
    }
}

- (void)configureWithCartItemDict:(NSDictionary *) cartItem
{
    _cartItem = cartItem;
    self.lbProductName.text = [cartItem valueForKey:@"title"];
    self.lbPrice.text = [[[cartItem objectForKey:@"pricing"] objectForKey:@"formatted"] valueForKey:@"with_tax"];
    
    NSNumber *quantity = [cartItem valueForKey:@"quantity"];
    self.lbQuantity.text = quantity.stringValue;
    
    NSArray *tmpImages = [cartItem objectForKey:@"images"];
    
    for (NSDictionary *image in tmpImages) {
        NSString *imageUrl = [[image objectForKey:@"url"] objectForKey:@"http"];
        [self.imgView sd_setImageWithURL:[NSURL URLWithString:imageUrl]];
        break;
    }
}

@end
