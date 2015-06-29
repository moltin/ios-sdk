//
//  CartViewController.m
//  MoltinSDK iOS Example
//
//  Created by Gasper Rebernak on 19/06/15.
//  Copyright (c) 2015 Gasper Rebernak. All rights reserved.
//

#import "CartViewController.h"
#import "AddressEntryViewController.h"
#import "CartListCell.h"

static NSString *CartCellIdentifier = @"MoltinCartCell";

@interface CartViewController ()

@property (strong, nonatomic) NSDictionary *cartData;
@property (strong, nonatomic) NSArray *cartItems;

@end

@implementation CartViewController

- (id)init{
    self = [super initWithNibName:@"CartView" bundle:nil];
    if (self) {
        
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loadCart) name:kMoltinNotificationRefreshCart object:nil];
    
    self.view.backgroundColor = MOLTIN_DARK_BACKGROUND_COLOR;
    [self.tableView registerNib:[UINib nibWithNibName:@"CartListCell" bundle:nil] forCellReuseIdentifier:CartCellIdentifier];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self loadCart];
}

- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:kMoltinNotificationRefreshCart object:nil];
}

- (void)loadCart{
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    __weak CartViewController *weakSelf = self;
    [[Moltin sharedInstance].cart getContentsWithsuccess:^(NSDictionary *response) {
        NSLog(@"CART CONTENT: %@", response);
        _cartData = response;
        [weakSelf parseCartItems];
        weakSelf.lbTotalPrice.text = [[[[[_cartData objectForKey:@"result"] objectForKey:@"totals"] objectForKey:@"post_discount"] objectForKey:@"formatted"] valueForKey:@"with_tax"];
        [MBProgressHUD hideHUDForView:self.view animated:YES];
    } failure:^(NSDictionary *response, NSError *error) {
        NSLog(@"CART ERROR: %@\nWITH RESPONSE: %@", error, response);
        [MBProgressHUD hideHUDForView:self.view animated:YES];
    }];
}

- (void)parseCartItems
{
    NSDictionary *tmpCartItems = [[self.cartData objectForKey:@"result"] objectForKey:@"contents"];
    if (tmpCartItems.count > 0) {
        self.cartItems = [tmpCartItems objectsForKeys:[tmpCartItems allKeys] notFoundMarker:[NSNull null]];
        self.lbNoProductsInCart.hidden = YES;
    }
    else{
        self.cartItems = nil;
        self.lbNoProductsInCart.hidden = NO;
    }
    
    self.btnCheckout.enabled = self.lbNoProductsInCart.hidden;
    [self.tableView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)btnCheckoutTap:(id)sender {
    
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"CheckoutStoryboard" bundle:nil];
    UIViewController *vc = [sb instantiateInitialViewController];
    vc.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    
    [[MTSlideNavigationController sharedInstance] presentViewController:vc animated:YES completion:nil];
}

#pragma mark - TableView
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.cartItems.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    CartListCell *cell = [tableView dequeueReusableCellWithIdentifier:CartCellIdentifier];
    if (cell == nil) {
        
        cell = [[CartListCell alloc] init];
    }
    
    NSDictionary *cartItem = [self.cartItems objectAtIndex:indexPath.row];
    [cell configureWithCartItemDict:cartItem];
    cell.delegate = self;
    
    return cell;
}

-(void)updateCartWithProductId:(NSString *)productId andQuantity:(NSNumber *)quantity
{
    __weak CartViewController *weakSelf = self;
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    //if (quantity.integerValue > 0) {
        [[Moltin sharedInstance].cart updateItemWithId:productId parameters:@{@"quantity" : quantity}
                                               success:^(NSDictionary *response){
                                                   [MBProgressHUD hideHUDForView:weakSelf.view animated:YES];
                                                   NSLog(@"CHART UPDATE OK: %@", response);
                                                   [weakSelf loadCart];
                                               }
                                               failure:^(NSDictionary *response, NSError *error) {
                                                   [MBProgressHUD hideHUDForView:weakSelf.view animated:YES];
                                                   NSLog(@"ERROR: %@", error);
                                                   [weakSelf loadCart];
                                               }];
    /*}
    else{
        [[Moltin sharedInstance].cart removeItemWithId:productId success:^(NSDictionary *response) {
            [MBProgressHUD hideHUDForView:weakSelf.view animated:YES];
            NSLog(@"CHART UPDATE OK: %@", response);
            [weakSelf loadCart];
        } failure:^(NSError *error) {
            [MBProgressHUD hideHUDForView:weakSelf.view animated:YES];
            NSLog(@"ERROR: %@", error);
            ALERT(@"ERROR", @"There was a problem while updating chart");
            [weakSelf loadCart];
        }];
    }*/
    
}

@end
