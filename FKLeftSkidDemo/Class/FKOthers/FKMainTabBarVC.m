//
//  FKMainTabBarVC.m
//  FKLeftSkidDemo
//
//  Created by apple on 17/3/23.
//  Copyright © 2017年 admin. All rights reserved.
//

#import "FKMainTabBarVC.h"
#import "FKMainTabBar.h"
@interface FKMainTabBarVC ()

@end

@implementation FKMainTabBarVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpTabBar];
}
#pragma mark - 3、添加自定义tabBar------

- (void)setUpTabBar{
    FKMainTabBar * tabBar = [[FKMainTabBar alloc] init];
    [self setValue:tabBar forKey:@"tabBar"];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}

@end
