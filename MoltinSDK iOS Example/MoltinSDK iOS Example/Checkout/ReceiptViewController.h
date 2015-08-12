//
//  ReceiptViewController.h
//  MoltinSDK iOS Example
//
//  Created by Moltin on 08/07/15.
//  Copyright (c) 2015 Moltin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ReceiptViewController : UIViewController

@property (strong, nonatomic) NSArray *products;
@property (strong, nonatomic) NSDictionary *reciept;
@property (strong, nonatomic) NSDate *purchaseDate;

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *tableViewHeightConstraint;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UILabel *lbShippingCompany;
@property (weak, nonatomic) IBOutlet UILabel *lbShippingPrice;

@property (weak, nonatomic) IBOutlet UILabel *orderDateLabel;

@property (weak, nonatomic) IBOutlet UILabel *lbAddressLine1;
@property (weak, nonatomic) IBOutlet UILabel *lbAddressLine2;
@property (weak, nonatomic) IBOutlet UILabel *lbAddressCountry;

@property (weak, nonatomic) IBOutlet UILabel *lbPaymentCard;
@property (weak, nonatomic) IBOutlet UILabel *lbPaymentSubtotal;
@property (weak, nonatomic) IBOutlet UILabel *lbPaymentDelivery;
@property (weak, nonatomic) IBOutlet UILabel *lbPaymentTotal;

@property (nonatomic) BOOL isIndividualModalView;

@end
