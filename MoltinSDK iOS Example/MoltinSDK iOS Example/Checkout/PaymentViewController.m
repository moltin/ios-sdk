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

static NSInteger MAX_CVV_LENGTH = 4;

// Apparently, no credit cards have under 12 or over 19 digits... http://validcreditcardnumbers.info/?p=9
static NSInteger MIN_CARD_LENGTH = 12;
static NSInteger MAX_CARD_LENGTH = 19;


@interface PaymentViewController ()

@property (strong, nonatomic) MBProgressHUD *progressHUD;
@property (strong, nonatomic) NSString *customerId;
@property (strong, nonatomic) NSString *orderId;

@property (strong, nonatomic) UIPickerView *expiryDatePicker;

@property (nonatomic) NSArray *months;

@property (nonatomic) NSInteger minYear;
@property (nonatomic) NSInteger month;
@property (nonatomic) NSInteger year;

@property (strong, nonatomic) NSDictionary *receipt;

@end

@implementation PaymentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSMutableArray *months = [NSMutableArray array];
    for (NSUInteger i = 1; i <= 12; i++) {
        [months addObject:[NSString stringWithFormat:@"%lu", (unsigned long)i]];
    }
    self.months = months;
    
    NSDateComponents *components = [[NSCalendar currentCalendar] components:NSCalendarUnitYear fromDate:[NSDate date]];
    self.minYear = [components year];
    self.year = self.minYear;
    self.month = 1;
    
    self.title = @"Payment";
    
    self.expiryDatePicker = [[UIPickerView alloc] init];
    self.expiryDatePicker.delegate = self;
    self.expiryDatePicker.dataSource = self;
    [self.tfExpiryDate setInputView:self.expiryDatePicker];
    [self.tfExpiryDate setDoneInputAccessoryView];
    
    self.tfExpiryDate.hideCursor = TRUE;

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

-(BOOL)textFieldShouldReturn:(UITextField*)textField {
    NSInteger nextTag = textField.tag + 1;
    UIResponder* nextResponder = [textField.superview viewWithTag:nextTag];
    if (nextResponder) {
        [nextResponder becomeFirstResponder];
    } else {
        [textField resignFirstResponder];
    }
    return NO;
}

-(void)textFieldDidBeginEditing:(UITextField *)textField {
    
}

#pragma mark - PickerView
-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 2;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    if (component == 0) {
        return self.months.count;
    }
    else
    {
        return 10;
    }
    
    return 0;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    if (component == 0){
        return [self.months objectAtIndex:row];
    }
    
    return [[NSString stringWithFormat:@"%ld", self.minYear + (long)row] substringFromIndex:2];
    
}

-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {

    NSString *dateString;
    if (component == 0) {
        // month selected
        self.month = (row + 1);
        
        dateString = [NSString stringWithFormat:@"%@/%ld", [self pickerView:pickerView titleForRow:row forComponent:component], (long)self.year];
    } else {
        // year selected
        self.year = (self.minYear + row);
        
        dateString = [NSString stringWithFormat:@"%ld/%@", (long)self.month, [self pickerView:pickerView titleForRow:row forComponent:component]];
    }
    
    
    self.tfExpiryDate.text = dateString;
    
}

- (BOOL)numericStringCheck:(NSString*)string {
    
    NSCharacterSet *nonDigitChars = [[NSCharacterSet decimalDigitCharacterSet] invertedSet];
    
    if ([string rangeOfCharacterFromSet:nonDigitChars].location == NSNotFound) {
        // definitely numeric entierly
        return TRUE;
    }
    
    return FALSE;
}

- (IBAction)cvvValueChanged:(id)sender {
    // do some quick validation to check the CVV is a number, less than or equal to 4 digits in length (defined in MAX_CVV_LENGTH constant).
    
    BOOL lengthCorrect = (self.tfCvv.text.length <= MAX_CVV_LENGTH);

    BOOL entirelyNumericString = [self numericStringCheck:self.tfCvv.text];
    
    if (lengthCorrect && entirelyNumericString) {
        // valid.
        [self.tfCvv clearBorder];
    } else {
        [self.tfCvv setInvalidInputBorder];
    }
    
}

- (IBAction)cardNumberValueChanged:(id)sender {
    
    BOOL lengthCorrect = (self.tfCardNumber.text.length <= MAX_CARD_LENGTH && self.tfCardNumber.text.length >= MIN_CARD_LENGTH);
    
    BOOL entirelyNumericString = [self numericStringCheck:self.tfCardNumber.text];
    
    if (entirelyNumericString && lengthCorrect) {
        // valid.
        [self.tfCardNumber clearBorder];
    } else {
        [self.tfCardNumber setInvalidInputBorder];
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
    
    // convert NSIntegers to strings...
    NSString *monthString = [[NSNumber numberWithInteger:self.month] stringValue];
    NSString *yearString = [[NSNumber numberWithInteger:self.year] stringValue];

    NSDictionary *paymentParameters = @{
                                        @"data" : @{
                                                @"number"       : self.tfCardNumber.text,
                                                @"expiry_month" : monthString,
                                                @"expiry_year"  : yearString,
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
            
            // save receipt for persistence
            Receipt *receipt = [[Receipt alloc] init];
            receipt.receiptData = self.receipt;
            receipt.products = [CartViewController sharedInstance].cartItems;
            receipt.creationDate = [NSDate date];
            [ReceiptManager saveReceipt:receipt];
                        
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
         destViewController.purchaseDate = [NSDate date];

         [CartViewController sharedInstance].cartItems = nil;
         
         destViewController.reciept = self.receipt;
     }
 }

@end
