//
//  ProductsListViewController.m
//  MoltinSDK iOS Example
//
//  Created by Gasper Rebernak on 07/07/15.
//  Copyright (c) 2015 Gasper Rebernak. All rights reserved.
//

#import "ProductsListViewController.h"
#import "ProductDetailsViewController.h"
#import "ProductListTableCell.h"

static NSString *ProductCellIdentifier = @"MoltinProductCell";

@interface ProductsListViewController ()

@property (strong, nonatomic) NSArray *products;

@end

@implementation ProductsListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = MOLTIN_DARK_BACKGROUND_COLOR;
    self.tableView.backgroundColor = [UIColor whiteColor];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"ProductListTableCell" bundle:nil] forCellReuseIdentifier:ProductCellIdentifier];
    
    self.lbNoProducts.hidden = YES;
    self.lbNoProducts.shadowColor = RGB(234, 234, 234);
    self.lbNoProducts.shadowOffset = CGSizeMake(1, 1);
    self.lbNoProducts.textColor = RGB(0, 0, 0);
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

- (void)setCollectionId:(NSString *) collectionId{
    _collectionId = collectionId;
    if (!self.view){
        [self loadView];
    }
    [self.activityIndicator startAnimating];
    __weak ProductsListViewController *weakSelf = self;
    
    [[Moltin sharedInstance].product listingWithParameters:@{@"collection" : _collectionId} success:^(NSDictionary *response) {
        [weakSelf.activityIndicator stopAnimating];
        weakSelf.products = [response objectForKey:@"result"];
        if (weakSelf.products.count == 0) {
            weakSelf.lbNoProducts.hidden = NO;
        }
        [weakSelf.tableView reloadData];
    } failure:^(NSDictionary *response, NSError *error) {
        [weakSelf.activityIndicator stopAnimating];
        NSLog(@"Category listing ERROR!!! %@", error);
    }];
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
    
    ProductListTableCell *cell = [tableView dequeueReusableCellWithIdentifier:ProductCellIdentifier];
    if (cell == nil) {
        
        cell = [[ProductListTableCell alloc] init];
    }
    
    NSDictionary *product = [self.products objectAtIndex:indexPath.row];
    [cell configureWithProductDict:product];
    
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *product = [self.products objectAtIndex:indexPath.row];
    
    ProductDetailsViewController *detailsViewController = [[ProductDetailsViewController alloc] initWithProductDictionary:product];
    [[MTSlideNavigationController sharedInstance] pushViewController:detailsViewController animated:YES];
    
}

#pragma mark SlideNavigationController

- (BOOL)slideNavigationControllerShouldDisplayRightMenu
{
    return YES;
}



@end
