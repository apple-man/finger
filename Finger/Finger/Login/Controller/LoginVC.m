//
//  LoginVC.m
//  Finger
//
//  Created by 张盖 on 2017/7/21.
//  Copyright © 2017年 qyd. All rights reserved.
//

#import "LoginVC.h"
#import <LocalAuthentication/LocalAuthentication.h>

@interface LoginVC ()<UITextFieldDelegate>

/**
  手机号
 */
@property (strong, nonatomic) IBOutlet UITextField *phoneEdit;

/**
  密码
 */
@property (strong, nonatomic) IBOutlet UITextField *passEdit;

/**
   指纹按钮
 */
@property (strong, nonatomic) IBOutlet UIButton *btnHand;

/**
  登录按钮
 */
@property (strong, nonatomic) IBOutlet UIButton *loginBtn;


@end

@implementation LoginVC

- (void)viewDidLoad {
   [super viewDidLoad];
    
    
    self.phoneEdit.delegate = self ;
    
    self.passEdit.delegate = self;
    
     [self.phoneEdit becomeFirstResponder];
    
    // 判断用户手机系统是否是 iOS 8.0 以上版本
    if ([UIDevice currentDevice].systemVersion.floatValue < 8.0) {
        self.btnHand.enabled = NO ;
        
    }else {
        self.btnHand.enabled = YES ;
        
    }
    
    // 实例化本地身份验证上下文
    LAContext *context= [[LAContext alloc] init];
    
    
    // 判断是否支持指纹识别
    if (![context canEvaluatePolicy:LAPolicyDeviceOwnerAuthentication error:NULL]) {
        self.btnHand.enabled = NO ;
        
        return;
    }
    
    
 }


/**
 *  指纹识别的按钮
 */
- (IBAction)btnCheck:(UIButton *)sender {

    [self.phoneEdit resignFirstResponder];
    [self.passEdit resignFirstResponder];
    // 实例化本地身份验证上下文
    LAContext *context= [[LAContext alloc] init];
    
    [context evaluatePolicy:LAPolicyDeviceOwnerAuthentication
            localizedReason:@"请验证已有指纹"
                      reply:^(BOOL success, NSError * _Nullable error) {
                          
                          // 输入指纹开始验证，异步执行
                          if (success) {
                              
                              [self refreshUI:[NSString stringWithFormat:@"指纹验证成功"] message:nil];
                              
                          } else {
                              
                              [self refreshUI:[NSString stringWithFormat:@"指纹验证失败"] message:error.userInfo[NSLocalizedDescriptionKey]];
                          }
                      }];
    
    

}

// 主线程刷新 UI
- (void)refreshUI:(NSString *)str message:(NSString *)msg {
    
    dispatch_async(dispatch_get_main_queue(), ^{
        
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:str
                                                                       message:msg
                                                                preferredStyle:UIAlertControllerStyleAlert];
        
        [self presentViewController:alert animated:YES completion:^{
            
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [alert dismissViewControllerAnimated:YES completion:^(void){
                    
                    [self.navigationController popViewControllerAnimated:NO];
                    
                }];
                
            });
        }];
    });
}


#pragma mark - <UITextFieldDelegate>
- (void)textFieldDidBeginEditing:(UITextField *)textField {
  
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    if ([string isEqualToString:@"\n"]) {
        
        return YES;
    }
    // 限制最大输入位数
    NSString *toBeString = [textField.text stringByReplacingCharactersInRange:range withString:string];
    if (self.phoneEdit == textField) {
        if ([toBeString length] > 11) {
            textField.text = [toBeString substringToIndex:11];
            
            return NO;
        }
    }
    if (self.passEdit == textField) {
        if ([toBeString length] > 20) {
            textField.text = [toBeString substringToIndex:20];
            
            return NO;
        }
    }
    
    return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [self.view endEditing:YES];
    
    if (textField == self.phoneEdit) {
        [self.passEdit becomeFirstResponder];
    } else if (textField == self.passEdit) {
        [self clickLogin:self.loginBtn];
    }
    
    return YES;
}


/**
 *  登录
 */
- (IBAction)clickLogin:(UIButton *)sender {
    [self.view endEditing:YES];
    
    if (self.passEdit.text.length == 0) {
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(CKKShowMessageTime * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self.passEdit becomeFirstResponder];
        });
        
        return;
    }
    if (self.passEdit.text.length == 0) {
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(CKKShowMessageTime * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self.passEdit becomeFirstResponder];
        });
        
        return;
    }
    
    // 保存数据
    
}



#pragma mark - <UIResponder>
- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}



@end
