//
//  ProductListTableCell.h
//  MoltinSDK iOS Example
//
//  Created by Moltin on 07/07/15.
//  Copyright (c) 2015 Moltin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ProductListTableCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *productImageView;
@property (weak, nonatomic) IBOutlet UILabel *lbCollectionTitle;
@property (weak, nonatomic) IBOutlet UILabel *lbTitle;
@property (weak, nonatomic) IBOutlet UILabel *lbPrice;

- (void)configureWithProductDict:(NSDictionary *) product;
- (IBAction)btnMoreInfoTap:(id)sender;

@end
