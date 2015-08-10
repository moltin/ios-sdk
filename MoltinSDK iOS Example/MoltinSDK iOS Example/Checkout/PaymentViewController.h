//
//  CreditCardEntryViewController.h
//  MoltinSDK iOS Example
//
//  Created by Moltin on 26/06/15.
//  Copyright (c) 2015 Moltin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MTTextField.h"
#import "ReceiptManager.h"
#import "Receipt.h"

@interface PaymentViewController : UIViewController<UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet MTTextField *tfCardNumber;
@property (weak, nonatomic) IBOutlet MTTextField *tfExpiryDate;
@property (weak, nonatomic) IBOutlet MTTextField *tfCvv;

@property (strong, nonatomic) NSString *shippingMethodSlug;

- (IBAction)btnCheckoutTap:(id)sender;
- (IBAction)cvvValueChanged:(id)sender;
- (IBAction)cardNumberValueChanged:(id)sender;

@end
