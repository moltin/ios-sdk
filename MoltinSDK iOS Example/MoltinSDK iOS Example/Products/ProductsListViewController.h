//
//  ProductsListViewController.h
//  MoltinSDK iOS Example
//
//  Created by Moltin on 07/07/15.
//  Copyright (c) 2015 Moltin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ProductsListViewController : UIViewController<UITableViewDelegate, UITableViewDataSource, SlideNavigationControllerDelegate>

@property (strong, nonatomic) NSString *collectionId;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UILabel *lbNoProducts;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;
@property (strong, nonatomic) UIActivityIndicatorView *activityIndicatorTableFooter;

@end
