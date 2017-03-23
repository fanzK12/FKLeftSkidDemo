//
//  FKLeftSkidManager.m
//  FKLeftSkidDemo
//
//  Created by apple on 17/3/22.
//  Copyright © 2017年 admin. All rights reserved.
//

#import "FKLeftSkidManager.h"

@implementation FKLeftSkidManager

static id _instance;
+ (instancetype)sharedInstance{
    static dispatch_once_t onceTolen;
    dispatch_once(&onceTolen, ^{
        _instance = [[self alloc] init];
    });
    return _instance;
}
@end
