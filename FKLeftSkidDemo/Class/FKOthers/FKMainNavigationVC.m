//
//  FKMainNavigationVC.m
//  FKLeftSkidDemo
//
//  Created by apple on 17/3/23.
//  Copyright © 2017年 admin. All rights reserved.
//

#import "FKMainNavigationVC.h"
#import "FKLeftSkidManager.h"
@interface FKMainNavigationVC ()

@end

@implementation FKMainNavigationVC

- (void)viewDidLoad {
    [super viewDidLoad];

    [self.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor whiteColor]}];
    
}
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated{

    [[FKLeftSkidManager sharedInstance].leftSkidVC setPanEnabled:NO];
    [super pushViewController:viewController animated:animated];

}

- (UIViewController *) popViewControllerAnimated:(BOOL)animated{
    NSLog(@"%@-----%@",self.viewControllers.firstObject,self.viewControllers.lastObject);

    if (self.viewControllers.count == 2){
        [[FKLeftSkidManager sharedInstance].leftSkidVC setPanEnabled:YES];
    }
    return [super popViewControllerAnimated:animated];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
