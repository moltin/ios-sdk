//
//  CartListCell.h
//  MoltinSDK iOS Example
//
//  Created by Moltin on 22/06/15.
//  Copyright (c) 2015 Moltin. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol CartListCellDelegate <NSObject>

- (void)updateCartWithProductId:(NSString *) productId andQuantity:(NSNumber *) quantity;

@end

@interface CartListCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *imgView;
@property (weak, nonatomic) IBOutlet UILabel *lbProductName;
@property (weak, nonatomic) IBOutlet UILabel *lbPrice;
@property (weak, nonatomic) IBOutlet UILabel *lbInfo;
@property (weak, nonatomic) IBOutlet UILabel *lbQuantity;

@property (strong, nonatomic) NSArray *images;
@property (nonatomic, weak) id <CartListCellDelegate> delegate;

- (IBAction)btnMinusTap:(id)sender;
- (IBAction)btnPlusTap:(id)sender;

- (void)configureWithCartItemDict:(NSDictionary *) cartItem;

@end
