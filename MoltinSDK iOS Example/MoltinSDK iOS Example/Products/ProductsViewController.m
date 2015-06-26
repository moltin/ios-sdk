//
//  ProductsViewController.m
//  MoltinSDK iOS Example
//
//  Created by Gasper Rebernak on 15/06/15.
//  Copyright (c) 2015 Gasper Rebernak. All rights reserved.
//

#import "ProductsViewController.h"
#import "ProductListCell.h"

static NSString *ProductCellIdentifier = @"MoltinProductCell";

@interface ProductsViewController ()

@property (strong, nonatomic) NSArray *products;

@end

@implementation ProductsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = MOLTIN_DARK_BACKGROUND_COLOR;
    self.collectionView.backgroundColor = MOLTIN_DARK_BACKGROUND_COLOR;
    
    UICollectionViewFlowLayout* layout = [[UICollectionViewFlowLayout alloc] init];
    layout.minimumInteritemSpacing = 30;
    layout.minimumLineSpacing = 30;
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    layout.sectionInset = UIEdgeInsetsMake(0, 30, 0, 30);
    
    self.collectionView.collectionViewLayout = layout;
    [self.collectionView reloadData];
    
    self.title = @"PRODUCTS";
    
    [self.pageControl addTarget:self
                         action:@selector(pageControlChanged:)
               forControlEvents:UIControlEventValueChanged
     ];
    
    [self.collectionView registerNib:[UINib nibWithNibName:@"ProductListCell" bundle:nil] forCellWithReuseIdentifier:ProductCellIdentifier];
    
    self.lbNoProducts.hidden = YES;
//    self.lbNoProducts.font = [UIFont fontWithName:kMoltinFontBold size:25];
    self.lbNoProducts.shadowColor = RGB(0, 0, 0);
    self.lbNoProducts.shadowOffset = CGSizeMake(1, 1);
    self.lbNoProducts.textColor = RGB(234, 234, 234);

}

- (void)setCollectionId:(NSString *) collectionId{
    _collectionId = collectionId;
    if (!self.view){
        [self loadView];
    }
    [self.activityIndicator startAnimating];
    __weak ProductsViewController *weakSelf = self;
    
    [[Moltin sharedInstance].product listingWithParameters:@{@"collection" : _collectionId} success:^(NSDictionary *response) {
        [weakSelf.activityIndicator stopAnimating];
        weakSelf.products = [response objectForKey:@"result"];
        if (weakSelf.products.count == 0) {
            weakSelf.lbNoProducts.hidden = NO;
        }
        weakSelf.pageControl.numberOfPages = weakSelf.products.count;
        [weakSelf.collectionView reloadData];
    } failure:^(NSError *error) {
        [weakSelf.activityIndicator stopAnimating];
        NSLog(@"Category listing ERROR!!! %@", error);
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - CollectionView delegate
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.products.count;
}


-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    ProductListCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:ProductCellIdentifier forIndexPath:indexPath];
    if (cell == nil) {
        
        cell = [[ProductListCell alloc] init];
    }
    
    NSDictionary *product = [self.products objectAtIndex:indexPath.row];
    [cell configureWithProductDict:product];
    
    
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView
                  layout:(UICollectionViewLayout *)collectionViewLayout
  sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake([UIScreen mainScreen].bounds.size.width-60, self.collectionView.frame.size.height);
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    CGFloat pageWidth = self.collectionView.frame.size.width-30;
    self.pageControl.currentPage = self.collectionView.contentOffset.x / pageWidth;
}

- (void)pageControlChanged:(id)sender
{
    UIPageControl *pageControl = sender;
    CGFloat pageWidth = self.collectionView.frame.size.width;
    CGPoint scrollTo = CGPointMake(pageWidth * pageControl.currentPage, 0);
    [self.collectionView setContentOffset:scrollTo animated:YES];
}

#pragma mark SlideNavigationController

- (BOOL)slideNavigationControllerShouldDisplayRightMenu
{
    return YES;
}

@end
