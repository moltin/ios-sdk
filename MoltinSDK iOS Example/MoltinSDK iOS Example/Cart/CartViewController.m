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

@end

@implementation CartViewController

+ (CartViewController *)sharedInstance {
    static CartViewController *_sharedClient = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedClient = [[CartViewController alloc] init];
    });
    
    return _sharedClient;
}

- (id)init{
    self = [super initWithNibName:@"CartView" bundle:nil];
    if (self) {
        
    }
    return self;
}


- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self)
    {
        
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
        _cartData = response;
        [weakSelf parseCartItems];
        weakSelf.lbTotalPrice.text = [_cartData valueForKeyPath:@"result.totals.post_discount.formatted.with_tax"];
        [MBProgressHUD hideHUDForView:self.view animated:YES];
    } failure:^(NSDictionary *response, NSError *error) {
        NSLog(@"CART ERROR: %@\nWITH RESPONSE: %@", error, response);
        [MBProgressHUD hideHUDForView:self.view animated:YES];
    }];
}

- (void)parseCartItems
{
    NSDictionary *tmpCartItems = [self.cartData valueForKeyPath:@"result.contents"];
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
    
    [[Moltin sharedInstance].cart updateItemWithId:productId parameters:@{@"quantity" : quantity}
                                           success:^(NSDictionary *response){
                                               [MBProgressHUD hideHUDForView:weakSelf.view animated:YES];
                                               [weakSelf loadCart];
                                           }
                                           failure:^(NSDictionary *response, NSError *error) {
                                               [MBProgressHUD hideHUDForView:weakSelf.view animated:YES];
                                               NSLog(@"ERROR CART UPDATE: %@", error);
                                               [weakSelf loadCart];
                                           }];
}

@end
