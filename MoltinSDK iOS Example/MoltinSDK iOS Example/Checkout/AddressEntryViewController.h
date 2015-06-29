//
//  AddressEntryViewController.h
//  MoltinSDK iOS Example
//
//  Created by Gasper Rebernak on 23/06/15.
//  Copyright (c) 2015 Gasper Rebernak. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MTTextField.h"

@interface AddressEntryViewController : UIViewController<UITextFieldDelegate, UIPickerViewDelegate, UIPickerViewDataSource>

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet MTTextField *tfEmail;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *tfEmailHeightConstraint;
@property (weak, nonatomic) IBOutlet MTTextField *tfFirstName;
@property (weak, nonatomic) IBOutlet MTTextField *tfLastName;
@property (weak, nonatomic) IBOutlet MTTextField *tfAddress1;
@property (weak, nonatomic) IBOutlet MTTextField *tfAddress2;
@property (weak, nonatomic) IBOutlet MTTextField *tfCity;
@property (weak, nonatomic) IBOutlet MTTextField *tfState;
@property (weak, nonatomic) IBOutlet MTTextField *tfZip;
@property (weak, nonatomic) IBOutlet MTTextField *tfCountry;
@property (weak, nonatomic) IBOutlet UIButton *btnSameAddress;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *btnSameAddressHeightConstraint;
@property (weak, nonatomic) IBOutlet UIButton *btnNext;

@property (nonatomic) BOOL shippingAddressEntry;

- (IBAction)btnSameAddressTap:(id)sender;
- (IBAction)btnCancelTap:(id)sender;
- (IBAction)btnNextTap:(id)sender;

@end
