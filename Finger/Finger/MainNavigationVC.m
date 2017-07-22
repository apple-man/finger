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
    if (self.viewControllers.count > 0) {
        UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [backButton setTitle:@"返回" forState:UIControlStateNormal];
        [backButton setImage:[UIImage imageNamed:@"Login08_normal"] forState:UIControlStateNormal];
        CGRect frame = backButton.frame;
        frame.size = CGSizeMake(70, 30);
        backButton.frame = frame;

//        backButton.size = CGSizeMake(70, 30);
        backButton.titleLabel.font = [UIFont systemFontOfSize:17.0f];
        //设置按钮的所有内容左对齐
        backButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        //让按钮往左偏移10
        backButton.contentEdgeInsets = UIEdgeInsetsMake(0, -5, 0, 0);
        //设置按钮中的字体与箭头的间距
        backButton.titleEdgeInsets = UIEdgeInsetsMake(0, 5, 0, 0);
        //文字颜色
        [backButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [backButton addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
        //viewController就是跳转的下一个控制器！
        viewController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backButton];
        viewController.hidesBottomBarWhenPushed = YES;
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
