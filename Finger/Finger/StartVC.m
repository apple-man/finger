//
//  StartVC.m
//  Finger
//
//  Created by 鲍明 on 2017/7/21.
//  Copyright © 2017年 qyd. All rights reserved.
//

#import "StartVC.h"

@interface StartVC ()

@end

@implementation StartVC

- (void)viewDidLoad {
    [super viewDidLoad];
    UIImageView *image = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
//    
//    if (WJ_Device_iPhone4) {
//        [image setImage:[UIImage imageNamed:@"startAsset_640x960@2x.png"]];
//    }else if (WJ_Device_iPhone5){
//        [image setImage:[UIImage imageNamed:@"startAsset_640x1136@2x.png"]];
//    }else if (WJ_Device_iPhone6){
//        [image setImage:[UIImage imageNamed:@"startAsset_750x1334@2x.png"]];
//    }else if (WJ_Device_iPhone6Plus){
        [image setImage:[UIImage imageNamed:@"startAsset_1242x2208@3x.png"]];
//    }
    [self.view addSubview:image];
}


@end
