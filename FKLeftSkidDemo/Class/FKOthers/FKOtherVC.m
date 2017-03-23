//
//  FKOtherVC.m
//  FKLeftSkidDemo
//
//  Created by apple on 17/3/23.
//  Copyright © 2017年 admin. All rights reserved.
//

#import "FKOtherVC.h"
#import "DKNightVersion.h"
@interface FKOtherVC ()

@end

@implementation FKOtherVC

- (void)viewDidLoad {
    [super viewDidLoad];

    UILabel * navigationLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 50, 44)];
    navigationLabel.text = self.titleName;
    navigationLabel.textAlignment = NSTextAlignmentCenter;
    self.navigationItem.titleView = navigationLabel;
    
    @weakify(self);
    [self addColorChangedBlock:^{
        @strongify(self);
        
        navigationLabel.nightTextColor = [UIColor whiteColor];
        self.view.normalBackgroundColor = [UIColor whiteColor];
        self.view.nightBackgroundColor = UIColorFromRGB(0x343434);
        self.navigationController.navigationBar.nightTintColor = [UIColor redColor];
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
