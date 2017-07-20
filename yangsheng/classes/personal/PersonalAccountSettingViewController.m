//
//  PersonalAccountSettingViewController.m
//  yangsheng
//
//  Created by Macx on 17/7/12.
//  Copyright © 2017年 jam. All rights reserved.
//

#import "PersonalAccountSettingViewController.h"
#import "UserModel.h"
#import "NaviController.h"
#import "PersonalHttpTool.h"
#import "PersonalChangePasswordViewController.h"
#import "PersonalChangeMobileViewController.h"
#import "PersonalChangeNickNameViewController.h"

@interface PersonalAccountSettingViewController()<UIImagePickerControllerDelegate,UINavigationControllerDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *headImage;
@property (weak, nonatomic) IBOutlet UILabel *nickname;
@property (weak, nonatomic) IBOutlet UILabel *mobile;


@end

@implementation PersonalAccountSettingViewController

-(void)viewDidLoad
{
    [super viewDidLoad];
    self.title=@"个人信息";
    self.tableView.tableFooterView=[[UIView alloc]init];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self reloadUserInfo];
}

-(void)reloadUserInfo
{
    UserModel* user=[UserModel getUser];
    [self.headImage sd_setImageWithURL:[user.avatar urlWithMainUrl] placeholderImage:[UIImage imageNamed:@"user_tx"]];
    self.nickname.text=user.user_nicename;
    
    NSString* mob=user.mobile;
    if (mob.length>=11) {
        NSInteger le=4;
        NSString* h=[mob substringToIndex:le];
        NSString* t=[mob substringFromIndex:mob.length-le];
        mob=[NSString stringWithFormat:@"%@***%@",h,t];
    }
    
    self.mobile.text=mob;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row==2||indexPath.row==3) {
        if ([[UserModel getUser]type]!=UserTypeNormal) {
            return 0;
        }
    }
    return UITableViewAutomaticDimension;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.row==0) {
        UIImagePickerController* pick=[[UIImagePickerController alloc]init];
        pick.sourceType=UIImagePickerControllerSourceTypePhotoLibrary;
        pick.delegate=self;
        pick.allowsEditing=YES;
        if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) {
            [self presentViewController:pick animated:YES completion:nil];
        }
    }
    else if(indexPath.row==1)
    {
        PersonalChangeNickNameViewController* c=[[UIStoryboard storyboardWithName:@"Personal" bundle:nil]instantiateViewControllerWithIdentifier:@"PersonalChangeNickNameViewController"];
        [self.navigationController pushViewController:c animated:YES];
    }
    else if(indexPath.row==2)
    {
        PersonalChangeMobileViewController* c=[[UIStoryboard storyboardWithName:@"Personal" bundle:nil]instantiateViewControllerWithIdentifier:@"PersonalChangeMobileViewController"];
        c.currentPhoneText=self.mobile.text;
        [self.navigationController pushViewController:c animated:YES];
    }
    else if(indexPath.row==3)
    {
        PersonalChangePasswordViewController* c=[[UIStoryboard storyboardWithName:@"Personal" bundle:nil]instantiateViewControllerWithIdentifier:@"PersonalChangePasswordViewController"];
        [self.navigationController pushViewController:c animated:YES];
    }
    else if(indexPath.row==5)
    {
        [PersonalHttpTool logOutUserToken:[UserModel getUser].access_token];
        [UserModel deleteUser];
        [self.navigationController popViewControllerAnimated:YES];
    }
}

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info
{
    UIImage* pic=[info valueForKey:UIImagePickerControllerEditedImage];
    [MBProgressHUD showProgressMessage:@"正在上传图片"];
    [PersonalHttpTool uploadAvatar:pic token:[[UserModel getUser]access_token] success:^(NSString *imageUrl) {
        [MBProgressHUD hide];
        if(imageUrl.length>0)
        {
            UserModel* us=[UserModel getUser];
            us.avatar=imageUrl;
            [UserModel saveUser:us];
            [self reloadUserInfo];
        }
        else
        {
            NSLog(@"fail image");
            [MBProgressHUD showErrorMessage:@"上传失败"];
        }
    }];
    
    [picker dismissViewControllerAnimated:YES completion:nil];
}

@end
