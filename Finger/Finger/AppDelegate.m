//
//  AppDelegate.m
//  Finger
//
//  Created by 鲍明 on 2017/7/20.
//  Copyright © 2017年 qyd. All rights reserved.
//

#import "AppDelegate.h"
#import "TabBarVC.h"
#import "UserInfo.h"
#import "BATouchIDLoginVC.h"
#import "StartVC.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

#pragma mark - 单例
static id _instance;
+ (instancetype)allocWithZone:(struct _NSZone *)zone {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [super allocWithZone:zone];
    });
    
    return _instance;
}

+ (instancetype)sharedInstance {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [[self alloc] init];
    });
    
    return _instance;
}


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.isFirst = YES;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(enter) name:@"dismiss" object:nil];
    StartVC *startVC = [[StartVC alloc] init];
    self.window.rootViewController = startVC;
    [self.window makeKeyAndVisible];
    if ([UserInfo sharedInstance].isOpenTouchID) {
        BATouchIDLoginVC *vc = [[BATouchIDLoginVC alloc] init];
        [self.window.rootViewController presentViewController:vc animated:YES completion:nil];
    } else {
        TabBarVC *tabVC = [[TabBarVC alloc] init];
        self.window.rootViewController = tabVC;
        self.tabVC = tabVC;
        [self.window makeKeyAndVisible];

    }

    return YES;
}

- (void)enter {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [AppDelegate sharedInstance].isFirst = NO;
    TabBarVC *tabVC = [[TabBarVC alloc] init];
    self.window.rootViewController = tabVC;
    self.tabVC = tabVC;
    [self.window makeKeyAndVisible];
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
