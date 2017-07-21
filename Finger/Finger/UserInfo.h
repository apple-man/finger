//
//  UserInfo.h
//  Finger
//
//  Created by 鲍明 on 2017/7/21.
//  Copyright © 2017年 qyd. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserInfo : NSObject

/** 是否已经登录*/
@property (nonatomic, assign) BOOL isLogin;
/** 是否开启指纹解锁*/
@property (nonatomic, assign) BOOL isOpenTouchID;

/**
 *  单例
 */
+ (instancetype)sharedInstance;
/**
 *  插入/更新用户信息
 *
 *  @param userInfo 用户信息
 */
+ (void)insert:(UserInfo *)userInfo;
/**
 *  删除用户信息
 *
 *  @param userInfo 用户信息
 */
+ (void)delete:(UserInfo *)userInfo;
/**
 *  退出登录
 */
+ (void)exitLogin;



@end
