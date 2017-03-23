//
//  FKLoginVC.m
//  FKLeftSkidDemo
//
//  Created by apple on 17/3/23.
//  Copyright © 2017年 admin. All rights reserved.
//

#import "FKLoginVC.h"
#import "DKNightVersion.h"
@interface FKLoginVC ()

@end

@implementation FKLoginVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNightEffect];
    self.title = @"登录";
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStyleDone target:self action:@selector(cancleLogin)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"确认" style:UIBarButtonItemStyleDone target:self action:@selector(doneLogin)];
}

- (void)setNightEffect{
    @weakify(self);
    [self addColorChangedBlock:^{
        @strongify(self);
        self.view.normalBackgroundColor = UIColorFromRGB(0xF9E9FF);
        self.view.nightBackgroundColor = UIColorFromRGB(0x343434);
    }];
}

/// 取消登录
-(void)cancleLogin{
    [self dismissViewControllerAnimated:YES completion:nil];
}
/// 登录按钮点击事件
-(void)doneLogin{
    [self dismissViewControllerAnimated:YES completion:nil];
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
