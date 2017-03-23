//
//  FKLeftSkidVC.m
//  FKLeftSkidDemo
//
//  Created by apple on 17/3/22.
//  Copyright © 2017年 admin. All rights reserved.
//

#import "FKLeftSkidVC.h"
#import "FKLeftSkidManager.h"

@interface FKLeftSkidVC ()<UIGestureRecognizerDelegate,UITabBarControllerDelegate>
{
    CGFloat _scalef;   //实时横向位移
}

@property (nonatomic, strong) UITableView * leftTableView;
@property (nonatomic, assign) CGFloat leftTableViewW;
@property (nonatomic, strong) UIView * contentView;
@property (nonatomic, weak) UISwitch * leftSwitch;
@end

@implementation FKLeftSkidVC

- (void)viewDidLoad {
    [super viewDidLoad];
}



- (instancetype)initWithLeftSkidView:(UIViewController *)leftVC andMainView:(UITabBarController *)mainVC{

    if(self = [super init]){
        self.speedf = vSpeedFloat;
        self.leftVC = leftVC;
        self.mainVC = mainVC;
        
        mainVC.delegate = self;
        [self addChildViewController:self.leftVC];
        [self addChildViewController:self.mainVC];
        
        //滑动手势
        self.pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePan:)];
        [self.mainVC.view addGestureRecognizer:self.pan];

        [self.pan setCancelsTouchesInView:YES];
        self.pan.delegate = self;
        
        self.leftVC.view.hidden = YES;
        
        [self.view addSubview:self.leftVC.view];
        
        //蒙版
        UIView * view = [[UIView alloc] init];
        view.frame = self.leftVC.view.bounds;
        view.backgroundColor = [UIColor blackColor];
        view.alpha = 0.5;
        self.contentView = view;
        [self.leftVC.view addSubview:view];
        
        //获取左侧tableView
        for (UIView * objc in self.leftVC.view.subviews) {
            if ([objc isKindOfClass:[UITableView class]]){
                self.leftTableView = (UITableView *)objc;
            }
        }
        self.leftTableView.backgroundColor = [UIColor clearColor];
        self.leftTableView.frame = CGRectMake(kMainPageDistance, (kScreenHeight - 300)/2, kScreenWidth - kMainPageDistance *1.5, 300);
        //设置左侧tableView的初始位置和缩放系数
        self.leftTableView.transform = CGAffineTransformMakeScale(kLeftScale, kLeftScale);
        [self.view addSubview:self.leftVC.view];
        [self.view addSubview:self.mainVC.view];
        
        self.closed = YES;//初始时侧滑窗关闭
        
        [FKLeftSkidManager sharedInstance].leftSkidVC = self;
        [FKLeftSkidManager sharedInstance].mainNavigationController = mainVC.viewControllers.firstObject;
        UINavigationController * navVC = (UINavigationController *)mainVC.viewControllers.firstObject;
        UIViewController *firstVC = navVC.viewControllers.firstObject;
        UIButton * menuBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        menuBtn.frame = CGRectMake(0, 0, 20, 18);
        [menuBtn setBackgroundImage:[UIImage imageNamed:@"menu"] forState:UIControlStateNormal];
        [menuBtn addTarget:self action:@selector(openOrCloseLeftList) forControlEvents:UIControlEventTouchUpInside];
        firstVC.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:menuBtn];
        
    }
    return self;

}

- (void)openOrCloseLeftList{
    if ([FKLeftSkidManager sharedInstance].leftSkidVC.closed){
        [[FKLeftSkidManager sharedInstance].leftSkidVC openLeftView];
    }
    else{
        [[FKLeftSkidManager sharedInstance].leftSkidVC closedLeftView];
    }
}
- (void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.leftVC.view.hidden = NO;
}

#pragma mark - 
#pragma mark 滑动手势
- (void)handlePan:(UIPanGestureRecognizer *)recongnizer{
    CGPoint point = [recongnizer translationInView:self.view];
    _scalef = (point.x * self.speedf + _scalef);
    
    BOOL needMoveWithTap = YES;  //是否还需要跟随手指移动
    if (((self.mainVC.view.x <= 0) && (_scalef <= 0)) || ((self.mainVC.view.x >= (kScreenWidth - kMainPageDistance)) && (_scalef >= 0))){
        
        //边界值管控
        _scalef = 0;
        needMoveWithTap = NO;
    }
    
    //根据视图位置判断是左滑还是右滑
    if (needMoveWithTap && (recongnizer.view.frame.origin.x >= 0) && (recongnizer.view.frame.origin.x <= (kScreenWidth - kMainPageDistance))){
        
        CGFloat recCenterX = recongnizer.view.center.x + point.x * self.speedf;
        if (recCenterX < kScreenWidth * 0.5 - 2){
            recCenterX = kScreenWidth * 0.5;
        }
        
        CGFloat recCenterY = recongnizer.view.center.y;
        recongnizer.view.center = CGPointMake(recCenterX, recCenterY);
        
        //scale 1.0~kMainPageScale
        CGFloat scale = 1 - (1 - kMainPageScale) * (recongnizer.view.frame.origin.x / (kScreenWidth - kMainPageDistance));
        
        recongnizer.view.transform = CGAffineTransformScale(CGAffineTransformIdentity, scale, scale);
        [recongnizer setTranslation:CGPointMake(0, 0) inView:self.view];
        
        CGFloat leftTabCenterX = kLeftCenterX + ((kScreenWidth - kMainPageDistance) *0.5 - kLeftCenterX) * (recongnizer.view.frame.origin.x / (kScreenWidth - kMainPageDistance));
        
        //leftScale kLeftScale~1.0
        CGFloat leftScale = kLeftScale + (1 - kLeftScale) * (recongnizer.view.frame.origin.x) / (kScreenWidth - kMainPageDistance);
        
        self.leftVC.view.center = CGPointMake(leftTabCenterX, kScreenHeight * 0.5);
        self.leftVC.view.transform = CGAffineTransformScale(CGAffineTransformIdentity, leftScale, leftScale);
        
        //tempAlpha  kLeftAlpha~0
        CGFloat tempAlpha = kLeftAlpha - kLeftAlpha * (recongnizer.view.frame.origin.x / (kScreenWidth - kMainPageDistance));
        self.contentView.alpha = tempAlpha;
        
    }
    else{
        
        //超出范围
        if(self.mainVC.view.x < 0){
            [self closedLeftView];
            _scalef = 0;
        }
        else if (self.mainVC.view.x > (kScreenWidth - kMainPageDistance)){
            [self openLeftView];
            _scalef = 0;
        }
    }
    
    //手势结束后修正位置，超过约一半时向多出的一半偏移
    if (recongnizer.state == UIGestureRecognizerStateEnded){
        if (fabs(_scalef) > vCouldChangeDeckStateDistance){
            if(self.closed){
                [self openLeftView];
            }
            else{
                [self closedLeftView];
            }
        }
        else{
            if (self.closed){
                [self closedLeftView];
            }
            else{
                [self openLeftView];
            }
        }
        _scalef = 0;
    }
}

#pragma mark - 点击手势
- (void)handleTap:(UITapGestureRecognizer *)tap{
    
    if ((!self.closed) && (tap.state == UIGestureRecognizerStateEnded)){
        [UIView beginAnimations:nil context:nil];
        tap.view.transform = CGAffineTransformScale(CGAffineTransformIdentity, 1.0, 1.0);
        tap.view.center = CGPointMake(kScreenWidth/2, kScreenHeight/2);
        self.closed = YES;
        
        self.leftVC.view.center = CGPointMake(kLeftCenterX, kScreenHeight * 0.5);
        self.leftVC.view.transform = CGAffineTransformScale(CGAffineTransformIdentity, kLeftScale, kLeftScale);
        self.contentView.alpha = kLeftAlpha;
        [UIView commitAnimations];
        _scalef = 0;
        [self removeSingleTap];
    }


}

#pragma mark - 修改视图位置
/**
 @brief 关闭左视图
 */
- (void)closedLeftView{
    [UIView beginAnimations:nil context:nil];
    self.mainVC.view.transform = CGAffineTransformScale(CGAffineTransformIdentity, 1.0, 1.0);
    self.mainVC.view.center = CGPointMake(kScreenWidth/2, kScreenHeight/2);
    self.closed = YES;
    
    self.leftVC.view.center = CGPointMake(kLeftCenterX, kScreenHeight * 0.5);
    self.leftVC.view.transform = CGAffineTransformScale(CGAffineTransformIdentity, kLeftScale, kLeftScale);
    self.contentView.alpha = kLeftAlpha;
    
    [UIView commitAnimations];
    [self removeSingleTap];
}

/**
 @brief 打开左视图
 */
- (void)openLeftView{
    [UIView beginAnimations:nil context:nil];
    self.mainVC.view.transform = CGAffineTransformScale(CGAffineTransformIdentity, kMainPageScale, kMainPageScale);
    self.mainVC.view.center = kMainPageCenter;
    self.closed = NO;
    
    self.leftVC.view.center = CGPointMake((kScreenWidth - kMainPageDistance) * 0.5, kScreenHeight * 0.5);
    self.leftVC.view.transform = CGAffineTransformScale(CGAffineTransformIdentity, 1.0, 1.0);
    self.contentView.alpha = 0;
    
    [UIView commitAnimations];
    [self disableTapButton];
}


#pragma mark - 行为收敛控制
- (void)disableTapButton{
    for (UIButton * tempButton in [_mainVC.view subviews]) {
        [tempButton setUserInteractionEnabled:NO];
    }
    //单击
    if (!self.sideslipTapGes){
        //单击手势
        self.sideslipTapGes = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTap:)];
        [self.sideslipTapGes setNumberOfTapsRequired:1];
        
        [self.mainVC.view addGestureRecognizer:self.sideslipTapGes];
        self.sideslipTapGes.cancelsTouchesInView = YES;  //点击事件盖住其他响应事件，但盖不住button
    }
}

//关闭行为收敛
- (void) removeSingleTap
{
    for (UIButton *tempButton in [self.mainVC.view  subviews])
    {
        [tempButton setUserInteractionEnabled:YES];
    }
    [self.mainVC.view removeGestureRecognizer:self.sideslipTapGes];
    self.sideslipTapGes = nil;
}

/**
 *  设置滑动开关是否开启
 *
 *  @param enabled YES:支持滑动手势，NO:不支持滑动手势
 */
- (void)setPanEnabled:(BOOL)enabled{
    [self.pan setEnabled:enabled];
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch{
    
    if (touch.view.tag == vDeckCanNotPanViewTag){
                NSLog(@"不响应侧滑");
        return NO;
    }
    else{
                NSLog(@"响应侧滑");
        return YES;
    }
}

- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController{
    [FKLeftSkidManager sharedInstance].mainNavigationController = (UINavigationController *)viewController;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
