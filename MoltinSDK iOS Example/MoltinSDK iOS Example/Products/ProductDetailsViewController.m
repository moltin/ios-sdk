//
//  ProductDetailsViewController.m
//  MoltinSDK iOS Example
//
//  Created by Gasper Rebernak on 15/06/15.
//  Copyright (c) 2015 Gasper Rebernak. All rights reserved.
//

#import "ProductDetailsViewController.h"
#import <MBProgressHUD.h>

@interface ProductDetailsViewController ()

@property (nonatomic) NSInteger quantity;
@property (strong, nonatomic) NSString *productId;
@property (strong, nonatomic) NSDictionary *productDict;
@property (strong, nonatomic) NSMutableArray *images;

@end

@implementation ProductDetailsViewController

- (id)initWithProductId:(NSString *) productId
{
    self = [super initWithNibName:@"ProductDetailsView" bundle:nil];
    if (self) {
        _productDict = nil;
        _productId = productId;
    }
    return self;
}

- (id)initWithProductDictionary:(NSDictionary *) productDict{
    self = [super initWithNibName:@"ProductDetailsView" bundle:nil];
    
    if (self) {
        _productDict = productDict;
        _productId = [productDict valueForKey:@"id"];
    }
    return self;
}

- (IBAction)btnBackTap:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    
    self.images = [NSMutableArray array];
    
    self.imageView.layer.borderColor = [UIColor redColor].CGColor;
    self.imageView.layer.borderWidth = 1;
    
    self.lbCollectionTitle.layer.borderColor = [UIColor redColor].CGColor;
    self.lbCollectionTitle.layer.borderWidth = 1;
    
    self.imagesScrollView.layer.borderColor = [UIColor greenColor].CGColor;
    self.imagesScrollView.layer.borderWidth = 1;
    
    [self configureWithProductDict:_productDict];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)configureWithProductDict:(NSDictionary *) product
{
    [self.images removeAllObjects];
    
    self.lbCollectionTitle.text = [[[[product objectForKey:@"collection"] objectForKey:@"data"] valueForKey:@"title"] uppercaseString];
    self.lbTitle.text = [product valueForKey:@"title"];
    self.lbPrice.text = [[[product objectForKey:@"pricing"] objectForKey:@"formatted"] valueForKey:@"with_tax"];;
    
    self.lbDescription.text = [product valueForKey:@"description"];
    
    NSArray *tmpImages = [product objectForKey:@"images"];
    
    
    for (NSDictionary *image in tmpImages) {
        NSString *imageUrl = [[image objectForKey:@"url"] objectForKey:@"http"];
        [self.images addObject:imageUrl];
    }
    if (self.images.count > 0) {
        [self.imageView sd_setImageWithURL:[NSURL URLWithString:[self.images objectAtIndex:0]]];
    }
    
    if (self.images.count > 1) {
        for (UIView *view in self.imagesScrollView.subviews) {
            if ([view isKindOfClass:[UIImageView class]] && view.tag == 99) {
                [view removeFromSuperview];
            }
        }
        
        self.imagesScrollViewHeightConstraint.constant = 75;
        int i = 0;
        for (NSString *imageUrl in self.images) {
            UIImageView *smallImage = [[UIImageView alloc] initWithFrame:CGRectMake(i*65, 0, self.imagesScrollViewHeightConstraint.constant, self.imagesScrollViewHeightConstraint.constant)];
            smallImage.userInteractionEnabled = YES;
            smallImage.tag = 99; // tag t know witch ImageViews to remove from "imagesScrollView"
            [smallImage sd_setImageWithURL:[NSURL URLWithString:imageUrl]];
            
            [self.imagesScrollView addSubview:smallImage];
            
            UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(smallImageViewTap:)];
            [smallImage addGestureRecognizer:tapGesture];
            
            i++;
        }
        self.imagesScrollView.contentSize = CGSizeMake(i*65, 65);
    }
    else{
        self.imagesScrollViewHeightConstraint.constant = 0;
    }
    
}

- (void)smallImageViewTap:(UITapGestureRecognizer *) sender{
    if ([sender.view isKindOfClass:[UIImageView class]]) {
        self.imageView.image = [(UIImageView*)sender.view image];
    }
}

#pragma mark - ADD TO CART
- (IBAction)btnAddToCartTap:(id)sender {
    
    self.quantity = 1;
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Select quantity" message:@"" delegate:nil cancelButtonTitle:@"Cancel" otherButtonTitles:@"Set", nil];
    UIPickerView *pickerView = [[UIPickerView alloc] init];
    pickerView.delegate = self;
    pickerView.dataSource = self;
    [pickerView reloadAllComponents];
    
    alertView.delegate = self;
    [alertView setValue:pickerView forKey:@"accessoryView"];
    [alertView show];
}

-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    NSString *stockLevel = [_productDict valueForKey:@"stock_level"];
    return [stockLevel integerValue];
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    return [NSString stringWithFormat:@"%ld", (long)row+1];
}

-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    self.quantity = row+1;
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex != alertView.cancelButtonIndex) {
        self.btnAddToCart.enabled = NO;
        [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        
        [[Moltin sharedInstance].cart insertItemWithId:self.productId quantity:self.quantity andModifiersOrNil:nil
                                               success:^(NSDictionary *response)
        {
            self.btnAddToCart.enabled = YES;
            dispatch_async(dispatch_get_main_queue(), ^{
                [MBProgressHUD hideHUDForView:self.view animated:YES];
            });
        } failure:^(NSError *error) {
            self.btnAddToCart.enabled = YES;
            NSLog(@"ERROR: %@", error);
            dispatch_async(dispatch_get_main_queue(), ^{
                [MBProgressHUD hideHUDForView:self.view animated:YES];
            });
        }];
    }
}

@end
