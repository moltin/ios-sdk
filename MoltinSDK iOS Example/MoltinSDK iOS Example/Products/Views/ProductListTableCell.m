//
//  ProductListTableCell.m
//  MoltinSDK iOS Example
//
//  Created by Moltin on 07/07/15.
//  Copyright (c) 2015 Moltin. All rights reserved.
//

#import "ProductListTableCell.h"
#import "ProductDetailsViewController.h"
#import "MTSlideNavigationController.h"

@interface ProductListTableCell()

@property (strong, nonatomic) NSDictionary *productDict;

@end

@implementation ProductListTableCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)prepareForReuse{
    _productDict = nil;
    self.productImageView.image = nil;
}

- (void)configureWithProductDict:(NSDictionary *) product
{
    _productDict = product;
    
    self.lbCollectionTitle.text = [[product valueForKeyPath:@"collection.data.title"] uppercaseString];
    self.lbTitle.text = [product valueForKey:@"title"];
    self.lbPrice.text = [product valueForKeyPath:@"price.data.formatted.with_tax"];
    
    NSArray *tmpImages = [product objectForKey:@"images"];
    
    
    for (NSDictionary *image in tmpImages) {
        NSString *imageUrl = [image valueForKeyPath:@"url.https"];
        [self.productImageView sd_setImageWithURL:[NSURL URLWithString:imageUrl]];
        break;
    }
}

- (IBAction)btnMoreInfoTap:(id)sender {
    ProductDetailsViewController *detailsViewController = [[ProductDetailsViewController alloc] initWithProductDictionary:_productDict];
    [[MTSlideNavigationController sharedInstance] pushViewController:detailsViewController animated:YES];
}

@end
