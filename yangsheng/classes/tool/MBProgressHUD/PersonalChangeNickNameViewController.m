//
//  PersonalChangeNickNameViewController.m
//  yangsheng
//
//  Created by Macx on 17/7/12.
//  Copyright © 2017年 jam. All rights reserved.
//

#import "PersonalChangeNickNameViewController.h"
#import "PersonalHttpTool.h"

@interface PersonalChangeNickNameViewController ()
@property (weak, nonatomic) IBOutlet UITextField *nicknameTextField;

@end

@implementation PersonalChangeNickNameViewController
{
    NSString* lastName;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.title=@"修改昵称";
    
    lastName=[UserModel getUser].user_nicename;
    self.nicknameTextField.text=lastName;
    [self.nicknameTextField becomeFirstResponder];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)changeNickName:(id)sender {
    NSString* newName=self.nicknameTextField.text;
    if ([newName isEqualToString:lastName]) {
        [self.navigationController popViewControllerAnimated:YES];
    }
    if (newName.length>0) {
        
        [MBProgressHUD showProgressMessage:@"正在修改昵称"];
        [PersonalHttpTool changeUserNickName:newName token:[UserModel getUser].access_token success:^(BOOL changed) {
            if (changed) {
                
                [MBProgressHUD hide];
                UserModel* us=[UserModel getUser];
                us.user_nicename=newName;
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
