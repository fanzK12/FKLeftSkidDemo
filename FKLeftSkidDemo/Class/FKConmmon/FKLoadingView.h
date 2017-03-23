//
//  FKLoadingView.h
//  FKLeftSkidDemo
//
//  Created by apple on 17/3/23.
//  Copyright © 2017年 admin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FKLoadingView : UIView
+ (FKLoadingView *)loadingViewWithRect:(CGRect)frame OnView:(UIView *)view;

+ (BOOL)hideFromView:(UIView *)view;
@end
