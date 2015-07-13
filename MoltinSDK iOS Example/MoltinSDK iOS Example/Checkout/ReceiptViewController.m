//
//  ReceiptViewController.m
//  MoltinSDK iOS Example
//
//  Created by Gasper Rebernak on 08/07/15.
//  Copyright (c) 2015 Gasper Rebernak. All rights reserved.
//

#import "ReceiptViewController.h"
#import "ReceiptProductCell.h"

static NSString *ReceiptProductCellIdentifier = @"MoltinReceiptProductCell";

@interface ReceiptViewController ()

@end

@implementation ReceiptViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"RECEIPT";
    
    UIButton *button  = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
    [button setImage:[UIImage imageNamed:@"btn-x"] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(btnCloseTap:) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *barBtnClose = [[UIBarButtonItem alloc] initWithCustomView:button];
    self.navigationItem.rightBarButtonItem = barBtnClose;
    
    self.navigationItem.hidesBackButton = YES;
    
    [self.tableView registerNib:[UINib nibWithNibName:@"ReceiptProductCell" bundle:nil] forCellReuseIdentifier:ReceiptProductCellIdentifier];
    
    //comment this if you want the table view to be scrollable | 120 is the tableViewCell height
    self.tableViewHeightConstraint.constant = self.products.count * 120;
    self.tableView.bounces = NO;
    
    self.lbShippingCompany.text = [self.reciept valueForKeyPath:@"result.order.shipping.data.company"];
    self.lbShippingPrice.text = [self.reciept valueForKeyPath:@"result.order.shipping.data.price.data.formatted.with_tax"];
    self.lbShippingAriveBy.text = [self.reciept valueForKeyPath:@"result.order.shipping.value"];
    
    self.lbAddressLine1.text = [self.reciept valueForKeyPath:@"result.order.bill_to.data.address_1"];
    self.lbAddressLine2.text = [self.reciept valueForKeyPath:@"result.order.bill_to.data.address_2"];
    self.lbAddressCountry.text = [self.reciept valueForKeyPath:@"result.order.bill_to.data.country.data.name"];
    
    self.lbPaymentCard.text = [NSString stringWithFormat:@"%@ %@", [self.reciept valueForKeyPath:@"result.data.card.brand"], [self.reciept valueForKeyPath:@"result.data.card.last4"]];
    
    double shipping = [[self.reciept valueForKeyPath:@"result.order.shipping_price"] doubleValue];
    double total = [[self.reciept valueForKeyPath:@"result.order.total"] doubleValue];
    double subtotal = [[self.reciept valueForKeyPath:@"result.order.subtotal"] doubleValue];
    
    NSString *currencyFormat = [self.reciept valueForKeyPath:@"result.order.currency.data.format"];
    
    self.lbPaymentSubtotal.text = [currencyFormat stringByReplacingOccurrencesOfString:@"{price}" withString:[NSString stringWithFormat:@"%.2f", subtotal]];
    
    self.lbPaymentDelivery.text = [currencyFormat stringByReplacingOccurrencesOfString:@"{price}" withString:[NSString stringWithFormat:@"%.2f", shipping]];
    
    self.lbPaymentTotal.text = [currencyFormat stringByReplacingOccurrencesOfString:@"{price}" withString:[NSString stringWithFormat:@"%.2f", total]];
    
    [self.tableView reloadData];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)btnCloseTap:(id) sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - TableView delegate
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 120;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.products.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    ReceiptProductCell *cell = [tableView dequeueReusableCellWithIdentifier:ReceiptProductCellIdentifier];
    if (cell == nil) {
        
        cell = [[ReceiptProductCell alloc] init];
    }
    
    NSDictionary *product = [self.products objectAtIndex:indexPath.row];
    [cell configureWithProductDict:product];
    
    
    return cell;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
