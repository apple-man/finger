//
//  UserInfo.m
//  Finger
//
//  Created by 鲍明 on 2017/7/21.
//  Copyright © 2017年 qyd. All rights reserved.
//

#import "UserInfo.h"

NSString *const KUserIsLogin = @"userIsLogin";
NSString *const KUserIsOpenTouchID = @"userIsOpenTouchID";
NSString *const KUserisOpenGesturePwd = @"userisOpenGesturePwd";



@implementation UserInfo

#pragma mark - 单例
+ (instancetype)sharedInstance {
    static UserInfo *sSharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sSharedInstance = [[UserInfo alloc] init];
    });
    
    return sSharedInstance;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
        self.isLogin = [[userDefaults objectForKey:KUserIsLogin] integerValue];
        self.isOpenTouchID = [[userDefaults objectForKey:KUserIsOpenTouchID] integerValue];
         self.isOpenGesturePwd = [[userDefaults objectForKey:KUserisOpenGesturePwd] integerValue];
    }
    
    return self;
}

+ (void)insert:(UserInfo *)userInfo {
    
    [[self sharedInstance] storeUserInfoToUserDefault];
}

- (void)storeUserInfoToUserDefault {
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setBool:self.isLogin forKey:KUserIsLogin];
    [userDefaults setBool:self.isOpenTouchID forKey:KUserIsOpenTouchID];
    [userDefaults setBool:self.isOpenGesturePwd forKey:KUserisOpenGesturePwd];
    [userDefaults synchronize];
}

- (void)removeUserInfoFromUserDefault {
    self.isLogin = NO;
    self.isOpenTouchID = NO;
    self.isOpenGesturePwd = NO;
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults removeObjectForKey:KUserIsLogin];
    [userDefaults removeObjectForKey:KUserIsOpenTouchID];
    [userDefaults removeObjectForKey:KUserisOpenGesturePwd];
    [userDefaults synchronize];
}

+ (void)exitLogin {
    [[self sharedInstance] removeUserInfoFromUserDefault];
}

+ (void)delete:(UserInfo *)userInfo {
    
    [[self sharedInstance] removeUserInfoFromUserDefault];
}


@end
