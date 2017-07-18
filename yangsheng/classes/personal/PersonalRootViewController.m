//
//  PersonalRootViewController.m
//  yangsheng
//
//  Created by Macx on 17/7/10.
//  Copyright © 2017年 jam. All rights reserved.
//

#import "PersonalRootViewController.h"
#import "PersonalHeaderCell.h"
#import "PersonalLoginViewController.h"
#import "PersonalAccountSettingViewController.h"
#import "StoreApplyProtocolViewController.h"
#import "StoreApplyResultViewController.h"
#import "StoreAllAppoinmentListViewController.h"
#import "ClassroomCollectionViewController.h"
#import "CodeScanerViewController.h"

#import "StoreHttpTool.h"
#import "UserModel.h"

@interface PersonalRootViewController ()<PersonalHeaderCellDelegate>
{
    NSArray* imgsArray;
    NSArray* titsArray;
    
    UserModel* currentUser;
}
@end

@implementation PersonalRootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    imgsArray=@[@[@"header"],@[@"my_Shop"],@[@"my_distributor"],@[@"my_curriculum"],@[@"my_account",@"my_Service"]];
    titsArray=@[@[@"header"],@[@"申请开店"],@[@"我的预约"],@[@"收藏课程"],@[@"账户设置",@"联系客服"]];
    
    [self.refreshControl removeFromSuperview];
    [self.tableView setTableFooterView:[[UIView alloc]init]];
    
    self.tableView.contentInset=UIEdgeInsetsMake(-20,0, 0, 0);
    
//    [self didLogin:nil];
    
//    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(didLogin:) name:LoginUserSuccessNotification object:nil];
}

//-(void)didLogin:(NSNotification*)noti
//{
//    if (noti) {
//        NSLog(@"%@",noti);
//    }
//    [self refreshUser];
//}

-(void)refreshUser
{
    currentUser=[UserModel getUser];
    self.isLoged=currentUser!=nil;
    [self tableViewReloadData];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:animated];
    
    [[UIApplication sharedApplication]setStatusBarStyle:UIStatusBarStyleLightContent];
    
    [self refreshUser];
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:animated];
    
    [[UIApplication sharedApplication]setStatusBarStyle:UIStatusBarStyleDefault];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return imgsArray.count;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSArray* arr=[imgsArray objectAtIndex:section];
    return arr.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if(section!=0)
    {
        return 8;
    }
    return 0.00001;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.00001;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==0) {
        PersonalHeaderCell* cell=[tableView dequeueReusableCellWithIdentifier:@"PersonalHeaderCell" forIndexPath:indexPath];
        cell.isLoged=self.isLoged;
        cell.delegate=self;
        cell.username.text=currentUser.user_nicename;
        cell.userid.text=[NSString stringWithFormat:@"ID:%@",currentUser.mobile];
        [cell.headImage sd_setImageWithURL:[currentUser.avatar urlWithMainUrl] placeholderImage:[UIImage imageNamed:@"user_tx"]];
        return cell;
    }
    else
    {
        UITableViewCell* cell=[tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
        NSString* imgname=[[imgsArray objectAtIndex:indexPath.section]objectAtIndex:indexPath.row];
        NSString* title=[[titsArray objectAtIndex:indexPath.section]objectAtIndex:indexPath.row];
        cell.imageView.image=[UIImage imageNamed:imgname];
        cell.textLabel.text=title;
        return cell;
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.section==0&&indexPath.row==0&&self.isLoged==NO) {
        [self goLoginPage];
    }
    if (indexPath.section==1) {
        if (currentUser.access_token.length==0) {
            // did not log in
            [MBProgressHUD showErrorMessage:@"请登录后再操作"];
            [self goLoginPage];
        }
        else
        {
            [MBProgressHUD showProgressMessage:@"正在查询信息"];
            [StoreHttpTool getApplyResultWithToken:currentUser.access_token success:^(StoreApplyModel *applyModel) {
                [MBProgressHUD hide];
                if (applyModel.name.length>0) {
                    //yes
                    StoreApplyResultViewController* pro=[[UIStoryboard storyboardWithName:@"Store" bundle:nil]instantiateViewControllerWithIdentifier:@"StoreApplyResultViewController"];
                    pro.applyResult=applyModel;
                    [self.navigationController pushViewController:pro animated:YES];
                }
                else
                {
                    StoreApplyProtocolViewController* pro=[[UIStoryboard storyboardWithName:@"Store" bundle:nil]instantiateViewControllerWithIdentifier:@"StoreApplyProtocolViewController"];
                    
                    [self.navigationController pushViewController:pro animated:YES];
                }
            }];
        }

    }
    else if(indexPath.section==2)
    {
        if (!self.isLoged) {
            PersonalAccountSettingViewController* acc=[[UIStoryboard storyboardWithName:@"Personal" bundle:nil]instantiateViewControllerWithIdentifier:@"PersonalAccountSettingViewController"];
            [self.navigationController pushViewController:acc animated:YES];
        }
        else
        {
            StoreAllAppoinmentListViewController* app=[[UIStoryboard storyboardWithName:@"Store" bundle:nil]instantiateViewControllerWithIdentifier:@"StoreAllAppoinmentListViewController"];
            [self.navigationController pushViewController:app animated:YES];
        }
    }
    else if (indexPath.section==3)
    {
        if (!self.isLoged) {
            PersonalAccountSettingViewController* acc=[[UIStoryboard storyboardWithName:@"Personal" bundle:nil]instantiateViewControllerWithIdentifier:@"PersonalAccountSettingViewController"];
            [self.navigationController pushViewController:acc animated:YES];
        }
        else
        {
            ClassroomCollectionViewController* app=[[UIStoryboard storyboardWithName:@"Classroom" bundle:nil]instantiateViewControllerWithIdentifier:@"ClassroomCollectionViewController"];
            [self.navigationController pushViewController:app animated:YES];
        }
    }
    else if(indexPath.section==4)
    {
        if (indexPath.row==0) {
            if (self.isLoged) {
                PersonalAccountSettingViewController* acc=[[UIStoryboard storyboardWithName:@"Personal" bundle:nil]instantiateViewControllerWithIdentifier:@"PersonalAccountSettingViewController"];
                [self.navigationController pushViewController:acc animated:YES];
            }
            else
            {
                [self goLoginPage];
            }
        }
        else if(indexPath.row==1)
        {
            UIAlertController* alert=[UIAlertController alertControllerWithTitle:@"是否打开QQ联系客服" message:nil preferredStyle:UIAlertControllerStyleAlert];
            [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil]];
            [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                [[UIApplication sharedApplication]openURL:QQURL];
            }]];
            [self presentViewController:alert animated:YES completion:nil];
        }
    }
}

-(void)goLoginPage
{
    PersonalLoginViewController* lo=[[UIStoryboard storyboardWithName:@"Personal" bundle:nil]instantiateViewControllerWithIdentifier:@"PersonalLoginViewController"];
    [self.navigationController pushViewController:lo animated:YES];
    
}

-(void)personalHeaderCell:(PersonalHeaderCell *)cell didSelectedScanButton:(UIButton *)btn
{
    
    CodeScanerViewController* scaner=[[CodeScanerViewController alloc]init];
    [self.navigationController pushViewController:scaner animated:YES];
}

-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
//#warning testing login
//    if (scrollView.contentOffset.y<-100) {
//        [UserModel deleteUser];
//        [self refreshUser];
//    }
}

@end
