//
//  StoreAllAppoinmentListViewController.m
//  yangsheng
//
//  Created by Macx on 17/7/18.
//  Copyright © 2017年 jam. All rights reserved.
//

#import "StoreAllAppoinmentListViewController.h"
#import "StoreHttpTool.h"
#import "StoreSmallCell.h"
#import "StoreAppointmentFooterCell.h"
#import "StoreAppointmentHeaderCell.h"
#import "StoreDetailViewController.h"
#import "UserModel.h"

@interface StoreAllAppoinmentListViewController ()<StoreAppointmentHeaderCellDelegate>

@end

@implementation StoreAllAppoinmentListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title=@"我的预约";
    [self refresh];
    [self showLoadMoreView];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)refresh
{
    [StoreHttpTool getAllAppointmentListPage:1 token:[[UserModel getUser]access_token] success:^(NSArray *datasource) {
        
        [self.dataSource removeAllObjects];
        [self.dataSource addObjectsFromArray:datasource];
        [self tableViewReloadData];
        [self stopRefreshAfterSeconds];
        if (self.dataSource.count>0) {
            self.currentPage=1;
            [self hideNothingLabel];
        }
        else
        {
            [self showNothingLabelText:@"没有预约"];
        }
    } isCache:NO];
}

-(void)loadMore
{
    [StoreHttpTool getAllAppointmentListPage:1+self.currentPage token:[[UserModel getUser]access_token] success:^(NSArray *datasource) {
        [self.dataSource addObjectsFromArray:datasource];
        [self tableViewReloadData];
        if (datasource.count>0) {
            self.currentPage++;
        }
        //        self.shouldLoadMore=datasource.count>=self.pageSize;
        
    } isCache:NO];
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 8;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 6;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.dataSource.count;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    StoreModel* m=[self.dataSource objectAtIndex:section];
    if (m.item_name.length>0) {
        return 3;
    }
    return 2;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    StoreModel* m=[self.dataSource objectAtIndex:indexPath.section];
    
    if (indexPath.row==0) {
        StoreAppointmentHeaderCell* h=[tableView dequeueReusableCellWithIdentifier:@"StoreAppointmentHeaderCell" forIndexPath:indexPath];
        h.finished=m.finish;
        h.index=indexPath.section;
        h.delegate=self;
        h.appointTimeLabel.text=[NSString stringWithFormat:@"时间：%@",m.date];
        return h;
    }
    else if(indexPath.row==1)
    {
        StoreSmallCell* c=[tableView dequeueReusableCellWithIdentifier:@"StoreSmallCell" forIndexPath:indexPath];
        c.storeAddress.text=m.store_address;
        c.storeContact.text=[NSString stringWithFormat:@"%@/%@",m.store_author,m.store_tel];
        c.storeName.text=m.store_title;
        [c.storeImage sd_setImageWithURL:[m.thumb urlWithMainUrl]];
        return c;
    }
    else if(indexPath.row==2)
    {
        StoreAppointmentFooterCell* f=[tableView dequeueReusableCellWithIdentifier:@"StoreAppointmentFooterCell" forIndexPath:indexPath];
        f.appointmentItemName.text=[NSString stringWithFormat:@"预约服务：%@",m.item_name];
        return f;
    }
    return nil;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.row==1) {
        
        StoreModel* m=[self.dataSource objectAtIndex:indexPath.section];
        StoreDetailViewController* detail=[[UIStoryboard storyboardWithName:@"Store" bundle:nil]instantiateViewControllerWithIdentifier:@"StoreDetailViewController"];
        detail.detailStoreModel=m;
        [self.navigationController pushViewController:detail animated:YES];
    }
}

-(void)appointmentHeaderCell:(StoreAppointmentHeaderCell *)cell didCancelAtIndex:(NSInteger)index
{
//    NSLog(@"%@,%d",cell,index);
    
    StoreModel* m=[self.dataSource objectAtIndex:index];
    NSString* msg=[NSString stringWithFormat:@"是否取消店铺：%@\n时间：%@的预约？",m.store_title,m.date];
    UIAlertController* alert=[UIAlertController alertControllerWithTitle:@"是否取消预约？" message:msg preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:@"不" style:UIAlertActionStyleCancel handler:nil]];
    [alert addAction:[UIAlertAction actionWithTitle:@"是" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        [MBProgressHUD showProgressMessage:@"正在取消"];
        [StoreHttpTool cancelAppointmentId:m.app_id token:[[UserModel getUser]access_token] success:^(BOOL applied, NSString *msg) {
            if (applied) {
                [MBProgressHUD showSuccessMessage:@"已取消"];
                
                [self.dataSource removeObjectAtIndex:index];
                [self.tableView deleteSections:[NSIndexSet indexSetWithIndex:index] withRowAnimation:UITableViewRowAnimationAutomatic];
            }
            else
            {
                [MBProgressHUD showErrorMessage:msg];
            }
        }];
    }]];
    [self presentViewController:alert animated:YES completion:nil];
}

@end
