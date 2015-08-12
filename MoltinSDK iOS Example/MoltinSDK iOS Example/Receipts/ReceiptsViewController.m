//
//  ReceiptsViewController.m
//  MoltinSDK iOS Example
//
//  Created by Dylan McKee on 10/08/2015.
//  Copyright (c) 2015 Moltin. All rights reserved.
//

#import "ReceiptsViewController.h"
#import "ReceiptViewController.h"

static NSString *ReceiptCellIdentifier = @"MoltinSavedReceiptCell";

@interface ReceiptsViewController ()

@end

@implementation ReceiptsViewController


+ (ReceiptsViewController *)sharedInstance {
    static ReceiptsViewController *_sharedClient = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedClient = [[ReceiptsViewController alloc] init];
    });
    
    return _sharedClient;
}

- (id)init{
    self = [super initWithNibName:@"ReceiptsViewController" bundle:nil];
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

- (void)reload {
    self.savedOrders = [ReceiptManager savedReceipts];
    [self.tableView reloadData];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.view.backgroundColor = MOLTIN_DARK_BACKGROUND_COLOR;
    [self.tableView registerNib:[UINib nibWithNibName:@"SavedReceiptTableViewCell" bundle:nil] forCellReuseIdentifier:ReceiptCellIdentifier];
        
}


- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self reload];
    
    [self setNeedsStatusBarAppearanceUpdate];
    
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - TableView
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.savedOrders.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    SavedReceiptTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ReceiptCellIdentifier];
    if (cell == nil) {
        
        cell = [[SavedReceiptTableViewCell alloc] init];
    }
    
    Receipt *receipt = [self.savedOrders objectAtIndex:indexPath.row];
    [cell setPurchaseDate:receipt.creationDate];
    [cell setPurchaseAmount:receipt.products.count];
    
    return cell;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    // load relevant receipt from savedOrders array...
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    Receipt *selectedReceipt = [self.savedOrders objectAtIndex:indexPath.row];
    
    
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"CheckoutStoryboard" bundle:nil];
    ReceiptViewController *vc = [sb instantiateViewControllerWithIdentifier:@"receiptVC"];
    vc.products = selectedReceipt.products;
    vc.reciept = selectedReceipt.receiptData;
    vc.purchaseDate = selectedReceipt.creationDate;

    vc.isIndividualModalView = YES;
    [[MTSlideNavigationController sharedInstance] pushViewController:vc animated:YES];
    
    
    
}




@end
