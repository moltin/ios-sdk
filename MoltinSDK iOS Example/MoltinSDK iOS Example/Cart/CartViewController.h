//
//  CartViewController.h
//  MoltinSDK iOS Example
//
//  Created by Moltin on 19/06/15.
//  Copyright (c) 2015 Moltin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <PassKit/PassKit.h>
#import <AddressBook/AddressBook.h>
#import "CartListCell.h"
#import <Stripe/Stripe.h>
#import <Stripe/Stripe+ApplePay.h>
#import "Receipt.h"
#import "ReceiptManager.h"

@interface CartViewController : UIViewController<UITableViewDelegate, UITableViewDataSource, CartListCellDelegate, UIActionSheetDelegate, PKPaymentAuthorizationViewControllerDelegate>

@property (strong, nonatomic) NSArray *cartItems;

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UILabel *lbTotalPrice;
@property (weak, nonatomic) IBOutlet UILabel *lbNoProductsInCart;
@property (weak, nonatomic) IBOutlet UIButton *btnCheckout;

+ (CartViewController *)sharedInstance;
- (IBAction)btnCheckoutTap:(id)sender;
@end
