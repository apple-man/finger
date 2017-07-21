//
//  TabBarVC.m
//  Finger
//
//  Created by 鲍明 on 2017/7/21.
//  Copyright © 2017年 qyd. All rights reserved.
//

#import "TabBarVC.h"
#import "MainNavigationVC.h"
#import "HomeVC.h"
#import "SettingVC.h"

@interface TabBarVC ()

/** 轻易贷 */
@property (nonatomic,strong) HomeVC *homeVC;
/** 理财 */
@property (nonatomic,strong) SettingVC *settingVC;

@end

@implementation TabBarVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //修改tabbar顶部线的颜色
    CGRect rect = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 1);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context,[UIColor colorWithRed:237/255 green:237/255 blue:237/255 alpha:1].CGColor);
    CGContextFillRect(context, rect);
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    [self.tabBar setShadowImage:img];
    [self.tabBar setBackgroundImage:[[UIImage alloc]init]];
}

/** 自定义加载2个主界面 */
- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        self.homeVC = (HomeVC *)[self addControllerWithVcName:@"HomeVC" title:@"首页" image:@"EasyCredit02_normal" selectedImage:@"EasyCredit02_selected"];
        self.settingVC = (SettingVC *)[self addControllerWithVcName:@"SettingVC" title:@"设置" image:@"EasyCredit04_normal" selectedImage:@"EasyCredit04_selected"];
    }
    
    return self;
}

- (UIViewController *)addControllerWithVcName:(NSString *)name title:(NSString *)title image:(NSString *)image selectedImage:(NSString *)selectedImage {
    UIStoryboard *sb = [UIStoryboard storyboardWithName:name bundle:nil];
    UIViewController *vc = [sb instantiateInitialViewController];
    
    return [self addControllerWithVc:vc title:title image:image selectedImage:selectedImage];
}

- (UIViewController *)addControllerWithClass:(Class)class title:(NSString *)title image:(NSString *)image selectedImage:(NSString *)selectedImage {
    UIViewController *vc = [[class alloc] init];
    
    return [self addControllerWithVc:vc title:title image:image selectedImage:selectedImage];
}

- (UIViewController *)addControllerWithVc:(UIViewController *)vc title:(NSString *)title image:(NSString *)image selectedImage:(NSString *)selectedImage {
    vc.title = title;
    vc.tabBarItem.image = [UIImage imageNamed:image];
    UIImage *newImg = [UIImage imageNamed:selectedImage];
    newImg = [newImg imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    vc.tabBarItem.selectedImage = newImg;
    [vc.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor blueColor]} forState:UIControlStateSelected];
     MainNavigationVC *nav = [[MainNavigationVC alloc] initWithRootViewController:vc];
    [self addChildViewController:nav];
    self.tabBar.itemPositioning = UITabBarItemPositioningFill;
    self.tabBar.itemWidth = [UIScreen mainScreen].bounds.size.width * 0.25;
    self.tabBar.itemSpacing = 0;
    //设置tabbar底部背景色
    [self.tabBar setBackgroundImage:[self createImageWithColor:[UIColor whiteColor]]];
    
    return vc;
}

/**
 *  将颜色转成图片
 */
- (UIImage*)createImageWithColor:(UIColor*)color {
    CGRect rect=CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return theImage;
}

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    
    // 矫正底部TabBar图片和title的位置，使之垂直居中显示
    for (UITabBarItem *item in self.tabBar.items) {
        item.imageInsets = UIEdgeInsetsMake(-1, 0, 1, 0);
        item.titlePositionAdjustment = UIOffsetMake(0, -4);
    }
}


@end
