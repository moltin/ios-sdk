//
//  AppDelegate.m
//  MoltinSDK iOS Example
//
//  Created by Moltin on 08/06/15.
//  Copyright (c) 2015 Moltin. All rights reserved.
//

#import "AppDelegate.h"
#import "CartViewController.h"
#import "ReceiptsViewController.h"
#import "CollectionsViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.

    [MTSlideNavigationController sharedInstance].rightMenu = [CartViewController sharedInstance];
    [MTSlideNavigationController sharedInstance].portraitSlideOffset = 30;
    
    [MTSlideNavigationController sharedInstance].leftMenu = [ReceiptsViewController sharedInstance];

    [self setLightCartButton];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(setLightCartButton) name:kMoltinNotificationLightCartButton object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(setDarkCartButton) name:kMoltinNotificationDarkCartButton object:nil];

    UIButton *button  = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 30, 45)];
    [button setImage:[UIImage imageNamed:@"saved-orders"] forState:UIControlStateNormal];
    [button addTarget:[SlideNavigationController sharedInstance] action:@selector(toggleLeftMenu) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
    [MTSlideNavigationController sharedInstance].leftBarButtonItem = leftBarButtonItem;
        
    
    return YES;
}

- (void)setCartButton:(BOOL)light {
    NSString *imageName = @"cart";
    
    if (!light) {
        imageName = @"cart-dark";
        
    }
    
    UIButton *button  = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 30, 45)];
    [button setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    [button addTarget:[SlideNavigationController sharedInstance] action:@selector(toggleRightMenu) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
    [MTSlideNavigationController sharedInstance].rightBarButtonItem = rightBarButtonItem;
    
}

- (void)setLightCartButton {
    [self setCartButton:YES];
}

- (void)setDarkCartButton {
    [self setCartButton:NO];

}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
