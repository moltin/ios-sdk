//
//  AddressEntryViewController.m
//  MoltinSDK iOS Example
//
//  Created by Moltin on 23/06/15.
//  Copyright (c) 2015 Moltin. All rights reserved.
//

#import "AddressEntryViewController.h"

@interface AddressEntryViewController ()

@property (strong, nonatomic) NSArray *countries;
@property (strong, nonatomic) UIPickerView *countryPickerView;
@property (nonatomic) NSInteger selectedCountryIndex;
@property (nonatomic) BOOL countryNameNeedsSet;
@end

@implementation AddressEntryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    
    if (self.shippingAddressEntry) {
        self.title = @"Shipping address";
        self.tfAddress1.placeholder = @"Shipping address line 1";
        self.tfAddress2.placeholder = @"Shipping address line 2 (optional)";
        
        self.tfEmail.hidden = YES;
        self.tfEmailHeightConstraint.constant = 0;
        
        
    }
    else{
        self.title = @"Billing address";
        UIButton *button  = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
        [button setImage:[UIImage imageNamed:@"btn-x"] forState:UIControlStateNormal];
        [button addTarget:self action:@selector(btnCancelTap:) forControlEvents:UIControlEventTouchUpInside];

        UIBarButtonItem *barBtnCancel = [[UIBarButtonItem alloc] initWithCustomView:button];
        self.navigationItem.rightBarButtonItem = barBtnCancel;
    }
    
    NSInteger tag = 0;
    for (MTTextField *textField in self.scrollView.subviews) {
        if ([textField isKindOfClass:[MTTextField class]]) {
            textField.tag = tag;
            textField.delegate = self;
            tag++;
        }
    }
    
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillShow:)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillHide:)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
    
    self.countryPickerView = [[UIPickerView alloc] init];
    self.countryPickerView.delegate = self;
    self.countryPickerView.dataSource = self;
    
    [self.tfCountry setInputView:self.countryPickerView];
    [self.tfCountry setDoneInputAccessoryView];
    
    self.tfCountry.userInteractionEnabled = NO;
    self.tfCountry.hideCursor = TRUE;


    if (self.shippingAddressEntry) {
        self.sameAddress.hidden = YES;
        self.sameAddressLabel.hidden = YES;
    } else {
        self.sameAddress.on = [[NSUserDefaults standardUserDefaults] boolForKey:kMoltinSameShippingAndBillingKey];
        self.sameAddressLabel.hidden = NO;

    }
    
    // set any saved fields up too...
    if ([[NSUserDefaults standardUserDefaults] objectForKey:kMoltinBillingEmailStorageKey]) {
        self.tfEmail.text = [[NSUserDefaults standardUserDefaults] objectForKey:kMoltinBillingEmailStorageKey];
    }
    
    BOOL addressSaved = NO;
    NSString *addressKey;
    if (self.shippingAddressEntry) {
        // get saved shipping address and set fields...
        addressKey = kMoltinShippingAddressStorageKey;
    } else {
        // get saved billing address
        addressKey = kMoltinBillingAddressStorageKey;
    }
    
    if ([[NSUserDefaults standardUserDefaults] objectForKey:addressKey]) {
        addressSaved = YES;
        // okay, retrieve it and fill in text fields form retrieved data...
        NSDictionary *addressDict = [[NSUserDefaults standardUserDefaults] dictionaryForKey:addressKey];
        
        [self setAddressDict:addressDict];
    }
    
    
    [[Moltin sharedInstance].address fieldsWithCustomerId:@""
                                             andAddressId:@""
                                                  success:^(NSDictionary *response)
     {
         self.tfCountry.userInteractionEnabled = YES;
         NSDictionary *tmpCountries = [response valueForKeyPath:@"result.country.available"];
         
         NSMutableArray *tmp = [NSMutableArray array];
         for (NSString *countryCode in [tmpCountries allKeys]) {
             [tmp addObject:@{@"code":countryCode,@"name":[tmpCountries valueForKey:countryCode]}];
         }
         
         NSSortDescriptor *sortByName = [NSSortDescriptor sortDescriptorWithKey:@"name"
                                                                      ascending:YES];
         self.countries = [tmp sortedArrayUsingDescriptors:@[sortByName]];
         
         if (self.countryNameNeedsSet) {
             
             // get the full country name using a predicate to convert the country code up... (if possible)
             NSArray *possibleCountries = [self.countries filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"code == %@", self.tfCountry.text]];
             
             
             if (possibleCountries && possibleCountries.count > 0) {
                 self.tfCountry.text = [possibleCountries[0] objectForKey:@"name"];
                 self.selectedCountryIndex = [self.countries indexOfObject:possibleCountries[0]];
                 [self.countryPickerView selectRow:self.selectedCountryIndex inComponent:0 animated:YES];

             }
             
         }
         
     } failure:^(NSDictionary *response, NSError *error) {
         NSLog(@"ERROR fetching country list: %@", response);
     }];
    
    if (!addressSaved) {
        // start location manager
        self.locationManager = [[CLLocationManager alloc] init];
        
        self.locationManager.delegate = self;
        
        self.locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters;
        
        if ([self.locationManager respondsToSelector:@selector(requestWhenInUseAuthorization)]) {
            // in iOS 8, we need to request auth first
            [self.locationManager requestWhenInUseAuthorization];
        }
        
        [self.locationManager startUpdatingLocation];
        
    }

}



- (void)viewDidLayoutSubviews{
    if (self.scrollView.contentSize.height < self.scrollView.frame.size.height) {
        self.scrollView.contentSize = CGSizeMake(self.scrollView.contentSize.width, self.scrollView.frame.size.height);
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)btnCancelTap:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)btnNextTap:(id)sender {
    BOOL validInput = YES;
    for (MTTextField *textField in self.scrollView.subviews) {
        if ([textField isKindOfClass:[MTTextField class]] && !textField.hidden) {
            if (textField != self.tfAddress2 && [textField isEmpty]) {
                [textField setInvalidInputBorder];
                validInput = NO;
            }
            else{
                [textField clearBorder];
            }
        }
    }
    if (validInput) {
        NSDictionary *addressDict = [self getAddressDict];
        
        if (self.sameAddress.isOn) {
            [[NSUserDefaults standardUserDefaults] setObject:addressDict forKey:kMoltinBillingAddressStorageKey];
            [[NSUserDefaults standardUserDefaults] setObject:self.tfEmail.text forKey:kMoltinBillingEmailStorageKey];
            [[NSUserDefaults standardUserDefaults] setObject:addressDict forKey:kMoltinShippingAddressStorageKey];
            
            [[NSUserDefaults standardUserDefaults] setBool:YES forKey:kMoltinSameShippingAndBillingKey];
            
            [self performSegueWithIdentifier:@"shippingMethodSegue" sender:self];
        }
        else{
            [[NSUserDefaults standardUserDefaults] setBool:NO forKey:kMoltinSameShippingAndBillingKey];
            
            if (self.shippingAddressEntry) {
                [[NSUserDefaults standardUserDefaults] setObject:addressDict forKey:kMoltinShippingAddressStorageKey];
            }
            else{
                [[NSUserDefaults standardUserDefaults] setObject:addressDict forKey:kMoltinBillingAddressStorageKey];
                [[NSUserDefaults standardUserDefaults] setObject:self.tfEmail.text forKey:kMoltinBillingEmailStorageKey];
                
                UIStoryboard *sb = [UIStoryboard storyboardWithName:@"CheckoutStoryboard" bundle:nil];
                AddressEntryViewController *vc = [sb instantiateViewControllerWithIdentifier:@"addressEntryVC"];
                vc.shippingAddressEntry = YES;
                [self.navigationController pushViewController:vc animated:YES];
            }
        }
        
    }
}

- (NSDictionary *)getAddressDict
{
    NSString *address2Entry;
    if (!self.tfAddress2.text || self.tfAddress2.text.length < 1) {
        address2Entry = @"";
    } else {
        address2Entry = self.tfAddress2.text;
    }
    
    NSMutableString *address2 = [NSMutableString stringWithString:address2Entry];
    
    [address2 appendFormat:(address2.length > 0) ? @", %@" : @"%@", self.tfCity.text];
    [address2 appendFormat:(address2.length > 0) ? @", %@" : @"%@", self.tfState.text];
    
    NSString *countryCode = [[self.countries objectAtIndex:self.selectedCountryIndex] valueForKey:@"code"];
    
    return @{
             @"first_name"  : self.tfFirstName.text,
             @"last_name"   : self.tfLastName.text,
             @"address_1"   : self.tfAddress1.text,
             @"address_2"   : address2,
             @"country"     : countryCode,
             @"postcode"    : self.tfZip.text,
             };
}

-(void)setAddressDict:(NSDictionary*)addressDict {
    NSLog(@"%s", __PRETTY_FUNCTION__);
    // disassemble dict...
    
    // if address 2 exists, seperate by comma - if there's > 1 comma, the last will be the state, and the next-but-last the city.
    NSArray *address2Components = [addressDict[@"address_2"] componentsSeparatedByString:@","];

    if (address2Components && (![address2Components isKindOfClass:[NSNull class]])) {
        // last object is state...
        self.tfState.text = [address2Components lastObject];
        
        // second to last object is city...
        self.tfCity.text = [address2Components objectAtIndex:(address2Components.count - 2)];
        
        // strip any whitespace...
        self.tfCity.text = [self.tfCity.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
        self.tfState.text = [self.tfState.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];

        
        if (address2Components.count > 2) {
            // address2 exists too...
            self.tfAddress2.text = [address2Components firstObject];
        }
        
    }
    
    // set other fields too...
    self.tfFirstName.text = addressDict[@"first_name"];
    self.tfLastName.text = addressDict[@"last_name"];
    self.tfAddress1.text = addressDict[@"address_1"];


    self.tfCountry.text = addressDict[@"country"];
    self.countryNameNeedsSet = TRUE;
    
    self.tfZip.text = addressDict[@"postcode"];
    
}

#pragma mark - Location manager
- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations {
    if (locations && locations.count  > 0) {
        CLLocation *location = [locations lastObject];
        
        // let's geocode...
        self.geocoder = [[CLGeocoder alloc] init];
        
        __weak AddressEntryViewController *weakSelf = self;
        [self.geocoder reverseGeocodeLocation:location completionHandler:^(NSArray *placemarks, NSError *error) {
            if (placemarks && placemarks.count > 0) {
                CLPlacemark *placemark = [placemarks firstObject];
                                
                if (weakSelf.tfCountry.text.length == 0) {
                    // fill in country from placemark
                    weakSelf.tfCountry.text = placemark.country;
                    
                    if (weakSelf.countries && weakSelf.countries.count > 0) {
                        // there's countries already, work out the right one...
                        NSArray *possibleCountries = [weakSelf.countries filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"name == %@", weakSelf.tfCountry.text]];
                        
                        if (possibleCountries && possibleCountries.count > 0) {
                            NSLog(@"found possible country");
                            weakSelf.tfCountry.text = [possibleCountries[0] objectForKey:@"name"];
                            weakSelf.selectedCountryIndex = [weakSelf.countries indexOfObject:possibleCountries[0]];
                            [weakSelf.countryPickerView selectRow:weakSelf.selectedCountryIndex inComponent:0 animated:YES];
                        }
                    }
                    
                }
                
                if (weakSelf.tfAddress1.text.length == 0) {
                    // fill in street from placemark
                    weakSelf.tfAddress1.text = placemark.thoroughfare;
                }
                
                if (weakSelf.tfAddress2.text.length == 0) {
                    // fill in address 2 from placemark
                    weakSelf.tfAddress2.text = placemark.subLocality;
                }
                
                if (weakSelf.tfState.text.length == 0) {
                    // fill in state from placemark
                    weakSelf.tfState.text = placemark.administrativeArea;
                }
                
                if (weakSelf.tfZip.text.length == 0) {
                    // fill in postcode from placemark
                    weakSelf.tfZip.text = placemark.postalCode;
                }
                
                if (weakSelf.tfCity.text.length == 0) {
                    // fill in city from placemark
                    weakSelf.tfCity.text = placemark.locality;

                }
                
            }
        }];
        
        // one location's enough for our needs
        [self.locationManager stopUpdatingLocation];
        
    }
}

#pragma mark - PickerView
-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return self.countries.count;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    NSDictionary *countryDict = [self.countries objectAtIndex:row];
    return [countryDict valueForKey:@"name"];
}

-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    self.selectedCountryIndex = row;
    self.tfCountry.text = [self pickerView:pickerView titleForRow:row forComponent:component];
}

#pragma mark - TextField
- (void)scrollToTextField:(UITextField *) textField{
    UIScrollView* v = (UIScrollView*) self.view ;
    CGRect rc = [textField bounds];
    rc = [textField convertRect:rc toView:v];
    rc.origin.x = 0 ;
    rc.origin.y -= 60 ;
    
    rc.size.height = 400;
    [self.scrollView scrollRectToVisible:rc animated:YES];
}

-(BOOL)textFieldShouldReturn:(UITextField*)textField;
{
    NSInteger nextTag = textField.tag + 1;
    UIResponder* nextResponder = [textField.superview viewWithTag:nextTag];
    if (nextResponder) {
        [nextResponder becomeFirstResponder];
    } else {
        [textField resignFirstResponder];
    }
    return NO;
}

#pragma mark - Keyboard
- (void)keyboardWillShow:(NSNotification *)notification
{
    CGSize keyboardSize = [[[notification userInfo] objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
    
    UIEdgeInsets contentInsets;
    if (UIInterfaceOrientationIsPortrait([[UIApplication sharedApplication] statusBarOrientation])) {
        contentInsets = UIEdgeInsetsMake(0.0, 0.0, (keyboardSize.height), 0.0);
    } else {
        contentInsets = UIEdgeInsetsMake(0.0, 0.0, (keyboardSize.width), 0.0);
    }
    
    self.scrollView.contentInset = contentInsets;
    self.scrollView.scrollIndicatorInsets = contentInsets;
}

- (void)keyboardWillHide:(NSNotification *)notification
{
    self.scrollView.contentInset = UIEdgeInsetsZero;
    self.scrollView.scrollIndicatorInsets = UIEdgeInsetsZero;
}

@end
