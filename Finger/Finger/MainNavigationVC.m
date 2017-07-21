//
//  MainNavigationVC.m
//  Finger
//
//  Created by 鲍明 on 2017/7/21.
//  Copyright © 2017年 qyd. All rights reserved.
//

#import "MainNavigationVC.h"
#import "HomeVC.h"
#import "SettingVC.h"


@interface MainNavigationVC ()<UINavigationControllerDelegate,UIGestureRecognizerDelegate>

@end

@implementation MainNavigationVC

- (void)viewDidLoad{
    [super viewDidLoad];
    }

+ (void)initialize {
    [[UINavigationBar appearance] setTitleTextAttributes:@{
                                                           NSForegroundColorAttributeName:[UIColor blackColor], NSFontAttributeName:[UIFont systemFontOfSize:18.0]
                                                           }];
    [[UINavigationBar appearance] setBackgroundImage:[UIImage imageNamed:@"EasyCredit14_normal"] forBarPosition:UIBarPositionAny barMetrics:UIBarMetricsDefault];
    [[UINavigationBar appearance] setShadowImage:[[UIImage alloc] init]];
    [[UINavigationBar appearance] setTintColor:[UIColor whiteColor]];
    //    [[UINavigationBar appearance] setTintColor:[UIColor whiteColor]];
    //    [[UINavigationBar appearance] setBarTintColor: WJAppNavigationBackground];
    //    [[UINavigationBar appearance] setShadowImage:[[UIImage alloc] init]];
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    //让界面支持侧滑
    if ([self respondsToSelector:@selector(interactivePopGestureRecognizer)]
        && animated==YES) {
        self.interactivePopGestureRecognizer.enabled = NO;
    }
    if ([self.topViewController isKindOfClass:[viewController class]]) {
        return;
    }
    [super pushViewController:viewController animated:YES];
}

- (NSArray *)popToViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if ([self respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.interactivePopGestureRecognizer.enabled = NO;
    }
    
    return [super popToViewController:viewController animated:animated];
}

- (void)back {
    
    [self popViewControllerAnimated:YES];
    
}

@end
