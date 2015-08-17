//
//  MTNavigationController.m
//  MoltinSDK iOS Example
//
//  Created by Moltin on 16/06/15.
//  Copyright (c) 2015 Moltin. All rights reserved.
//

#import "MTNavigationController.h"


@implementation UINavigationItem (RemoveBackButtonText)

-(UIBarButtonItem *)backBarButtonItem
{
    UIBarButtonItem * backButton = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
    backButton.accessibilityLabel = @"Back";
    return backButton;
}

@end

@interface MTNavigationController ()

@end

@implementation MTNavigationController

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
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
