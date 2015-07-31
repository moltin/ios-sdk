//
//  MTSlideNavigationController.m
//  MoltinSDK iOS Example
//
//  Created by Moltin on 24/06/15.
//  Copyright (c) 2015 Moltin. All rights reserved.
//

#import "MTSlideNavigationController.h"

@interface MTSlideNavigationController ()

@end

@implementation MTSlideNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    UINavigationBar *navBar = self.navigationBar;
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
    
    self.enableShadow = NO;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
