//
//  ProductsListViewController.m
//  MoltinSDK iOS Example
//
//  Created by Moltin on 07/07/15.
//  Copyright (c) 2015 Moltin. All rights reserved.
//

#import "ProductsListViewController.h"
#import "ProductDetailsViewController.h"
#import "ProductListTableCell.h"
#import "ProductListLoadMoreTableViewCell.h"

static NSString *ProductCellIdentifier = @"MoltinProductCell";
static NSString *LoadMoreCellIdentifier = @"MoltinLoadMoreCell";

@interface ProductsListViewController (){
    BOOL isPageRefresing;
}

@property (strong, nonatomic) NSMutableArray *products;
@property (strong, nonatomic) NSNumber *paginationOffset;
@property (nonatomic) BOOL showLoadMore;
@end

@implementation ProductsListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = MOLTIN_DARK_BACKGROUND_COLOR;
    self.tableView.backgroundColor = [UIColor whiteColor];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"ProductListTableCell" bundle:nil] forCellReuseIdentifier:ProductCellIdentifier];
    
    self.showLoadMore =  YES;
    
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
    self.paginationOffset = [NSNumber numberWithInteger:0];
    if (!self.view){
        [self loadView];
    }
    
    self.products = [NSMutableArray array];
    
    [self loadProducts];
}

- (void)loadProducts{
    
    if (!isPageRefresing) {
        isPageRefresing = YES;
        
        if (self.paginationOffset.integerValue == 0) {
            [self.activityIndicator startAnimating];
        }
        else{
            [self.activityIndicatorTableFooter startAnimating];
        }
        
        
        __weak ProductsListViewController *weakSelf = self;
        
        [[Moltin sharedInstance].product listingWithParameters:@{@"collection" : _collectionId,
                                                                 @"limit" : @10,
                                                                 @"offset" : self.paginationOffset
                                                                 }
                                                       success:^(NSDictionary *response)
         {
             [weakSelf.activityIndicator stopAnimating];
             [weakSelf.activityIndicatorTableFooter stopAnimating];
             [weakSelf.products addObjectsFromArray:[response objectForKey:@"result"]];
             
             weakSelf.paginationOffset = [response valueForKeyPath:@"pagination.offsets.next"];
             
             NSNumber *totalProductsInCollection = [response valueForKeyPath:@"pagination.total"];
             
             if (totalProductsInCollection.integerValue == weakSelf.products.count) {
                 // don't show option to 'Load More' - we have all products...
                 weakSelf.showLoadMore = NO;
             }
             
             if (weakSelf.products.count == 0) {
                 weakSelf.lbNoProducts.hidden = NO;
                 weakSelf.showLoadMore = NO;
             }
             [weakSelf.tableView reloadData];
             isPageRefresing = NO;
             
             
         } failure:^(NSDictionary *response, NSError *error) {
             [weakSelf.activityIndicator stopAnimating];
             [weakSelf.activityIndicatorTableFooter stopAnimating];
             NSLog(@"ERROR PRODUCT listing: %@", error);
             isPageRefresing = NO;
         }];
    }
}

#pragma mark - TableView delegate
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 30;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 120;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.products.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (self.showLoadMore && indexPath.row == self.products.count) {
        // it's the 'load more' cell...
        ProductListLoadMoreTableViewCell *loadMoreCell = [tableView dequeueReusableCellWithIdentifier:LoadMoreCellIdentifier];
        
        if (loadMoreCell == nil) {
            
            loadMoreCell = [[ProductListLoadMoreTableViewCell alloc] init];
        }
        
        return loadMoreCell;
        
    }
    
    ProductListTableCell *cell = [tableView dequeueReusableCellWithIdentifier:ProductCellIdentifier];
    if (cell == nil) {
        
        cell = [[ProductListTableCell alloc] init];
    }
    
    NSDictionary *product = [self.products objectAtIndex:indexPath.row];
    [cell configureWithProductDict:product];
    
    
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView *headerView = [[UIView alloc] init];
    
    [headerView setBackgroundColor:[UIColor clearColor]];
    
    self.activityIndicatorTableFooter = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    self.activityIndicatorTableFooter.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleBottomMargin;
    self.activityIndicatorTableFooter.translatesAutoresizingMaskIntoConstraints = YES;
    
    self.activityIndicatorTableFooter.hidesWhenStopped = YES;
    [headerView addSubview:self.activityIndicatorTableFooter];
    
    return headerView;
    
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
