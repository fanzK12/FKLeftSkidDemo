//
//  FKAdvertView.h
//  FKLeftSkidDemo
//
//  Created by apple on 17/3/23.
//  Copyright © 2017年 admin. All rights reserved.
//

#import <UIKit/UIKit.h>
static NSString *const adImageName = @"adImageName";
static NSString *const adUrl = @"adUrl";
@interface FKAdvertView : UIView
/** 显示广告页面方法*/
- (void)show;

/** 图片路径*/
@property (nonatomic, copy) NSString *filePath;

@end
