//
//  ReceiptsViewController.h
//  MoltinSDK iOS Example
//
//  Created by Dylan McKee on 10/08/2015.
//  Copyright (c) 2015 Moltin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SavedReceiptTableViewCell.h"
#import "Receipt.h"
#import "ReceiptManager.h"

@interface ReceiptsViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>


@property (strong, nonatomic) NSArray *savedOrders;

@property (weak, nonatomic) IBOutlet UITableView *tableView;

+ (ReceiptsViewController *)sharedInstance;


@end
