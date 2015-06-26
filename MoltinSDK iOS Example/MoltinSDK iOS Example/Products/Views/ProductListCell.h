//
//  ProductListCell.h
//  MoltinSDK iOS Example
//
//  Created by Gasper Rebernak on 15/06/15.
//  Copyright (c) 2015 Gasper Rebernak. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ProductListCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *imageHeightConstraint;
//@property (weak, nonatomic) IBOutlet NSLayoutConstraint *imageWidthConstraint;
@property (weak, nonatomic) IBOutlet UIScrollView *imagesScrollView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *imagesScrollViewHeightConstraint;
@property (weak, nonatomic) IBOutlet UILabel *lbCollectionTitle;
@property (weak, nonatomic) IBOutlet UILabel *lbTitle;
@property (weak, nonatomic) IBOutlet UILabel *lbPrice;

@property (strong, nonatomic) NSMutableArray *images;
- (void)configureWithProductDict:(NSDictionary *) product;
- (IBAction)btnMoreInfoTap:(id)sender;

@end
