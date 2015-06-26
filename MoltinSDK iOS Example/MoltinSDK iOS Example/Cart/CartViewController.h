//
//  CartViewController.h
//  MoltinSDK iOS Example
//
//  Created by Gasper Rebernak on 19/06/15.
//  Copyright (c) 2015 Gasper Rebernak. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CartListCell.h"

@interface CartViewController : UIViewController<UITableViewDelegate, UITableViewDataSource, CartListCellDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UILabel *lbTotalPrice;

- (IBAction)btnCheckoutTap:(id)sender;
@end
