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
#import "ProductCodeScanViewController.h"
#import "DealersManagerViewController.h"

#import "StoreHttpTool.h"
#import "UserModel.h"

@interface PersonalRootViewController ()<PersonalHeaderCellDelegate>
{
    NSArray* imgsArray;
    NSArray* titsArray;
    UIImageView* headerBgImage;
    UserModel* currentUser;
}
@end

@implementation PersonalRootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    imgsArray=@[@[@"header"],@[@"my_Shop"],@[@"my_distributor"],@[@"my_curriculum"],@[@"my_fwcx"],@[@"my_account",@"my_Service"],@[@"my_dealer"]];
    titsArray=@[@[@"header"],@[@"申请开店"],@[@"我的预约"],@[@"收藏课程"],@[@"防伪查询"],@[@"账户设置",@"联系客服"],@[@"经销商入口"]];
    
    [self.refreshControl removeFromSuperview];
    [self.tableView setTableFooterView:[[UIView alloc]init]];
    
    self.tableView.contentInset=UIEdgeInsetsMake(-21,0, 0, 0);
    
//    [self didLogin:nil];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(refreshUser) name:LoginUserSuccessNotification object:nil];
    
    NSString* version=[[[NSBundle mainBundle]infoDictionary]valueForKey:@"CFBundleShortVersionString"];
    version=[NSString stringWithFormat:@"v %@",version];
    
    UILabel* verLab=[[UILabel alloc]initWithFrame:CGRectMake(0, -100, self.view.frame.size.width, 20)];
    verLab.text=version;
    verLab.textAlignment=NSTextAlignmentCenter;
    verLab.textColor=[UIColor colorWithWhite:1 alpha:0.5];
    [self.tableView addSubview:verLab];
    
    headerBgImage=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, [self tableView:self.tableView heightForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]])];
    headerBgImage.image=[UIImage imageNamed:@"my_bg"];
    [self.tableView insertSubview:headerBgImage atIndex:0];
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

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==0) {
        return 159;
    }
    else if (indexPath.section==tableView.numberOfSections-1) {
        if (currentUser.type!=UserTypeDealer) {
            return 0;
        }
    }
    return UITableViewAutomaticDimension;
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
        cell.userid.text=[NSString stringWithFormat:@"ID:%@",currentUser.idd];
        [cell.headImage sd_setImageWithURL:[currentUser.avatar urlWithMainUrl] placeholderImage:[UIImage imageNamed:@"user_tx"]];
        return cell;
    }
    else
    {
//        UITableViewCell* cell=[tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
        UITableViewCell* cell=[tableView dequeueReusableCellWithIdentifier:@"ccc"];
        if (cell==nil) {
            cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"ccc"];
            
            cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
            
            cell.textLabel.textColor=[UIColor grayColor];
            cell.textLabel.font=[UIFont systemFontOfSize:15];
            
            UIView* sha=[[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 1/[[UIScreen mainScreen]scale])];
            sha.backgroundColor=[UIColor groupTableViewBackgroundColor];
            [cell.contentView addSubview:sha];
            
            cell.clipsToBounds=YES;
        }
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
    
    if (indexPath.section==0&&indexPath.row==0) {
        if(self.isLoged==NO)
        {
            [self goLoginPage];
        }
        else
        {
            PersonalAccountSettingViewController* acc=[[UIStoryboard storyboardWithName:@"Personal" bundle:nil]instantiateViewControllerWithIdentifier:@"PersonalAccountSettingViewController"];
            [self.navigationController pushViewController:acc animated:YES];
        }
    }
    if (indexPath.section==1) {
        if (!self.isLoged) {
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
            [self goLoginPage];
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
            [self goLoginPage];
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
            ProductCodeScanViewController* scaner=[[ProductCodeScanViewController alloc]init];
            [self.navigationController pushViewController:scaner animated:YES];
        }
    }
    else if(indexPath.section==5)
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
            UIViewController* vc=[[UIStoryboard storyboardWithName:@"Personal" bundle:nil]instantiateViewControllerWithIdentifier:@"CustomerServiceViewController"];
            [self.navigationController pushViewController:vc animated:YES];
        }
    }
    else if(indexPath.section==6)
    {
        if (indexPath.row==0) {
            [self.navigationController pushViewController:[[DealersManagerViewController alloc]init] animated:YES];
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
    
    ProductCodeScanViewController* scaner=[[ProductCodeScanViewController alloc]init];
    [self.navigationController pushViewController:scaner animated:YES];
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (scrollView==self.tableView) {
        CGFloat off=scrollView.contentOffset.y-scrollView.contentInset.top-1;
        CGFloat cellHeight=[self tableView:self.tableView heightForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
        CGRect oldFra=headerBgImage.frame;
        if (off<0) {
            oldFra.size.height=cellHeight-off;
            oldFra.origin.y=off;
        }
        else
        {
            oldFra.origin.y=0;
            oldFra.size.height=cellHeight;
        }
        headerBgImage.frame=oldFra;
    }
}

@end
