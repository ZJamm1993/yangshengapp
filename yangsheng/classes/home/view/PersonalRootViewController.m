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

@interface PersonalRootViewController ()<PersonalHeaderCellDelegate>
{
    NSArray* imgsArray;
    NSArray* titsArray;
}
@end

@implementation PersonalRootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    imgsArray=@[@[@"header"],@[@"my_Shop"],@[@"my_distributor"],@[@"my_curriculum"],@[@"my_account",@"my_Invitation",@"my_Service"]];
    titsArray=@[@[@"header"],@[@"申请开店"],@[@"我的预约"],@[@"收藏课程"],@[@"账户设置",@"邀请好友",@"联系客服"]];
    
    [self.refreshControl removeFromSuperview];
    [self.tableView setTableFooterView:[[UIView alloc]init]];
    
    self.tableView.contentInset=UIEdgeInsetsMake(-20,0, 0, 0);
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:animated];
    
    [[UIApplication sharedApplication]setStatusBarStyle:UIStatusBarStyleLightContent];
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
        PersonalLoginViewController* lo=[[UIStoryboard storyboardWithName:@"Personal" bundle:nil]instantiateViewControllerWithIdentifier:@"PersonalLoginViewController"];
        [self.navigationController pushViewController:lo animated:YES];
    }
}

@end
