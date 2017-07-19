//
//  StoreSearchViewController.m
//  yangsheng
//
//  Created by Macx on 17/7/13.
//  Copyright © 2017年 jam. All rights reserved.
//

#import "StoreSearchViewController.h"
#import "StoreHttpTool.h"
#import "StoreSmallCell.h"
#import "StoreDetailViewController.h"
#import "ZZSearchBar.h"

@interface StoreSearchViewController ()<UITextFieldDelegate>
{
    ZZSearchBar* _searchBar;
    NSString* searchingString;
}
@end

@implementation StoreSearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _searchBar=[ZZSearchBar defaultBar];
    _searchBar.placeholder=@"请输入名称/地址/店长姓名";
//#warning test searching
//    _searchBar.text=@"品";
    _searchBar.delegate=self;
    
    self.navigationItem.titleView=_searchBar;
    // Do any additional setup after loading the view.
    
    UIBarButtonItem* back=[[UIBarButtonItem alloc]initWithTitle:@"取消" style:UIBarButtonItemStylePlain target:self action:@selector(cancel)];
    self.navigationItem.rightBarButtonItem=back;
    
    self.navigationItem.leftBarButtonItem=[[UIBarButtonItem alloc]initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
    self.tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
}

-(void)cancel
{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    if (self.dataSource.count==0) {
        [_searchBar becomeFirstResponder];
    }
}

-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [_searchBar resignFirstResponder];
}

-(void)refresh
{
//    if (!self.refreshControl.isRefreshing) {
//        [self.refreshControl beginRefreshing];
//    }
    if (searchingString.length==0) {
        [self stopRefreshAfterSeconds];
        return;
    }
    [StoreHttpTool searchStoreWithKeyword:searchingString page:1 success:^(NSArray *datasource) {
        [self.dataSource removeAllObjects];
        [self.dataSource addObjectsFromArray:datasource];
        [self stopRefreshAfterSeconds];
        if ( self.dataSource.count>0) {
            self.currentPage=1;
            [self hideNothingLabel];
            self.tableView.separatorStyle=UITableViewCellSeparatorStyleSingleLine;
        }
        else
        {
            [self showNothingLabelText:@"没有搜索到相关门店"];
            self.tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
        }
        [self tableViewReloadData];
    } isCache:NO];
}

-(void)loadMore
{
    [StoreHttpTool searchStoreWithKeyword:searchingString page:1+self.currentPage success:^(NSArray *datasource) {
        [self.dataSource addObjectsFromArray:datasource];
        [self tableViewReloadData];
        if (datasource.count>0) {
            self.currentPage++;
        }
//        self.shouldLoadMore=datasource.count>=self.pageSize;
        
    } isCache:YES];
}


-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    searchingString=textField.text;
    [self refresh];
    [textField resignFirstResponder];
    return YES;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataSource.count;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    StoreSmallCell* c=[tableView dequeueReusableCellWithIdentifier:@"StoreSmallCell" forIndexPath:indexPath];
    StoreModel* m=[self.dataSource objectAtIndex:indexPath.row];
    c.storeAddress.text=m.store_address;
    c.storeContact.text=[NSString stringWithFormat:@"%@/%@",m.store_author,m.store_tel];
    c.storeName.text=m.store_title;
    [c.storeImage sd_setImageWithURL:[m.thumb urlWithMainUrl]];
    return c;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    StoreModel* m=[self.dataSource objectAtIndex:indexPath.row];
    StoreDetailViewController* detail=[[UIStoryboard storyboardWithName:@"Store" bundle:nil]instantiateViewControllerWithIdentifier:@"StoreDetailViewController"];
    detail.detailStoreModel=m;
    [self.navigationController pushViewController:detail animated:YES];
}


@end
