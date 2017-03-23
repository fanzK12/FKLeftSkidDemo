//
//  AppDelegate.m
//  FKLeftSkidDemo
//
//  Created by apple on 17/3/22.
//  Copyright © 2017年 admin. All rights reserved.
//

#import "AppDelegate.h"
#import "FKLeftSortsVC.h"
#import "FKMainTabBar.h"
#import "FKMainTabBarVC.h"
#import "FKAdvertManager.h"
#import "FKAdvertView.h"
#import "FKLeftSkidManager.h"
#import "FKLeftSkidVC.h"
#import "FKMainNavigationVC.h"
#import "FKFirstVC.h"
#import "FKSecondVC.h"
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {

    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];   //设置通用背景颜色
    [self.window makeKeyAndVisible];
    
    [self initRootViewController];

    return YES;
}

- (void)initRootViewController{
    
    FKFirstVC * firstVC = [[FKFirstVC alloc] init];
    
    UINavigationController * firstNav = [[FKMainNavigationVC alloc] initWithRootViewController:firstVC];
    firstNav.tabBarItem.image = [UIImage imageNamed:@"tab_buddy_nor"];
    firstVC.title = @"首页";
    firstVC.navigationController.navigationBar.barTintColor = [UIColor redColor];
    
    FKSecondVC * secondVC = [[FKSecondVC alloc] init];
    UINavigationController * secondNav = [[FKMainNavigationVC alloc] initWithRootViewController:secondVC];
    secondNav.tabBarItem.image = [UIImage imageNamed:@"tab_me_nor"];
    secondVC.title = @"我的";
    
    FKMainTabBarVC * tabVC = [[FKMainTabBarVC alloc] init];
    [tabVC setViewControllers:@[firstNav,secondNav]];
    tabVC.tabBar.tintColor = [UIColor magentaColor];
    
    FKLeftSortsVC * leftVC = [[FKLeftSortsVC alloc] init];
    FKLeftSkidVC * rootVC = [[FKLeftSkidVC alloc] initWithLeftSkidView:leftVC andMainView:tabVC];
    
    self.window.rootViewController = rootVC;
    
    //启动图片
    [[FKAdvertManager sharedInstance] setAdvertViewController];
}
- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
