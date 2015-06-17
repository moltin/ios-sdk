//
//  ProductListCell.m
//  MoltinSDK iOS Example
//
//  Created by Gasper Rebernak on 15/06/15.
//  Copyright (c) 2015 Gasper Rebernak. All rights reserved.
//

#import "ProductListCell.h"

@implementation ProductListCell

- (void)awakeFromNib {
    // Initialization code
    self.layer.cornerRadius = 10;
    self.clipsToBounds = YES;
    self.images = [NSMutableArray array];
    self.imageView.layer.borderColor = [UIColor redColor].CGColor;
    self.imageView.layer.borderWidth = 1;
    
    self.lbCollectionTitle.layer.borderColor = [UIColor redColor].CGColor;
    self.lbCollectionTitle.layer.borderWidth = 1;
    
    self.imagesScrollView.layer.borderColor = [UIColor greenColor].CGColor;
    self.imagesScrollView.layer.borderWidth = 1;
    
    if (IS_IPHONE_4) {
        self.lbTitle.numberOfLines = 1;
    }
    
}

- (void)configureWithProductDict:(NSDictionary *) product
{
    if (IS_IPHONE_4) {
        self.imageHeightConstraint.constant = self.imageWidthConstraint.constant - 50;
    }
    
    [self.images removeAllObjects];
    
    self.layer.cornerRadius = 10;
    self.lbCollectionTitle.text = [[[[product objectForKey:@"collection"] objectForKey:@"data"] valueForKey:@"title"] uppercaseString];
    self.lbTitle.text = [product valueForKey:@"title"];
    self.lbPrice.text = [[[product objectForKey:@"pricing"] objectForKey:@"formatted"] valueForKey:@"with_tax"];;
    
    NSArray *tmpImages = [product objectForKey:@"images"];
    
    
    for (NSDictionary *image in tmpImages) {
        NSString *imageUrl = [[image objectForKey:@"url"] objectForKey:@"http"];
        [self.images addObject:imageUrl];
    }
    if (self.images.count > 0) {
        [self.imageView sd_setImageWithURL:[NSURL URLWithString:[self.images objectAtIndex:0]]];
    }
    
    if (self.images.count > 1) {
        self.imageHeightConstraint.constant = self.imageWidthConstraint.constant - self.imagesScrollViewHeightConstraint.constant - (IS_IPHONE_4 ? 50 : 0);
        for (UIView *view in self.imagesScrollView.subviews) {
            if ([view isKindOfClass:[UIImageView class]] && view.tag == 99) {
                [view removeFromSuperview];
            }
        }
        
        self.imagesScrollViewHeightConstraint.constant = 65;
        int i = 0;
        for (NSString *imageUrl in self.images) {
            UIImageView *smallImage = [[UIImageView alloc] initWithFrame:CGRectMake(i*65, 0, self.imagesScrollViewHeightConstraint.constant, self.imagesScrollViewHeightConstraint.constant)];
            smallImage.userInteractionEnabled = YES;
            smallImage.tag = 99; // tag t know witch ImageViews to remove from "imagesScrollView"
            [smallImage sd_setImageWithURL:[NSURL URLWithString:imageUrl]];
            
            [self.imagesScrollView addSubview:smallImage];
            
            UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(smallImageViewTap:)];
            [smallImage addGestureRecognizer:tapGesture];
            
            i++;
        }
        self.imagesScrollView.contentSize = CGSizeMake(i*65, 65);
    }
    else{
        self.imagesScrollViewHeightConstraint.constant = 0;
    }
    
}

- (void)smallImageViewTap:(UITapGestureRecognizer *) sender{
    if ([sender.view isKindOfClass:[UIImageView class]]) {
        self.imageView.image = [(UIImageView*)sender.view image];
    }
}

@end
