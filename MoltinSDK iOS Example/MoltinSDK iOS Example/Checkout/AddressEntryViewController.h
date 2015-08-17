//
//  AddressEntryViewController.h
//  MoltinSDK iOS Example
//
//  Created by Moltin on 23/06/15.
//  Copyright (c) 2015 Moltin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import "MTTextField.h"

@interface AddressEntryViewController : UIViewController<UITextFieldDelegate, UIPickerViewDelegate, UIPickerViewDataSource, CLLocationManagerDelegate>

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
@property (weak, nonatomic) IBOutlet UIButton *btnNext;

@property (nonatomic, strong) CLLocationManager *locationManager;
@property (nonatomic, strong) CLGeocoder *geocoder;

@property (weak, nonatomic) IBOutlet UISwitch *sameAddress;
@property (weak, nonatomic) IBOutlet UILabel *sameAddressLabel;

@property (nonatomic) BOOL shippingAddressEntry;

- (IBAction)btnCancelTap:(id)sender;
- (IBAction)btnNextTap:(id)sender;

@end
