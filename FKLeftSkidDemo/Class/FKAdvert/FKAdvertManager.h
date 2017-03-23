//
//  FKAdvertManager.h
//  FKLeftSkidDemo
//
//  Created by apple on 17/3/23.
//  Copyright © 2017年 admin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FKAdvertManager : NSObject
+(instancetype)sharedInstance;
-(void)setAdvertViewController;
@end
