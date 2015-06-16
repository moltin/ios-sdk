//
//  ViewController.m
//  MoltinSDK iOS Example
//
//  Created by Gasper Rebernak on 08/06/15.
//  Copyright (c) 2015 Gasper Rebernak. All rights reserved.
//

#import "CollectionsViewController.h"
#import "Moltin.h"

static NSString *CellIdentifier = @"MoltinCollectionCell";

@interface CollectionsViewController ()

@property (strong, nonatomic) NSArray *categories;

@end

@implementation CollectionsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"Categories";
    
    UICollectionViewFlowLayout* layout = [[UICollectionViewFlowLayout alloc] init];
    layout.minimumInteritemSpacing = 0;
    layout.minimumLineSpacing = 0;
    layout.itemSize = CGSizeMake([UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    
    self.collectionView.collectionViewLayout = layout;
    
    [self.collectionView registerNib:[UINib nibWithNibName:@"CollectionViewCell" bundle:nil] forCellWithReuseIdentifier:CellIdentifier];
//    [self.collectionView registerClass:[CollectionViewCell class] forCellWithReuseIdentifier:CellIdentifier];
    
    [[Moltin sharedInstance] setPublicId:@"umRG34nxZVGIuCSPfYf8biBSvtABgTR8GMUtflyE"];
    
    __weak CollectionsViewController *weakSelf = self;
    [[Moltin sharedInstance].category listingWithParameters:@{@"status" : @1} success:^(NSDictionary *response) {
        NSLog(@"RESPONSE (category listing): %@", response);
        weakSelf.categories = [response objectForKey:@"result"];
        [weakSelf.collectionView reloadData];
    } failure:^(NSError *error) {
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
    
    
    return cell;
}

@end
