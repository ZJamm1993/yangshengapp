//
//  PersonalLoginViewController.m
//  yangsheng
//
//  Created by Macx on 17/7/10.
//  Copyright © 2017年 jam. All rights reserved.
//

#import "PersonalLoginViewController.h"
#import "PersonalRegisterViewController.h"
#import "PersonalForgetPasswordViewController.h"

#import "PersonalHttpTool.h"

@interface PersonalLoginViewController ()
@property (weak, nonatomic) IBOutlet UITextField *usernameTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;

@end

@implementation PersonalLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title=@"登录";
    
    self.usernameTextField.text=[[UserModel getUser]mobile];
    [UserModel deleteUser];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)loginWithQQ:(id)sender {
}
- (IBAction)loginWithWeChat:(id)sender {
}
- (IBAction)loginWithUserNamePassword:(id)sender {
    NSString* mo=self.usernameTextField.text;
    NSString* pa=self.passwordTextField.text;
    if (mo.length>0&&pa.length>0) {
        [MBProgressHUD showProgressMessage:@"正在登录.."];
        [PersonalHttpTool loginUserWithMobile:mo password:pa success:^(UserModel *user) {
            [MBProgressHUD hide];
            if(user)
            {
                [UserModel saveUser:user];
                [UserModel savePassword:pa];
                [self.navigationController popViewControllerAnimated:YES];
                
                [[NSNotificationCenter defaultCenter]postNotificationName:LoginUserSuccessNotification object:user];
            }
            else
            {
                [MBProgressHUD showErrorMessage:@"用户名与密码不匹配"];
            }
        }];
    }
}
- (IBAction)forgetPassword:(id)sender {
    
    PersonalForgetPasswordViewController* re=[[UIStoryboard storyboardWithName:@"Personal" bundle:nil]instantiateViewControllerWithIdentifier:@"PersonalForgetPasswordViewController"];
    [self.navigationController pushViewController:re animated:YES];
}

- (IBAction)goToRegister:(id)sender {
    PersonalRegisterViewController* re=[[UIStoryboard storyboardWithName:@"Personal" bundle:nil]instantiateViewControllerWithIdentifier:@"PersonalRegisterViewController"];
    [self.navigationController pushViewController:re animated:YES];
}

@end
