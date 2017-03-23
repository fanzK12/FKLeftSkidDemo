//
//  FKLeftSkidManager.h
//  FKLeftSkidDemo
//
//  Created by apple on 17/3/22.
//  Copyright © 2017年 admin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FKLeftSkidVC.h"
@interface FKLeftSkidManager : NSObject
+ (instancetype)sharedInstance;

@property (nonatomic, strong) FKLeftSkidVC * leftSkidVC;

@property (nonatomic, strong) UINavigationController * mainNavigationController;
@end
