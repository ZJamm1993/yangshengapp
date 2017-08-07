//
//  PersonalRegisterViewController.m
//  yangsheng
//
//  Created by Macx on 17/7/10.
//  Copyright © 2017年 jam. All rights reserved.
//

#import "PersonalRegisterViewController.h"
#import "PersonalLoginViewController.h"
#import "PersonalHttpTool.h"

@interface PersonalRegisterViewController ()

@property (weak, nonatomic) IBOutlet UITextField *usernameTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;
@property (weak, nonatomic) IBOutlet UITextField *surePasswordTextField;
@property (weak, nonatomic) IBOutlet UITextField *codeTextField;
@property (weak, nonatomic) IBOutlet UIButton *getCodeButton;

@end

@implementation PersonalRegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"注册";
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)getCode:(id)sender {
    NSString* mobi=self.usernameTextField.text;
    if (mobi.length>0) {
        
        if (![mobi isMobileNumber]) {
            [MBProgressHUD showErrorMessage:@"请填写正确的手机号"];
            return;
        }
        
        [self.codeTextField becomeFirstResponder];
        [MBProgressHUD showProgressMessage:@"正在请求验证码"];
        [PersonalHttpTool getCodeWithMobile:mobi success:^(BOOL sent,NSString* msg) {
            [MBProgressHUD hide];
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

- (IBAction)goToRegister:(id)sender {
    NSString* mobile=self.usernameTextField.text;
    NSString* password=self.passwordTextField.text;
    NSString* code=self.codeTextField.text;
    BOOL isSamePassword=[password isEqualToString:self.surePasswordTextField.text];
    if (mobile.length>0&&password.passwordLength&&code.length>0&&isSamePassword) {
        
        [MBProgressHUD showProgressMessage:@"正在注册"];
        [PersonalHttpTool registerUserWithMobile:mobile password:password code:code invite:@"20" success:^(UserModel *user) {
            [MBProgressHUD hide];
            if (user!=nil) {
                [UserModel saveUser:user];
                
//                NSDictionary* ud=[NSDictionary dictionaryWithObject:user forKey:@"user"];
//                [[NSNotificationCenter defaultCenter]postNotificationName:RegisterUserSuccessNotification object:nil userInfo:ud];
                
                [self goToLogin:nil];
                [MBProgressHUD showSuccessMessage:@"注册成功"];
            }
            else
            {
                [MBProgressHUD showErrorMessage:@"注册出现问题"];
            }
        }];
    }
    else if(!isSamePassword)
    {
        [MBProgressHUD showErrorMessage:@"两次密码不一致"];
    }
    else
    {
        [MBProgressHUD showErrorMessage:@"请填写完整"];
    }
}
- (IBAction)goToLogin:(id)sender {
    
    [self.navigationController popViewControllerAnimated:YES];
    
//    NSArray* controllers=self.navigationController.viewControllers;
//    UIViewController* log=nil;
//    BOOL containsLogin=NO;
//    for (UIViewController* vc in controllers) {
//        if ([vc isMemberOfClass:[PersonalLoginViewController class]]) {
//            log=vc;
//            containsLogin=YES;
//            break;
//        }
//    }
//    if (containsLogin&&log) {
//        [self.navigationController popToViewController:log animated:YES];
//    }
//    else
//    {
//        log=[[UIStoryboard storyboardWithName:@"Personal" bundle:nil]instantiateViewControllerWithIdentifier:@"PersonalLoginViewController"];
//        [self.navigationController pushViewController:log animated:YES];
//    }
}
- (IBAction)goReadProtocol:(id)sender {
    BaseWebViewController* proto=[[BaseWebViewController alloc]initWithUrl:[html_userprotocol urlWithMainUrl]];
    proto.title=@"用户协议";
    [self.navigationController pushViewController:proto animated:YES];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
