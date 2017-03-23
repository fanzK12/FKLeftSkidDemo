//
//  FKAdvertVC.m
//  FKLeftSkidDemo
//
//  Created by apple on 17/3/23.
//  Copyright © 2017年 admin. All rights reserved.
//

#import "FKAdvertVC.h"
#import "FKLoadingView.h"
#import "DKNightVersion.h"
@interface FKAdvertVC ()<UIWebViewDelegate>
@property (nonatomic, strong) UIWebView *webView;

@end

@implementation FKAdvertVC

- (void)viewDidLoad {
    [super viewDidLoad];
    _webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight+64)];
    _webView.backgroundColor = MCBaseColor;
    _webView.delegate = self;
    _webView.hidden = YES;
    if (!self.adUrl) {
        self.adUrl = @"https://github.com/fanzK12/FKLeftSkidDemo";
    }

    UILabel *navigationLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 50, 44)];
    navigationLabel.text = @"点击进入广告链接";
    navigationLabel.textAlignment = NSTextAlignmentCenter;
    self.navigationItem.titleView = navigationLabel;
    NSURLRequest* request = [NSURLRequest requestWithURL:[NSURL URLWithString:self.adUrl]];
    [_webView loadRequest:request];
    [self.view addSubview:_webView];
    @weakify(self);
    [self addColorChangedBlock:^{
        @strongify(self);
        self.view.normalBackgroundColor = MCBaseColor;
        navigationLabel.nightTextColor = [UIColor whiteColor];
        self.view.nightBackgroundColor = UIColorFromRGB(0x343434);
        self.navigationController.navigationBar.nightTintColor = [UIColor redColor];
    }];
    [FKLoadingView loadingViewWithRect:CGRectMake(0, 0, kScreenWidth, kScreenHeight+64) OnView:self.view];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"push" style:UIBarButtonItemStylePlain target:self action:@selector(pushViewController)];

}
-(void)pushViewController{
    FKAdvertVC *adVc = [[FKAdvertVC alloc] init];
    //    adVc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:adVc animated:YES];
    
}
- (void)setAdUrl:(NSString *)adUrl
{
    _adUrl = adUrl;
}

-(void)webViewDidStartLoad:(UIWebView *)webView{
    
}

-(void)webViewDidFinishLoad:(UIWebView *)webView{
    [FKLoadingView hideFromView:self.view];
    _webView.hidden = NO;
}
-(void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{
    [FKLoadingView hideFromView:self.view];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}


@end
