//
//  ViewController.h
//  MoltinSDK iOS Example
//
//  Created by Gasper Rebernak on 08/06/15.
//  Copyright (c) 2015 Gasper Rebernak. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <SlideNavigationController.h>
#import "CollectionListCell.h"

@interface CollectionsViewController : UIViewController<SlideNavigationControllerDelegate, UICollectionViewDelegate, UICollectionViewDataSource, CollectionListCellDelegate>

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (weak, nonatomic) IBOutlet UIPageControl *pageControl;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;

@end

