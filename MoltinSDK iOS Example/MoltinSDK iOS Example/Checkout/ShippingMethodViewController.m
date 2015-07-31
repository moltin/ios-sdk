//
//  ShippingMethodViewController.m
//  MoltinSDK iOS Example
//
//  Created by Moltin on 24/06/15.
//  Copyright (c) 2015 Moltin. All rights reserved.
//

#import "ShippingMethodViewController.h"
#import "PaymentViewController.h"

@interface ShippingMethodView : UIControl

@property (strong, nonatomic) NSString *shippingId;
@property (strong, nonatomic) NSString *shippingSlug;
@property (strong, nonatomic) NSString *totalPrice;

@property (strong, nonatomic) UILabel *lbTitle;
@property (strong, nonatomic) UILabel *lbPrice;
@property (strong, nonatomic) UIView *selectedView;
@property (strong, nonatomic) CALayer *bottomLine;


@end

@implementation ShippingMethodView

- (id)initWithFrame:(CGRect)frame andShippingMethodDictionary:(NSDictionary *) shippingMethod{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.shippingId = [shippingMethod valueForKey:@"id"];
        self.shippingSlug = [shippingMethod valueForKey:@"slug"];
        self.totalPrice = [shippingMethod valueForKeyPath:@"totals.post_discount.formatted.with_tax"];
        
        self.lbTitle = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, (frame.size.width/3)*2, frame.size.height)];
        self.lbTitle.font = [UIFont fontWithName:kMoltinFont size:20];
        self.lbTitle.textColor = [UIColor whiteColor];
        self.lbTitle.text = [shippingMethod valueForKey:@"title"];
        
        [self addSubview:self.lbTitle];
        
        self.lbPrice = [[UILabel alloc] initWithFrame:CGRectMake(self.lbTitle.frame.origin.x+self.lbTitle.frame.size.width, 0, (frame.size.width/3)-20, frame.size.height)];
        self.lbPrice.font = [UIFont fontWithName:kMoltinFont size:20];
        self.lbPrice.textColor = [UIColor whiteColor];
        self.lbPrice.textAlignment = NSTextAlignmentRight;
        self.lbPrice.text = [shippingMethod valueForKeyPath:@"price.data.formatted.with_tax"];
        
        [self addSubview:self.lbPrice];
        
        static CGFloat SELECTED_METHOD_BAR_WIDTH = 7.0f;
        self.selectedView = [[UIView alloc] initWithFrame:CGRectMake(frame.size.width - SELECTED_METHOD_BAR_WIDTH, 0, SELECTED_METHOD_BAR_WIDTH, frame.size.height)];
        self.selectedView.backgroundColor = [UIColor clearColor];
        [self addSubview:self.selectedView];
        
        self.bottomLine = CALayer.new;
        self.bottomLine.backgroundColor = RGB(58, 73, 84).CGColor;
        [self.layer addSublayer:self.bottomLine];
        
    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    self.bottomLine.frame = CGRectMake(0.0, self.frame.size.height-1, self.frame.size.width, 1);
}

- (void)setSelected:(BOOL)selected{
    [super setSelected:selected];
    if (selected) {
        self.lbTitle.font = [UIFont fontWithName:kMoltinFontBold size:20];
        self.lbPrice.font = [UIFont fontWithName:kMoltinFontBold size:20];
        self.selectedView.backgroundColor = RGB(158, 122, 194);
    }
    else{
        self.lbTitle.font = [UIFont fontWithName:kMoltinFont size:20];
        self.lbPrice.font = [UIFont fontWithName:kMoltinFont size:20];
        self.selectedView.backgroundColor = [UIColor clearColor];
    }
}


@end

@interface ShippingMethodViewController ()

@property (strong, nonatomic) NSString *selectedShippingMethodSlug;
@property (strong, nonatomic) NSArray *shippingMethods;

@end

@implementation ShippingMethodViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Shipping method";
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.labelText = @"Loading Shipping Methods";
    
    [[Moltin sharedInstance].cart checkoutWithsuccess:^(NSDictionary *response) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        self.shippingMethods = [response valueForKeyPath:@"result.shipping.methods"];
        [self setupViews];
    } failure:^(NSDictionary *response, NSError *error) {
        NSLog(@"SHIPPING ERROR: %@", error);
        [MBProgressHUD hideHUDForView:self.view animated:YES];
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setupViews
{
    CGFloat width = [UIScreen mainScreen].bounds.size.width;
    CGFloat height = 70;
    CGFloat yOffset = 0;
    NSInteger i = 0;
    
    for (NSDictionary *shippingMethod in self.shippingMethods) {
        ShippingMethodView *theView = [[ShippingMethodView alloc] initWithFrame:CGRectMake(0, yOffset, width, height) andShippingMethodDictionary:shippingMethod];
        [theView addTarget:self action:@selector(shippingMethodSelected:) forControlEvents:UIControlEventTouchUpInside];
        theView.tag = i;
        [self.scrollView addSubview:theView];
        
        yOffset = theView.frame.origin.y + theView.frame.size.height;
        
        if (i == 0) {
            [self shippingMethodSelected:theView];
        }
        i++;
    }
    
    self.scrollView.contentSize = CGSizeMake(self.scrollView.frame.size.width, yOffset);
    
    NSDictionary *shippingAddress = [[NSUserDefaults standardUserDefaults] objectForKey:kMoltinShippingAddressStorageKey];
    NSDictionary *billingAddress = [[NSUserDefaults standardUserDefaults] objectForKey:kMoltinBillingAddressStorageKey];
    
    
    NSLog(@"\nSHIPPING ADDRESS: %@\nBILLING ADDRESS: %@", shippingAddress, billingAddress);
}

- (void)shippingMethodSelected:(ShippingMethodView *) sender{
    
    for (UIControl *control in self.scrollView.subviews) {
        if ([control isKindOfClass:[ShippingMethodView class]] && control.selected) {
            [control setSelected:NO];
        }
    }
    [sender setSelected:!sender.selected];
    self.selectedShippingMethodSlug = sender.shippingSlug;
    self.lbTotalPrice.text = sender.totalPrice;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"creditCardSegue"]) {
        PaymentViewController *destViewController = segue.destinationViewController;
        destViewController.shippingMethodSlug = self.selectedShippingMethodSlug;
    }
}

@end
