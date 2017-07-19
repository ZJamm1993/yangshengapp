//
//  PersonalChangeMobileViewController.m
//  yangsheng
//
//  Created by Macx on 17/7/12.
//  Copyright © 2017年 jam. All rights reserved.
//

#import "PersonalChangeMobileViewController.h"
#import "PersonalHttpTool.h"

@interface PersonalChangeMobileViewController ()

@property (weak, nonatomic) IBOutlet UILabel *currentMobile;
@property (weak, nonatomic) IBOutlet UITextField *neewMobileTextField;
@property (weak, nonatomic) IBOutlet UITextField *codeTextField;
@property (weak, nonatomic) IBOutlet UIButton *codeButton;

@end

@implementation PersonalChangeMobileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title=@"修改手机号";
    self.currentMobile.text=self.currentPhoneText;
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
- (IBAction)getCode:(id)sender {
    NSString* mobi=self.neewMobileTextField.text;
    
    if ([self isSameMobile]) {
        [MBProgressHUD showErrorMessage:@"新手机号与前一手机号相同"];
        return;
    }
    
    if (mobi.length>0) {
        [self.codeTextField becomeFirstResponder];
        [MBProgressHUD showProgressMessage:@"正在请求验证码"];
        [PersonalHttpTool getCodeWithMobile:mobi success:^(BOOL sent) {
            if (sent) {
                [self startCountDownSeconds:60];
                
                [MBProgressHUD showSuccessMessage:@"已发送验证码短信"];
            }
            else
            {
                [MBProgressHUD showErrorMessage:@"请求不成功"];
            }
        }];
    }
}


-(void)countingDownSeconds:(NSInteger)second
{
    self.codeButton.enabled=NO;
    [self.codeButton setTitle:[NSString stringWithFormat:@"%d",(int)second] forState:UIControlStateDisabled];
    
}

-(void)endingCountDown
{
    self.codeButton.enabled=YES;
}

-(BOOL)isSameMobile
{
    return [self.neewMobileTextField.text isEqualToString:[[UserModel getUser]mobile]];
}

- (IBAction)goToChangeMobile:(id)sender {
    NSString* mobile=self.neewMobileTextField.text;
    NSString* code=self.codeTextField.text;
    
    if ([self isSameMobile]) {
        [MBProgressHUD showErrorMessage:@"新手机号与前一手机号相同"];
        return;
    }
    
    if (mobile.length>0&&code.length>0) {
        
        [MBProgressHUD showProgressMessage:@"正在修改手机号"];
        [PersonalHttpTool changeUserMobile:mobile code:code token:[UserModel getUser].access_token success:^(BOOL changed) {
            if (changed) {
                
                [MBProgressHUD hide];
                UserModel* us=[UserModel getUser];
                us.mobile=mobile;
                [UserModel saveUser:us];
                NSLog(@"changed YES");
                [self.navigationController popViewControllerAnimated:YES];
                
                [MBProgressHUD showSuccessMessage:@"修改成功"];
            }
            else
            {
                [MBProgressHUD showErrorMessage:@"修改出现问题"];
            }
        }];
    }
    else
    {
        [MBProgressHUD showErrorMessage:@"请填写完整"];
    }
}

@end
