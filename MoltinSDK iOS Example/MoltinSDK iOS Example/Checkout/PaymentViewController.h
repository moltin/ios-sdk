//
//  CreditCardEntryViewController.h
//  MoltinSDK iOS Example
//
//  Created by Moltin on 26/06/15.
//  Copyright (c) 2015 Moltin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MTTextField.h"

@interface PaymentViewController : UIViewController<UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet MTTextField *tfCardNumber;
@property (weak, nonatomic) IBOutlet MTTextField *tfExpiryMonth;
@property (weak, nonatomic) IBOutlet MTTextField *tfExpiryYear;
@property (weak, nonatomic) IBOutlet MTTextField *tfCvv;

@property (strong, nonatomic) NSString *shippingMethodSlug;

- (IBAction)btnCheckoutTap:(id)sender;
@end
