//
//  ViewController.m
//  MoltinSDK iOS Example
//
//  Created by Gasper Rebernak on 08/06/15.
//  Copyright (c) 2015 Gasper Rebernak. All rights reserved.
//

#import "CollectionsViewController.h"
#import "ProductsViewController.h"

static NSString *CellIdentifier = @"MoltinCollectionCell";

@interface CollectionsViewController ()

@property (strong, nonatomic) NSArray *categories;

@end

@implementation CollectionsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = MOLTIN_DARK_BACKGROUND_COLOR;
    self.collectionView.backgroundColor = MOLTIN_DARK_BACKGROUND_COLOR;
    
    self.title = @"COLLECTIONS";
    
    [self.pageControl addTarget:self
                         action:@selector(pageControlChanged:)
               forControlEvents:UIControlEventValueChanged
     ];
    
    UICollectionViewFlowLayout* layout = [[UICollectionViewFlowLayout alloc] init];
    layout.minimumInteritemSpacing = 0;
    layout.minimumLineSpacing = 0;
    layout.itemSize = CGSizeMake([UIScreen mainScreen].bounds.size.width, self.collectionView.frame.size.height);
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    
    self.collectionView.collectionViewLayout = layout;
    
    [self.collectionView registerNib:[UINib nibWithNibName:@"CollectionListCell" bundle:nil] forCellWithReuseIdentifier:CellIdentifier];
//    [self.collectionView registerClass:[CollectionViewCell class] forCellWithReuseIdentifier:CellIdentifier];
    
    [[Moltin sharedInstance] setPublicId:@"umRG34nxZVGIuCSPfYf8biBSvtABgTR8GMUtflyE"];
    
    [self.activityIndicator startAnimating];
    __weak CollectionsViewController *weakSelf = self;
    [[Moltin sharedInstance].collection listingWithParameters:@{@"status" : @1} success:^(NSDictionary *response) {
        [weakSelf.activityIndicator stopAnimating];
        NSLog(@"RESPONSE (collection listing): %@", response);
        weakSelf.categories = [response objectForKey:@"result"];
        weakSelf.pageControl.numberOfPages = weakSelf.categories.count;
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
    return self.categories.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CollectionListCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:CellIdentifier forIndexPath:indexPath];
    if (cell == nil) {
        cell = [[CollectionListCell alloc] init];
    }
    
    NSDictionary *category = [self.categories objectAtIndex:indexPath.row];
    [cell configureWithCollectionDict:category];
    cell.delegate = self;
    
    return cell;
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    CGFloat pageWidth = self.collectionView.frame.size.width;
    self.pageControl.currentPage = self.collectionView.contentOffset.x / pageWidth;
}

- (void)didSelectCollectionWithId:(NSString *)collectionId
{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    ProductsViewController *productsViewController = [storyboard instantiateViewControllerWithIdentifier:@"productsList"];
    productsViewController.collectionId = collectionId;
    
    [[MTNavigationController sharedInstance] pushViewController:productsViewController animated:YES];
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
