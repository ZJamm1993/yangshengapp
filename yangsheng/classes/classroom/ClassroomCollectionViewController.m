//
//  ClassroomCollectionViewController.m
//  yangsheng
//
//  Created by Macx on 17/7/18.
//  Copyright © 2017年 jam. All rights reserved.
//

#import "ClassroomCollectionViewController.h"
#import "ClassroomCollectionCell.h"
#import "ClassroomHttpTool.h"
#import "UserModel.h"

@interface ClassroomCollectionViewController ()<ClassroomCollectionCellDelegate>

@end

@implementation ClassroomCollectionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"收藏课程";
    // Do any additional setup after loading the view.
    [self refresh];
    // Do any additional setup after loading the view.
    
    //    [self setAdvertiseHeaderViewWithPicturesUrls:@[@"a",@"b"]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)refresh
{
    //
    
    [self stopRefreshAfterSeconds];
    [ClassroomHttpTool getClassroomCollectionListPage:1 size:self.pageSize token:[UserModel getUser].access_token success:^(NSArray *datasource) {
        [self.dataSource removeAllObjects];
        [self.dataSource addObjectsFromArray:datasource];
        [self.tableView reloadData];
        if (datasource.count>0) {
            self.currentPage=1;
            [self hideNothingLabel];
        }
        else
        {
            [self showNothingLabelText:@"没有收藏"];
        }
        //        [self setAdvertiseHeaderViewWithPicturesUrls:@[@"",@""]];
    } isCache:NO];
}

-(void)loadMore
{
    //
    
    [ClassroomHttpTool getClassroomCollectionListPage:1+self.currentPage size:self.pageSize token:[UserModel getUser].access_token success:^(NSArray *datasource) {
        [self.dataSource addObjectsFromArray:datasource];
        [self.tableView reloadData];
        if (datasource.count>0) {
            self.currentPage++;
        }
        self.shouldLoadMore=datasource.count>=self.pageSize;
        
    } isCache:NO];
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSource.count;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ClassroomCollectionCell* c=[tableView dequeueReusableCellWithIdentifier:@"ClassroomCollectionCell" forIndexPath:indexPath];
    BaseModel* ext=[self.dataSource objectAtIndex:indexPath.row];
    [c.image sd_setImageWithURL:[ext.thumb urlWithMainUrl]];
    [c.title setText:ext.title];
    [c.date setText:ext.createtime];
    c.delegate=self;
    c.index=indexPath.row;
    return c;
}

#pragma mark <UICollectionViewDelegate>

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    BaseModel* m=[self.dataSource objectAtIndex:indexPath.row];
    BaseWebViewController* we=[[BaseWebViewController alloc]initWithUrl:[html_course_detail urlWithMainUrl]];
    we.idd=m.idd.integerValue;
    we.type=@"c0";
    we.title=@"详情";
    [self.navigationController pushViewController:we animated:YES];
}


/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

-(void)collectionCell:(ClassroomCollectionCell *)cell didCancelAtIndex:(NSInteger)index
{
    BaseModel* m=[self.dataSource objectAtIndex:index];
    NSString* msg=[NSString stringWithFormat:@"是否取消收藏课程：%@？",m.title];
    UIAlertController* alert=[UIAlertController alertControllerWithTitle:@"是否取消收藏？" message:msg preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:@"不" style:UIAlertActionStyleCancel handler:nil]];
    [alert addAction:[UIAlertAction actionWithTitle:@"是" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        [MBProgressHUD showProgressMessage:@"正在取消"];
        [ClassroomHttpTool cancelCollectionId:m.idd token:[[UserModel getUser]access_token] success:^(BOOL applied, NSString *msg) {
            if (applied) {
                [MBProgressHUD showSuccessMessage:@"已取消"];
                
                [self.dataSource removeObjectAtIndex:index];
                [self.tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:[NSIndexPath indexPathForRow:index inSection:0]] withRowAnimation:UITableViewRowAnimationAutomatic];
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
