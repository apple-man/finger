//
//  HomeVC.m
//  Finger
//
//  Created by 鲍明 on 2017/7/21.
//  Copyright © 2017年 qyd. All rights reserved.
//

#import "HomeVC.h"
#import "UserInfo.h"
#import "LoginVC.h"

@interface HomeVC ()
@property (strong, nonatomic) IBOutlet UIWebView *myWebview;

@end

@implementation HomeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // 2.创建请求
    NSMutableURLRequest *request =[NSMutableURLRequest requestWithURL:[NSURL URLWithString:@"http://help.kaiyuan.net"]];
    // 3.加载网页
    [self.myWebview loadRequest:request];
    
    //由storyboard根据myView的storyBoardID来获取我们要切换的视图
    if (![UserInfo sharedInstance].isLogin) {
        UIStoryboard *sb = [UIStoryboard storyboardWithName:@"login" bundle:nil];

        LoginVC *loginVC = [sb instantiateViewControllerWithIdentifier:@"LoginVC"];
        [self presentViewController:loginVC animated:YES completion:nil];
    }
   
}

@end
