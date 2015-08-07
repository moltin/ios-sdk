//
//  ProductDetailsViewController.m
//  MoltinSDK iOS Example
//
//  Created by Moltin on 15/06/15.
//  Copyright (c) 2015 Moltin. All rights reserved.
//

#import "ProductDetailsViewController.h"

@interface ModifierModel : NSObject

@property (nonatomic) NSInteger modifierId;
@property (strong, nonatomic) NSString *title;
@property (strong, nonatomic) NSMutableArray *variations;

@end

@implementation ModifierModel

- (instancetype)initWithDictionary:(NSDictionary *) modifierDict{
    self = [super init];
    if (self) {
        NSNumber *modifierId = [modifierDict valueForKey:@"id"];
        self.modifierId = modifierId.integerValue;
        self.title = [modifierDict valueForKey:@"title"];
        
        NSDictionary *tmpVariations = [modifierDict objectForKey:@"variations"];
        if (tmpVariations.count > 0) {
            self.variations = [NSMutableArray arrayWithCapacity:tmpVariations.count];
        }
        for (NSString *key in tmpVariations) {
            NSDictionary *variation = [tmpVariations valueForKey:key];
            [self.variations addObject:variation];
        }
    }
    return self;
}

@end

@interface ProductDetailsViewController ()


@property (nonatomic) NSInteger quantity;
@property (strong, nonatomic) NSString *productId;
@property (strong, nonatomic) NSDictionary *productDict;
@property (strong, nonatomic) NSMutableArray *modifiers;
@property (strong, nonatomic) NSMutableArray *images;
@property (strong, nonatomic) NSMutableDictionary *selectedModifiers;

@property (strong, nonatomic) UIActionSheet *actionSheet;

@end

@implementation ProductDetailsViewController

static NSInteger ScrollingImageViewTag = 99;
static NSInteger ScrollingImageViewHeight = 65;

- (id)initWithProductDictionary:(NSDictionary *) productDict{
    self = [super initWithNibName:@"ProductDetailsView" bundle:nil];
    
    if (self) {
        self.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
        _productDict = productDict;
        _productId = [productDict valueForKey:@"id"];
        
        NSDictionary *modifiersData = [self.productDict valueForKey:@"modifiers"];
        self.modifiers = [NSMutableArray array];
        for (NSString *key in modifiersData) {
            ModifierModel *modifier = [[ModifierModel alloc] initWithDictionary:[modifiersData objectForKey:key]];
            [self.modifiers addObject:modifier];
            NSLog(@"SINGLE MODIFIER: %@", modifier.title);
        }
    }
    return self;
}

- (IBAction)btnBackTap:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)btnCartTap:(id)sender {
    [[MTSlideNavigationController sharedInstance] toggleRightMenu];
}

- (void)viewDidLoad {
    [super viewDidLoad];

    self.title = @"PRODUCT";
    
    self.images = [NSMutableArray array];
    
    [self configureWithProductDict:_productDict];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    UINavigationBar *navBar = self.navigationController.navigationBar;
    navBar.tintColor = MOLTIN_DARK_BACKGROUND_COLOR;
    navBar.barTintColor = [UIColor whiteColor];
    navBar.barStyle = UIBarStyleBlack;
    navBar.translucent = NO;
    navBar.titleTextAttributes = @{
                                   NSForegroundColorAttributeName: navBar.tintColor,
                                   NSFontAttributeName:[UIFont fontWithName:kMoltinFontBold size:20]
                                   };
    
    [[UINavigationBar appearance] setBackgroundImage:[[UIImage alloc] init]
                                      forBarPosition:UIBarPositionAny
                                          barMetrics:UIBarMetricsDefault];
    
    [[UINavigationBar appearance] setShadowImage:[[UIImage alloc] init]];

    [[NSNotificationCenter defaultCenter] postNotificationName:kMoltinNotificationDarkCartButton object:nil];

    
    [self setNeedsStatusBarAppearanceUpdate];
    
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleDefault;
}



- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    UINavigationBar *navBar = self.navigationController.navigationBar;
    navBar.tintColor = [UIColor whiteColor];
    navBar.barTintColor = MOLTIN_DARK_BACKGROUND_COLOR;
    navBar.barStyle = UIBarStyleBlack;
    navBar.translucent = NO;
    navBar.titleTextAttributes = @{
                                   NSForegroundColorAttributeName: navBar.tintColor,
                                   NSFontAttributeName:[UIFont fontWithName:kMoltinFontBold size:20]
                                   };
    
    [[UINavigationBar appearance] setBackgroundImage:[[UIImage alloc] init]
                                      forBarPosition:UIBarPositionAny
                                          barMetrics:UIBarMetricsDefault];
    
    [[UINavigationBar appearance] setShadowImage:[[UIImage alloc] init]];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:kMoltinNotificationLightCartButton object:nil];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)configureWithProductDict:(NSDictionary *) product
{
    [self.images removeAllObjects];
    
    self.lbCollectionTitle.text = [[product valueForKeyPath:@"collection.data.title"] uppercaseString];
    self.lbTitle.text = [product valueForKey:@"title"];
    self.lbPrice.text = [product valueForKeyPath:@"price.data.formatted.with_tax"];
    
    self.lbDescription.text = [product valueForKey:@"description"];
    
    NSArray *tmpImages = [product objectForKey:@"images"];
    
    
    for (NSDictionary *image in tmpImages) {
        NSString *imageUrl = [image valueForKeyPath:@"url.https"];
        [self.images addObject:imageUrl];
    }
    if (self.images.count > 0) {
        [self.activityIndicatorImageView startAnimating];
        [self.imageView sd_setImageWithURL:[NSURL URLWithString:[self.images objectAtIndex:0]]
                                 completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL)
        {
            if (!error) {
                self.imageView.backgroundColor = [UIColor clearColor];
            }
            
            [self.activityIndicatorImageView stopAnimating];
        }];
    }
    
    if (self.images.count > 1) {
        for (UIView *view in self.imagesScrollView.subviews) {
            if ([view isKindOfClass:[UIImageView class]] && view.tag == ScrollingImageViewTag) {
                [view removeFromSuperview];
            }
        }
        
        self.imagesScrollViewHeightConstraint.constant = 75;
        int i = 0;
        for (NSString *imageUrl in self.images) {
            UIImageView *smallImage = [[UIImageView alloc] initWithFrame:CGRectMake((i * ScrollingImageViewHeight), 0, self.imagesScrollViewHeightConstraint.constant, self.imagesScrollViewHeightConstraint.constant)];
            smallImage.userInteractionEnabled = YES;
            smallImage.tag = ScrollingImageViewTag; // tag t know witch ImageViews to remove from "imagesScrollView"
            [smallImage sd_setImageWithURL:[NSURL URLWithString:imageUrl]];
            
            [self.imagesScrollView addSubview:smallImage];
            
            UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(smallImageViewTap:)];
            [smallImage addGestureRecognizer:tapGesture];
            
            i++;
        }
        self.imagesScrollView.contentSize = CGSizeMake((i* ScrollingImageViewHeight), ScrollingImageViewHeight);
    }
    else{
        self.imagesScrollViewHeightConstraint.constant = 0;
    }
    
    [self layoutModifiers];
}

#pragma mark - Modifiers

- (void)layoutModifiers{
    if (self.modifiers.count > 0)
    {
        self.selectedModifiers = [NSMutableDictionary dictionary];
        
        double xOffset = 0;
        for (ModifierModel *modifier in self.modifiers) {
            UILabel *lbModifierTitle = [[UILabel alloc] initWithFrame:CGRectMake(0, xOffset, self.modifiersView.frame.size.width, 20)];
            lbModifierTitle.font = [UIFont fontWithName:kMoltinFontBold size:15];
            lbModifierTitle.text = modifier.title;
            [self.modifiersView addSubview:lbModifierTitle];
            xOffset = lbModifierTitle.frame.origin.y + lbModifierTitle.frame.size.height;
            
            NSDictionary *variant = [modifier.variations firstObject];
            
            if (variant){
                [self.selectedModifiers setValue:[variant valueForKey:@"id"]  forKey:[variant valueForKey:@"modifier"]];
            }
            UIButton *btnSelectModifier = [[UIButton alloc] initWithFrame:CGRectMake(10, xOffset, lbModifierTitle.frame.size.width - 10, 30)];
            btnSelectModifier.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
            btnSelectModifier.titleLabel.font = [UIFont fontWithName:kMoltinFontBold size:11];
            btnSelectModifier.tag = modifier.modifierId;
            [btnSelectModifier addTarget:self action:@selector(btnSelectModifierTap:) forControlEvents:UIControlEventTouchUpInside];
            
            NSString *btnTitle = [NSString stringWithFormat:@"%@ (%@)", [variant valueForKey:@"title"], [variant valueForKey:@"difference"]];
            [btnSelectModifier setTitle:btnTitle forState:UIControlStateNormal];
            [btnSelectModifier setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            [self.modifiersView addSubview:btnSelectModifier];
            xOffset = btnSelectModifier.frame.origin.y + btnSelectModifier.frame.size.height;
        }
        self.modifiersViewHeight.constant = xOffset;
    }
    else{
        self.modifiersViewHeight.constant = 0;
    }
}

- (void)smallImageViewTap:(UITapGestureRecognizer *) sender{
    if ([sender.view isKindOfClass:[UIImageView class]]) {
        self.imageView.image = [(UIImageView*)sender.view image];
    }
}

- (void)btnSelectModifierTap:(UIButton *)sender {

    NSArray *selectedModifier = [self.modifiers filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"modifierId=%@", [NSNumber numberWithInteger:sender.tag]]];
    
    ModifierModel *modifier = [selectedModifier firstObject];
    
    self.actionSheet = [[UIActionSheet alloc] initWithTitle:modifier.title delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:nil];
    self.actionSheet.tag = sender.tag;
    self.actionSheet.delegate = self;
    
    for (NSDictionary *variant in modifier.variations){
        NSString *variantTitle = [NSString stringWithFormat:@"%@ (%@)", [variant valueForKey:@"title"], [variant valueForKey:@"difference"]];
        [self.actionSheet addButtonWithTitle:variantTitle];
    }
    
    [self.actionSheet showInView:self.view];
}

-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex != actionSheet.cancelButtonIndex) {
        
        NSArray *selectedModifier = [self.modifiers filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"modifierId=%@", [NSNumber numberWithInteger:actionSheet.tag]]];
        
        ModifierModel *modifier = [selectedModifier firstObject];
        if (modifier) {
            NSDictionary *variant = [modifier.variations objectAtIndex:buttonIndex-1];
            [self.selectedModifiers setValue:[variant valueForKey:@"id"]  forKey:[variant valueForKey:@"modifier"]];
            
            NSString *variantTitle = [NSString stringWithFormat:@"%@ (%@)", [variant valueForKey:@"title"], [variant valueForKey:@"difference"]];
            
            for (UIButton *button in self.modifiersView.subviews) {
                if ([button isKindOfClass:[UIButton class]] && button.tag == actionSheet.tag) {
                    [button setTitle:variantTitle forState:UIControlStateNormal];
                    break;
                }
            }
        }
    }
}

#pragma mark - ADD TO CART
- (IBAction)btnAddToCartTap:(id)sender {
    
    self.quantity = 1;
    
    self.btnAddToCart.enabled = NO;
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.labelText = @"Updating Cart";
    
    [[Moltin sharedInstance].cart insertItemWithId:self.productId quantity:self.quantity andModifiersOrNil:self.selectedModifiers
                                           success:^(NSDictionary *response)
     {
         dispatch_async(dispatch_get_main_queue(), ^{
             [[NSNotificationCenter defaultCenter] postNotificationName:kMoltinNotificationRefreshCart object:nil];
             dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                 self.btnAddToCart.enabled = YES;
                 [MBProgressHUD hideHUDForView:self.view animated:YES];
                 [[MTSlideNavigationController sharedInstance] toggleRightMenu];
             });
         });
     } failure:^(NSDictionary *response, NSError *error) {
         self.btnAddToCart.enabled = YES;
         NSLog(@"ERROR: %@", error);
         
         NSString *errorText = @"Failed to add product to cart.";
         if ([response objectForKey:@"errors"]) {
             if ([[response objectForKey:@"errors"] isKindOfClass:[NSArray class]]) {
                 errorText = [[response objectForKey:@"errors"] firstObject];
             }
         }
         
         ALERT(@"Sorry, something went wrong", errorText);
         dispatch_async(dispatch_get_main_queue(), ^{
             [MBProgressHUD hideHUDForView:self.view animated:YES];
         });
     }];
    
    /*UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Select quantity" message:@"" delegate:nil cancelButtonTitle:@"Cancel" otherButtonTitles:@"Set", nil];
    UIPickerView *pickerView = [[UIPickerView alloc] init];
    pickerView.delegate = self;
    pickerView.dataSource = self;
    [pickerView reloadAllComponents];
    
    alertView.delegate = self;
    [alertView setValue:pickerView forKey:@"accessoryView"];
    [alertView show];*/
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
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        hud.labelText = @"Updating Cart";
        
        [[Moltin sharedInstance].cart insertItemWithId:self.productId quantity:self.quantity andModifiersOrNil:self.selectedModifiers
                                               success:^(NSDictionary *response)
        {
            self.btnAddToCart.enabled = YES;
            dispatch_async(dispatch_get_main_queue(), ^{
                [MBProgressHUD hideHUDForView:self.view animated:YES];
                [[NSNotificationCenter defaultCenter] postNotificationName:kMoltinNotificationRefreshCart object:nil];
            });
        } failure:^(NSDictionary *response, NSError *error) {
            self.btnAddToCart.enabled = YES;
            NSLog(@"ERROR: %@", error);

            
            NSString *errorText = @"Failed to add product to cart.";
            if ([response objectForKey:@"errors"]) {
                if ([[response objectForKey:@"errors"] isKindOfClass:[NSArray class]]) {
                    errorText = [[response objectForKey:@"errors"] firstObject];
                }
            }
            
            ALERT(@"Sorry, something went wrong", errorText);
            dispatch_async(dispatch_get_main_queue(), ^{
                [MBProgressHUD hideHUDForView:self.view animated:YES];
            });
        }];
    }
}

#pragma mark SlideNavigationController

- (BOOL)slideNavigationControllerShouldDisplayRightMenu
{
    return YES;
}

@end
