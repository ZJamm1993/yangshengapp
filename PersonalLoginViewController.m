//
//  PersonalLoginViewController.m
//  yangsheng
//
//  Created by Macx on 17/7/10.
//  Copyright © 2017年 jam. All rights reserved.
//

#import "PersonalLoginViewController.h"
#import "PersonalRegisterViewController.h"

@interface PersonalLoginViewController ()
@property (weak, nonatomic) IBOutlet UITextField *usernameTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;

@end

@implementation PersonalLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title=@"登录";
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
}
- (IBAction)forgetPassword:(id)sender {
}
- (IBAction)goToRegister:(id)sender {
    PersonalRegisterViewController* re=[[UIStoryboard storyboardWithName:@"Personal" bundle:nil]instantiateViewControllerWithIdentifier:@"PersonalRegisterViewController"];
    [self.navigationController pushViewController:re animated:YES];
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
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
