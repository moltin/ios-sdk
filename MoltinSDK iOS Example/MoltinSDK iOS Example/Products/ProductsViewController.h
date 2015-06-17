//
//  ProductsViewController.h
//  MoltinSDK iOS Example
//
//  Created by Gasper Rebernak on 15/06/15.
//  Copyright (c) 2015 Gasper Rebernak. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ProductsViewController : UIViewController<UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, SlideNavigationControllerDelegate>

@property (strong, nonatomic) NSString *collectionId;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (weak, nonatomic) IBOutlet UILabel *lbNoProducts;
@property (weak, nonatomic) IBOutlet UIPageControl *pageControl;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;

@end
