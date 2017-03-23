//
//  FKLoadingView.m
//  FKLeftSkidDemo
//
//  Created by apple on 17/3/23.
//  Copyright © 2017年 admin. All rights reserved.
//

#import "FKLoadingView.h"

@implementation FKLoadingView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

+ (FKLoadingView *)loadingViewWithRect:(CGRect)frame OnView:(UIView *)view
{
    UIView * bgViewTemp = [view viewWithTag:666];
    
    if(!bgViewTemp)
    {
        //        UIView* v = [[UIView alloc] initWithFrame:Rect(0, 0, 88, 88)];
        //        v.backgroundColor = [UIColor redColor];
        //        [view addSubview:v];
        
        bgViewTemp = [[FKLoadingView alloc] initWithFrame:frame];
        //        bgViewTemp.backgroundColor = CYBBaseColor;
        bgViewTemp.tag = 666;
        
        UIImageView * imageView = nil;
        
        //        if(isIphone4 || isIphone5)
        //            imageView = [[UIImageView alloc] initWithFrame:Rect(0, 0, 70.4, 108.8)];
        //        else
        imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 70, 108)];
        
        
        imageView.contentMode = UIViewContentModeScaleAspectFit;
        
        [bgViewTemp addSubview:imageView];
        imageView.center = CGPointMake(bgViewTemp.center.x, bgViewTemp.bounds.size.height/2);
        
        NSMutableArray * loadingImages = [NSMutableArray arrayWithCapacity:0];
        for (int i = 0; i < 8; i++) {
            UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"loading_%d.png",i]];
            [loadingImages addObject:image];
        }
        
        
        imageView.animationImages = loadingImages;//[SingleClass shareSingleClass].loadingImages;
        imageView.animationDuration = 1;
        imageView.animationRepeatCount = NSIntegerMax;
        [imageView startAnimating];
        
        [view addSubview:bgViewTemp];
    }
    
    return (FKLoadingView *)bgViewTemp;
}


+ (BOOL)hideFromView:(UIView *)view
{
    FKLoadingView * bgView = nil;
    NSArray * subViewsArray = view.subviews;
    
    for (UIView * aView in subViewsArray) {
        if ([aView isKindOfClass:[FKLoadingView class]]) {
            bgView = (FKLoadingView *)aView;
            [bgView removeFromSuperview];
            bgView = nil;
        }
    }
    
    return NO;
}

+ (FKLoadingView *)loadingViewForView:(UIView *)view
{
    FKLoadingView * bgView = nil;
    
    return bgView;
}

@end
