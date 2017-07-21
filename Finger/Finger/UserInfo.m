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
        self.isOpenTouchID = [userDefaults objectForKey:KUserIsOpenTouchID];
        self.isLogin = [userDefaults objectForKey:KUserIsLogin];
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
    [userDefaults synchronize];
}

- (void)removeUserInfoFromUserDefault {
    self.isLogin = NO;
    self.isOpenTouchID = NO;
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults removeObjectForKey:KUserIsLogin];
    [userDefaults removeObjectForKey:KUserIsOpenTouchID];
    [userDefaults synchronize];
}

+ (void)exitLogin {
    [[self sharedInstance] removeUserInfoFromUserDefault];
}

+ (void)delete:(UserInfo *)userInfo {
    
    [[self sharedInstance] removeUserInfoFromUserDefault];
}


@end
