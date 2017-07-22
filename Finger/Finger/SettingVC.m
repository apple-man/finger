//
//  SettingVC.m
//  Finger
//
//  Created by 鲍明 on 2017/7/21.
//  Copyright © 2017年 qyd. All rights reserved.
//

#import "SettingVC.h"
#import "UserInfo.h"
#import "BATouchID.h"
#import "NSString+BAKit.h"
#import "UIAlertController+Blocks.h"
#import "BATouchIDLoginVC.h"
#import "BAUnlockedGestureVC.h"

#define kIsLogin                  @"kIsLogin"
#define kIsOpenTouchID            @"kIsOpenTouchID"
#define kIsOpenUnlockedGesture    @"kIsOpenUnlockedGesture"

#define kLastEnterBackgroundDate  @"kLastEnterBackgroundDate"

#define kUserDefaults [NSUserDefaults standardUserDefaults]



@interface SettingVC ()

@property (weak, nonatomic) IBOutlet UISwitch *touchSwitchBtn;

@end

@implementation SettingVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    if ([UserInfo sharedInstance].isOpenTouchID) {
        self.touchSwitchBtn.on = YES;
    } else {
        self.touchSwitchBtn.on = NO;
    }
}

- (IBAction)clickTouchSwitch:(UISwitch *)sender {
    if ([UserInfo sharedInstance].isLogin) {
        if ([UserInfo sharedInstance].isOpenTouchID) {
            [UIAlertController ba_alertControllerShowAlertInViewController:self withTitle:nil mutableAttributedTitle:nil message:@"继续将关闭指纹解锁" mutableAttributedMessage:nil buttonTitlesArray:@[@"取 消", @"继 续"] buttonTitleColorArray:@[[UIColor greenColor], [UIColor redColor]] tapBlock:^(UIAlertController * _Nonnull controller, UIAlertAction * _Nonnull action, NSInteger buttonIndex) {
                
                if (buttonIndex == 1)
                {
                    //                [UserInfo removeObjectForKey:kIsOpenUnlockedGesture];
                    //                [UserInfo setObject:[NSNumber numberWithBool:NO] forKey:kIsOpenUnlockedGesture];
                    
//                    
//                    if (sender.on)
//                    {
//                        [self checkIsSupportTouchID];
//                    }
//                    else
//                    {
                        UserInfo *userInfo = [UserInfo sharedInstance];
                        userInfo.isOpenTouchID = NO;
                        [UserInfo insert:userInfo];
//                    }
                } else {
                    self.touchSwitchBtn.on = YES;
                }
                return;
            }];
        } else {
            [UIAlertController ba_alertControllerShowAlertInViewController:self withTitle:nil mutableAttributedTitle:nil message:@"继续将开启指纹解锁" mutableAttributedMessage:nil buttonTitlesArray:@[@"取 消", @"继 续"] buttonTitleColorArray:@[[UIColor greenColor], [UIColor redColor]] tapBlock:^(UIAlertController * _Nonnull controller, UIAlertAction * _Nonnull action, NSInteger buttonIndex) {
                
                if(buttonIndex == 1) {
                    [self checkIsSupportTouchID];
                } else {
                    self.touchSwitchBtn.on = NO;
                }
                return;
            }];
        }
    } else {
        sender.on = NO;
        NSString *msg = @"请您先登录后再开启指纹登录！";
        BAKit_ShowAlertWithMsg_ios8(msg);
    }
}

- (void)checkIsSupportTouchID
{
    [BAKit_TouchID ba_touchIDVerifyIsSupportWithBlock:^(BOOL isSupport, LAContext *context, NSInteger policy, NSError *error) {
        if (isSupport)
        {
            if (![UserInfo sharedInstance].isOpenTouchID) {
                UserInfo *userInfo = [UserInfo sharedInstance];
                userInfo.isOpenTouchID = YES;
                [UserInfo insert:userInfo];
                [[NSUserDefaults standardUserDefaults] removeObjectForKey:kIsOpenUnlockedGesture];
                [self presentViewController:[BATouchIDLoginVC new] animated:YES completion:nil];
            }
//            id isShow = [kUserDefaults objectForKey:kIsOpenTouchID];
//            if ([isShow intValue] == 0)
//            {
//                [kUserDefaults setObject:[NSNumber numberWithBool:YES] forKey:kIsOpenTouchID];
//                [self presentViewController:[BATouchIDLoginVC new] animated:YES completion:nil];
//            }
        }
        else
        {
            BAKit_ShowAlertWithMsg_ios8(@"设备不支持 touch ID！");
        }
    }];
}

- (IBAction)clickGestureBtn:(UIButton *)sender {
    
    [self.navigationController pushViewController:[BAUnlockedGestureVC new] animated:YES];
}



@end
