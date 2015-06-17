//
//  MTNavigationController.m
//  MoltinSDK iOS Example
//
//  Created by Gasper Rebernak on 16/06/15.
//  Copyright (c) 2015 Gasper Rebernak. All rights reserved.
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
    
    self.enableSwipeGesture = NO;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
