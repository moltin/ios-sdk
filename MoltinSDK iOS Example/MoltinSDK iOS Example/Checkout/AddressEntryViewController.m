//
//  AddressEntryViewController.m
//  MoltinSDK iOS Example
//
//  Created by Gasper Rebernak on 23/06/15.
//  Copyright (c) 2015 Gasper Rebernak. All rights reserved.
//

#import "AddressEntryViewController.h"

@interface AddressEntryViewController ()

@end

@implementation AddressEntryViewController
/*
- (id)init{
    self = [super initWithNibName:@"AddressEntryView" bundle:nil];
    if (self)
    {
        
    }
    return self;
}
*/
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"Billing address";
    
    NSInteger tag = 0;
    for (MTTextField *textField in self.scrollView.subviews) {
        if ([textField isKindOfClass:[MTTextField class]]) {
            textField.tag = tag;
            textField.delegate = self;
            tag++;
        }
    }
    
    [self.btnSameAddress setSelected:YES];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    CGFloat scrollviewContentSize = self.scrollView.contentSize.height;
    NSLog(@"TEST: %f", scrollviewContentSize);
    
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
        if ([textField isKindOfClass:[MTTextField class]]) {
            if (textField != self.tfAddressLine2 && [textField isEmpty]) {
                [textField setInvalidInputBorder];
                validInput = NO;
            }
            else{
                [textField clearBorder];
            }
        }
    }
    if (validInput) {
        [self performSegueWithIdentifier:@"shippingMethodSegue" sender:self];
    }
}

#pragma mark - TextField
-(BOOL)textFieldShouldReturn:(UITextField*)textField;
{
    NSInteger nextTag = textField.tag + 1;
    // Try to find next responder
    UIResponder* nextResponder = [textField.superview viewWithTag:nextTag];
    if (nextResponder) {
        // Found next responder, so set it.
        [nextResponder becomeFirstResponder];
    } else {
        // Not found, so remove keyboard.
        [textField resignFirstResponder];
    }
    return NO; // We do not want UITextField to insert line-breaks.
}

@end
