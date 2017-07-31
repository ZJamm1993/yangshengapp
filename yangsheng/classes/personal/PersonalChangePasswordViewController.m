//
//  PersonalChangePasswordViewController.m
//  yangsheng
//
//  Created by Macx on 17/7/12.
//  Copyright © 2017年 jam. All rights reserved.
//

#import "PersonalChangePasswordViewController.h"
#import "PersonalHttpTool.h"

@interface PersonalChangePasswordViewController()

@property (weak, nonatomic) IBOutlet UITextField *oldPasswordTextField;
@property (weak, nonatomic) IBOutlet UITextField *neewPasswordTextField;
@property (weak, nonatomic) IBOutlet UITextField *surePasswordTextField;


@end

@implementation PersonalChangePasswordViewController

-(void)viewDidLoad
{
    [super viewDidLoad];
    self.title=@"修改密码";
}

- (IBAction)changePassword:(id)sender {
    
    NSString* old=self.oldPasswordTextField.text;
    NSString* nee=self.neewPasswordTextField.text;
    NSString* sure=self.surePasswordTextField.text;
    
    if (nee.passwordLength&&sure.passwordLength) {
        if ([nee isEqualToString:sure]) {
            
            [MBProgressHUD showProgressMessage:@"正在修改密码"];
            [PersonalHttpTool changePasswordWithOldPassword:old newPassword:nee token:[UserModel getUser].access_token success:^(BOOL changed,NSString* msg) {
                
                [MBProgressHUD hide];
                if (changed) {
                    NSLog(@"changed YES");
                    [self.navigationController popViewControllerAnimated:YES];
//                    [UserModel savePassword:nee];
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
            [MBProgressHUD showErrorMessage:@"请确认密码一致"];
        }
    }
    else
    {
        [MBProgressHUD showErrorMessage:@"请填写完整"];
    }
}

@end
