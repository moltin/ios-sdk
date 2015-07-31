//
//  ProductDetailsViewController.h
//  MoltinSDK iOS Example
//
//  Created by Moltin on 15/06/15.
//  Copyright (c) 2015 Moltin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ProductDetailsViewController : UIViewController<UIPickerViewDelegate, UIPickerViewDataSource, UIAlertViewDelegate, UIActionSheetDelegate, SlideNavigationControllerDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicatorImageView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *imagesScrollViewHeightConstraint;
@property (weak, nonatomic) IBOutlet UIScrollView *imagesScrollView;
@property (weak, nonatomic) IBOutlet UILabel *lbCollectionTitle;
@property (weak, nonatomic) IBOutlet UILabel *lbTitle;
@property (weak, nonatomic) IBOutlet UILabel *lbPrice;
@property (weak, nonatomic) IBOutlet UILabel *lbDescription;
@property (weak, nonatomic) IBOutlet UIButton *btnAddToCart;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *modifiersViewHeight;
@property (weak, nonatomic) IBOutlet UIView *modifiersView;

- (id)initWithProductDictionary:(NSDictionary *) productDict;
- (IBAction)btnBackTap:(id)sender;
- (IBAction)btnAddToCartTap:(id)sender;
- (IBAction)btnCartTap:(id)sender;

@end
