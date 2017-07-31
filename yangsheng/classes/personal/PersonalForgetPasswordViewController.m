//
//  PersonalForgetPasswordViewController.m
//  yangsheng
//
//  Created by Macx on 17/7/12.
//  Copyright © 2017年 jam. All rights reserved.
//

#import "PersonalForgetPasswordViewController.h"
#import "PersonalHttpTool.h"

@interface PersonalForgetPasswordViewController ()

@property (weak, nonatomic) IBOutlet UITextField *usernameTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;
@property (weak, nonatomic) IBOutlet UITextField *codeTextField;
@property (weak, nonatomic) IBOutlet UIButton *getCodeButton;
@end

@implementation PersonalForgetPasswordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"忘记密码";
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)getCode:(id)sender {
    NSString* mobi=self.usernameTextField.text;
    if (mobi.length>0) {
        [self.codeTextField becomeFirstResponder];
        [MBProgressHUD showProgressMessage:@"正在请求验证码"];
        [PersonalHttpTool getCodeWithMobile:mobi success:^(BOOL sent,NSString* msg) {
            if (sent) {
                [self startCountDownSeconds:60];
                
                [MBProgressHUD showSuccessMessage:msg];
            }
            else
            {
                [MBProgressHUD showErrorMessage:msg];
            }
        }];
    }
}

-(void)countingDownSeconds:(NSInteger)second
{
    self.getCodeButton.enabled=NO;
    [self.getCodeButton setTitle:[NSString stringWithFormat:@"%d",(int)second] forState:UIControlStateDisabled];
    
}

-(void)endingCountDown
{
    self.getCodeButton.enabled=YES;
}

- (IBAction)goToChangePassword:(id)sender {
    NSString* mobile=self.usernameTextField.text;
    NSString* password=self.passwordTextField.text;
    NSString* code=self.codeTextField.text;
    
    if (mobile.length>0&&password.passwordLength&&code.length>0) {
        
        [MBProgressHUD showProgressMessage:@"正在修改密码"];
        [PersonalHttpTool changePasswordWithMobile:mobile password:password code:code success:^(BOOL changed,NSString* msg) {
            if (changed) {
                
                [MBProgressHUD hide];
                NSLog(@"changed YES");
                [self.navigationController popViewControllerAnimated:YES];
                
                [MBProgressHUD showSuccessMessage:msg];
            }
            else
            {
                [MBProgressHUD showErrorMessage:msg];
            }
        }];
    }
    else
    {
        [MBProgressHUD showErrorMessage:@"请填写完整"];
    }
}

@end
