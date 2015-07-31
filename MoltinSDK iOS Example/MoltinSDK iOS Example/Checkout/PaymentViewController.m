//
//  CreditCardEntryViewController.m
//  MoltinSDK iOS Example
//
//  Created by Moltin on 26/06/15.
//  Copyright (c) 2015 Moltin. All rights reserved.
//

#import "PaymentViewController.h"
#import "CartViewController.h"
#import "ReceiptViewController.h"

static NSString *PAYMENT_GATEWAY = @"stripe";
static NSString *PAYMENT_METHOD  = @"purchase";

@interface PaymentViewController ()

@property (strong, nonatomic) MBProgressHUD *progressHUD;
@property (strong, nonatomic) NSString *customerId;
@property (strong, nonatomic) NSString *orderId;

@property (strong, nonatomic) UIPickerView *expiryMonthPicker;
@property (strong, nonatomic) UIPickerView *expiryYearPicker;

@property (nonatomic) NSInteger minYear;
@property (nonatomic) NSInteger month;
@property (nonatomic) NSInteger year;

@property (strong, nonatomic) NSDictionary *receipt;

@end

@implementation PaymentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSDateComponents *components = [[NSCalendar currentCalendar] components:NSCalendarUnitYear fromDate:[NSDate date]];
    self.minYear = [components year];
    self.year = self.minYear;
    self.month = 0;
    
    self.title = @"Payment";
    
    self.expiryMonthPicker = [[UIPickerView alloc] init];
    self.expiryMonthPicker.delegate = self;
    self.expiryMonthPicker.dataSource = self;
    [self.tfExpiryMonth setInputView:self.expiryMonthPicker];
    [self.tfExpiryMonth setDoneInputAccessoryView];
    
    self.expiryYearPicker = [[UIPickerView alloc] init];
    self.expiryYearPicker.delegate = self;
    self.expiryYearPicker.dataSource = self;
    [self.tfExpiryYear setInputView:self.expiryYearPicker];
    [self.tfExpiryYear setDoneInputAccessoryView];
    
    NSInteger tag = 0;
    for (MTTextField *textField in self.view.subviews) {
        if ([textField isKindOfClass:[MTTextField class]]) {
            textField.tag = tag;
            textField.delegate = self;
            tag++;
        }
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)btnCheckoutTap:(id)sender {
    BOOL validInput = YES;
    for (MTTextField *textField in self.view.subviews) {
        if ([textField isKindOfClass:[MTTextField class]] && !textField.hidden) {
            if ([textField isEmpty]) {
                [textField setInvalidInputBorder];
                validInput = NO;
            }
            else{
                [textField clearBorder];
            }
        }
    }
    if (validInput) {
        [self getCustomer];
    }
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

-(void)textFieldDidBeginEditing:(UITextField *)textField{
    if (textField == self.tfExpiryMonth && self.tfExpiryMonth.text.length == 0) {
        self.tfExpiryMonth.text = @"1";
    }
    else if (textField == self.tfExpiryYear && self.tfExpiryYear.text.length == 0) {
        self.tfExpiryYear.text = [NSString stringWithFormat:@"%ld", (long)self.minYear];
    }
}

#pragma mark - PickerView
-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    if (pickerView == self.expiryMonthPicker) {
        return 12;
    }
    else if (pickerView == self.expiryYearPicker)
    {
        return 10;
    }
    
    return 0;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    if (pickerView == self.expiryYearPicker){
        return [NSString stringWithFormat:@"%ld", self.minYear + (long)row];
    }
    return [NSString stringWithFormat:@"%ld", (long)row+1];
}

-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    if (pickerView == self.expiryMonthPicker) {
        self.tfExpiryMonth.text = [self pickerView:pickerView titleForRow:row forComponent:component];
    }
    else if (pickerView == self.expiryYearPicker){
        self.tfExpiryYear.text = [self pickerView:pickerView titleForRow:row forComponent:component];
    }
}


#pragma mark - API CALLS
- (void)getCustomer{
    self.progressHUD = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [[Moltin sharedInstance].customer findWithParameters:@{ @"email" : [self getCustomerEmail] }
                                                 success:^(NSDictionary *response)
    {
        NSArray *result = [response objectForKey:@"result"];
        if (result.count == 0) {
            [self createCustomer];
        }
        else{
            self.customerId = [[result firstObject] valueForKey:@"id"];
            [self order];
        }
    } failure:^(NSDictionary *response, NSError *error) {
        [self.progressHUD hide:YES];
        
        NSString *errorMessage = error.localizedDescription;
        if (response && ![[response valueForKey:@"status"] boolValue]) {
            NSString *responseMessage = [[response objectForKey:@"errors"] firstObject];
            NSLog(@"ERROR: %@", response);
            errorMessage = responseMessage;
        }
        ALERT(@"Error", errorMessage);
    }];
}

- (void)createCustomer{
    self.progressHUD.detailsLabelText = @"Creating new customer...";
    
    NSDictionary *billingAddress = [self getAddressWithKey:kMoltinBillingAddressStorageKey];
    NSString *customerName = [billingAddress valueForKey:@"first_name"];
    NSString *customerLastName = [billingAddress valueForKey:@"last_name"];
    NSString *customerEmail = [self getCustomerEmail];
    
    [[Moltin sharedInstance].customer createWithParameters:@{@"first_name" : customerName, @"last_name" : customerLastName, @"email" : customerEmail}
                                                   success:^(NSDictionary *response)
    {
        if ([[response valueForKey:@"status"] boolValue]) {
            self.customerId = [response valueForKeyPath:@"result.id"];
            [self order];
        }
        else{
            NSLog(@"ERROR CREATING CUSTOMER: %@", response);
            NSString *errors = [[response objectForKey:@"errors"] firstObject];
            ALERT(@"Error creating customer", errors);
        }
        
    } failure:^(NSDictionary *response, NSError *error) {
        [self.progressHUD hide:YES];
        
        NSString *errorMessage = error.localizedDescription;
        if (response && ![[response valueForKey:@"status"] boolValue]) {
            NSString *responseMessage = [[response objectForKey:@"errors"] firstObject];
            NSLog(@"ERROR: %@", response);
            errorMessage = responseMessage;
        }
        ALERT(@"Error creating customer", errorMessage);
    }];
}

- (void)order{
    
    NSDictionary *orderParameters = @{
                                      @"customer" : self.customerId,
                                      @"shipping" : self.shippingMethodSlug,
                                      @"gateway"  : PAYMENT_GATEWAY,
                                      @"bill_to"  : [self getAddressWithKey:kMoltinBillingAddressStorageKey],
                                      @"ship_to"  : [self getAddressWithKey:kMoltinShippingAddressStorageKey]
                                      };
    
    self.progressHUD.detailsLabelText = @"Proccessing order...";
    
    [[Moltin sharedInstance].cart orderWithParameters:orderParameters
                                              success:^(NSDictionary *response)
    {
        if ([[response valueForKey:@"status"] boolValue]) {
            self.orderId = [response valueForKeyPath:@"result.id"];
            [self payment];
        }
        else{
            [self.progressHUD hide:YES];
            NSString *responseMessage = [response valueForKey:@"error"];
            NSLog(@"ERROR: %@", response);
            ALERT(@"Order error", responseMessage);
        }
        
    } failure:^(NSDictionary *response, NSError *error) {
        [self.progressHUD hide:YES];
        
        NSString *errorMessage = error.localizedDescription;
        if (response && ![[response valueForKey:@"status"] boolValue]) {
            NSString *responseMessage = [response valueForKey:@"error"];
            NSLog(@"ERROR: %@", response);
            errorMessage = responseMessage;
        }
        ALERT(@"Order error", errorMessage);
    }];
}

- (void)payment{
    
    NSDictionary *paymentParameters = @{
                                        @"data" : @{
                                                @"number"       : self.tfCardNumber.text,
                                                @"expiry_month" : self.tfExpiryMonth.text,
                                                @"expiry_year"  : self.tfExpiryYear.text,
                                                @"cvv"          : self.tfCvv.text
                                                }
                                        };
    
    self.progressHUD.detailsLabelText = @"Proccessing payment...";
    [[Moltin sharedInstance].checkout paymentWithMethod:PAYMENT_METHOD
                                                  order:self.orderId
                                             parameters:paymentParameters
                                                success:^(NSDictionary *response)
    {
        if ([[response valueForKey:@"status"] boolValue]) {
            [[NSNotificationCenter defaultCenter] postNotificationName:kMoltinNotificationRefreshCart object:nil];
            
            self.receipt = response;
            
            NSString *responseMessage = [response valueForKeyPath:@"result.message"];
            self.progressHUD.detailsLabelText = responseMessage;
            [self.progressHUD hide:YES afterDelay:2];
            [self performSegueWithIdentifier:@"receiptSegue" sender:self];
        }
        else{
            self.receipt = nil;
            NSString *responseMessage = [response valueForKey:@"error"];
            ALERT(@"Payment error", responseMessage);
            NSLog(@"ERROR PAYMENT: %@", response);
        }
        
    } failure:^(NSDictionary *response, NSError *error) {
        self.receipt = nil;
        [self.progressHUD hide:YES];
        
        NSString *errorMessage = error.localizedDescription;
        if (response && ![[response valueForKey:@"status"] boolValue]) {
            NSString *responseMessage = [response valueForKey:@"error"];
            NSLog(@"ERROR: %@", response);
            errorMessage = responseMessage;
        }
        ALERT(@"Payment error", errorMessage);
    }];
}

- (void)dismissViewController{
    [self dismissViewControllerAnimated:YES completion:nil];
}
    
- (NSString *)getCustomerEmail{
    return [[NSUserDefaults standardUserDefaults] stringForKey:kMoltinBillingEmailStorageKey];
}

- (NSDictionary *)getAddressWithKey:(NSString *) key{
    return [[NSUserDefaults standardUserDefaults] objectForKey:key];
}


 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
     if ([segue.identifier isEqualToString:@"receiptSegue"]) {
         ReceiptViewController *destViewController = segue.destinationViewController;
         destViewController.products = [CartViewController sharedInstance].cartItems;
         
         [CartViewController sharedInstance].cartItems = nil;
         
         destViewController.reciept = self.receipt;
     }
 }

@end
