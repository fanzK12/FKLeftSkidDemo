//
//  FKSecondVC.m
//  FKLeftSkidDemo
//
//  Created by apple on 17/3/23.
//  Copyright © 2017年 admin. All rights reserved.
//

#import "FKSecondVC.h"
#import "DKNightVersion.h"
#import "FKLeftSkidManager.h"
#import "UICountingLabel.h"
#import "FKLoginVC.h"
@interface FKSecondVC ()
@property (nonatomic, strong) UICountingLabel * scoreLabel;
@end

@implementation FKSecondVC

- (void)viewDidLoad {
    [super viewDidLoad];

    //设置黑夜效果
    [self setNightEffect];
    _scoreLabel = [[UICountingLabel alloc] initWithFrame:CGRectMake(10, 90, 200, 40)];
    [self.view addSubview:_scoreLabel];
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
    formatter.numberStyle = kCFNumberFormatterDecimalStyle;
    _scoreLabel.formatBlock = ^NSString* (CGFloat value)
    {
        NSString* formatted = [formatter stringFromNumber:@((int)value)];
        return [NSString stringWithFormat:@"Score: %@",formatted];
    };
    _scoreLabel.method = UILabelCountingMethodEaseOut;
}
-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
    [_scoreLabel countFrom:0 to:10000 withDuration:2.5];
}
- (void)setNightEffect{
    UILabel * navigationLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 50, 44)];
    navigationLabel.text = @"我的";
    navigationLabel.textAlignment = NSTextAlignmentCenter;
    self.navigationItem.titleView = navigationLabel;
    
    @weakify(self);
    [self addColorChangedBlock:^{
        @strongify(self);
        self.view.normalBackgroundColor = UIColorFromRGB(0x9AFFFF);
        self.view.nightBackgroundColor = UIColorFromRGB(0x343434);
        navigationLabel.nightTextColor = [UIColor whiteColor];
        self.navigationController.navigationBar.nightBarTintColor = [UIColor blackColor];
    }];
    
    UIButton *menuBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    menuBtn.frame = CGRectMake(0, 0, 20, 18);
    [menuBtn setBackgroundImage:[UIImage imageNamed:@"menu"] forState:UIControlStateNormal];
    [menuBtn addTarget:self action:@selector(openOrCloseLeftList) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:menuBtn];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"登录" style:UIBarButtonItemStyleDone target:self action:@selector(login)];
}
- (void) openOrCloseLeftList
{
    if ([FKLeftSkidManager sharedInstance].leftSkidVC.closed){
        [[FKLeftSkidManager sharedInstance].leftSkidVC openLeftView];
    }
    else{
        [[FKLeftSkidManager sharedInstance].leftSkidVC closedLeftView];
    }
}
/// 登录按钮点击事件
-(void)login{
    FKLoginVC *vc = [[FKLoginVC alloc] init];
    UINavigationController *navVC = [[UINavigationController alloc] initWithRootViewController:vc];
    
    [self presentViewController:navVC animated:YES completion:nil];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}



@end
