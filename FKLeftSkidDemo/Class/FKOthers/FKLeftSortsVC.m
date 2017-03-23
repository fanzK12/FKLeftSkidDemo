//
//  FKLeftSortsVC.m
//  FKLeftSkidDemo
//
//  Created by apple on 17/3/23.
//  Copyright © 2017年 admin. All rights reserved.
//

#import "FKLeftSortsVC.h"
#import "FKLeftSkidManager.h"
#import "FKOtherVC.h"
#import "DKNightVersion.h"
@interface FKLeftSortsVC ()<UITableViewDelegate,UITableViewDataSource>

@end

@implementation FKLeftSortsVC

- (void)viewDidLoad {
    [super viewDidLoad];

    UITableView * tableView = [[UITableView alloc] init];
    self.tableview = tableView;
    tableView.sectionHeaderHeight = 0;
    tableView.sectionFooterHeight = 0;
    tableView.frame = self.view.bounds;
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.separatorStyle = UITableViewCellSelectionStyleNone;
    [self.view addSubview:tableView];
    
    UISwitch * lightButton = [UISwitch new];
    lightButton.frame = CGRectMake((kScreenWidth - kMainPageDistance)/2 + 100, kScreenHeight - 50, 200, 44);
    [lightButton addTarget:self action:@selector(changeLight) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:lightButton];
    
    //设置夜间效果的颜色
    @weakify(self);
    [self addColorChangedBlock:^{
        @strongify(self);
        self.view.normalBackgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"launchImg"]];
        self.view.nightBackgroundColor = UIColorFromRGB(0x343434);
        self.tableview.normalBackgroundColor = [UIColor clearColor];
        self.tableview.nightBackgroundColor = UIColorFromRGB(0x343434);
        self.tableview.nightSeparatorColor = UIColorFromRGB(0x313131);
        self.navigationController.navigationBar.nightTintColor = UIColorFromRGB(0x444444);
        self.navigationItem.leftBarButtonItem.nightTintColor = [UIColor whiteColor];
        self.navigationItem.rightBarButtonItem.nightTintColor = [UIColor whiteColor];
    }];
}

#pragma mark - tableView delegate and dataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 7;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *Identifier = @"Identifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:Identifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:Identifier];
    }
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.textLabel.font = [UIFont systemFontOfSize:20.0f];
    cell.backgroundColor = [UIColor clearColor];
    cell.textLabel.textColor = [UIColor whiteColor];
    
    if (indexPath.row == 0) {
        cell.textLabel.text = @"开通会员";
    } else if (indexPath.row == 1) {
        cell.textLabel.text = @"QQ钱包";
    } else if (indexPath.row == 2) {
        cell.textLabel.text = @"网上营业厅";
    } else if (indexPath.row == 3) {
        cell.textLabel.text = @"个性装扮";
    } else if (indexPath.row == 4) {
        cell.textLabel.text = @"我的收藏";
    } else if (indexPath.row == 5) {
        cell.textLabel.text = @"我的相册";
    } else if (indexPath.row == 6) {
        cell.textLabel.text = @"我的文件";
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    FKOtherVC * otherVC = [[FKOtherVC alloc]init];
    UITableViewCell * cell = [tableView cellForRowAtIndexPath:indexPath];
    otherVC.titleName = cell.textLabel.text;
    [[FKLeftSkidManager sharedInstance].leftSkidVC closedLeftView];//关闭左侧抽屉
    [[FKLeftSkidManager sharedInstance].mainNavigationController pushViewController:otherVC animated:NO];
}

- (void)changeLight{
    if ([DKNightVersionManager currentThemeVersion] == DKThemeVersionNight){
        [DKNightVersionManager dawnComing];
    }
    else{
        [DKNightVersionManager nightFalling];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}


@end
