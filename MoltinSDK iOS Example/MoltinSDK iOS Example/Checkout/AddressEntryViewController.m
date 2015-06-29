//
//  AddressEntryViewController.m
//  MoltinSDK iOS Example
//
//  Created by Gasper Rebernak on 23/06/15.
//  Copyright (c) 2015 Gasper Rebernak. All rights reserved.
//

#import "AddressEntryViewController.h"

@interface AddressEntryViewController ()

@property (strong, nonatomic) NSArray *countries;
@property (strong, nonatomic) UIPickerView *countryPickerView;
@property (nonatomic) NSInteger selectedCountryIndex;
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
        
        self.btnSameAddress.selected = NO;
        self.btnSameAddress.hidden = YES;
        self.btnSameAddressHeightConstraint.constant = 0;
    }
    else{
        self.title = @"Billing address";
        UIBarButtonItem *barBtnCancel = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(btnCancelTap:)];
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
    
    
    [self.btnSameAddress setSelected:YES];
    
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
    
    [[Moltin sharedInstance].address fieldsWithCustomerId:@""
                                             andAddressId:@""
                                                  success:^(NSDictionary *response)
     {
         self.tfCountry.userInteractionEnabled = YES;
         NSDictionary *tmpCountries = [[[response objectForKey:@"result"] objectForKey:@"country"] objectForKey:@"available"];
         
         NSMutableArray *tmp = [NSMutableArray array];
         for (NSString *countryCode in [tmpCountries allKeys]) {
             [tmp addObject:@{@"code":countryCode,@"name":[tmpCountries valueForKey:countryCode]}];
         }
         
         NSSortDescriptor *sortByName = [NSSortDescriptor sortDescriptorWithKey:@"name"
                                                                      ascending:YES];
         self.countries = [tmp sortedArrayUsingDescriptors:@[sortByName]];
         
         NSLog(@"COUNTRIES: %@", self.countries);
         
     } failure:^(NSDictionary *response, NSError *error) {
         
     }];

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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)btnSameAddressTap:(UIButton *)sender {
    [sender setSelected:!sender.selected];
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
        
        if (self.btnSameAddress.selected) {
            [[NSUserDefaults standardUserDefaults] setObject:addressDict forKey:kMoltinBillingAddressStorageKey];
            [[NSUserDefaults standardUserDefaults] setObject:self.tfEmail.text forKey:kMoltinBillingEmailStorageKey];
            [[NSUserDefaults standardUserDefaults] setObject:addressDict forKey:kMoltinShippingAddressStorageKey];
            
            [self performSegueWithIdentifier:@"shippingMethodSegue" sender:self];
        }
        else{
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
    NSMutableString *address2 = [NSMutableString stringWithString:self.tfAddress2.text];
    
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

#pragma makr - PickerView
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
