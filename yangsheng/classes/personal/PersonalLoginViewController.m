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

#import "WXApi.h"

@interface PersonalLoginViewController ()
@property (weak, nonatomic) IBOutlet UITextField *usernameTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;
@property (weak, nonatomic) IBOutlet UIView *thirdLoginBg;

@end

@implementation PersonalLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title=@"登录";
    
    self.usernameTextField.text=[[UserModel getUser]mobile];
    [UserModel deleteUser];
    // Do any additional setup after loading the view.
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(weChatAuthReturnNotification:) name:WeChatReturnAuthCodeNotification object:nil];
    
    self.thirdLoginBg.hidden=YES;//![WXApi isWXAppInstalled];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)loginWithQQ:(id)sender {
}
- (IBAction)loginWithWeChat:(id)sender {
    if ([WXApi isWXAppInstalled]) {
        SendAuthReq* req=[[SendAuthReq alloc]init];
        req.scope=@"snsapi_userinfo";
        req.state=@"123";
        [WXApi sendReq:req];
    }
//    else
//    {
//        [MBProgressHUD showErrorMessage:@"未安装微信"];
//    }
}

-(void)weChatAuthReturnNotification:(NSNotification*)noti
{
    NSDictionary* userInfo=noti.userInfo;
    NSLog(@"\n%@",userInfo);
    [MBProgressHUD showProgressMessage:@"正在登录.."];
    NSString* code=[userInfo valueForKey:@"code"];
    [PersonalHttpTool loginUserWithWechatCode:code success:^(UserModel *user) {
        [MBProgressHUD hide];
        if(user)
        {
            user.type=UserTypeWeChat;
            [self logSuccessWithUser:user];
        }
        else
        {
            [MBProgressHUD showErrorMessage:@"微信授权登录失败"];
        }
    }];
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
//                [UserModel savePassword:pa];
                [self logSuccessWithUser:user];
            }
            else
            {
                [MBProgressHUD showErrorMessage:@"用户名与密码不匹配"];
            }
        }];
    }
}

-(void)logSuccessWithUser:(UserModel*)user
{
    [UserModel saveUser:user];
    [self.navigationController popViewControllerAnimated:YES];
    
    [[NSNotificationCenter defaultCenter]postNotificationName:LoginUserSuccessNotification object:nil];
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
