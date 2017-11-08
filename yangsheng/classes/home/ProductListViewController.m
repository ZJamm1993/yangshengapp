//
//  ProductListViewController.m
//  yangsheng
//
//  Created by Macx on 17/7/9.
//  Copyright © 2017年 jam. All rights reserved.
//

#import "ProductListViewController.h"
#import "HomeHttpTool.h"
#import "ProductCell.h"

@interface ProductListViewController ()
{
     
}
@end

@implementation ProductListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self loadMore];
    [self showLoadMoreView];
    // Do any additional setup after loading the view.
}

-(void)refresh
{
    [HomeHttpTool getProductListType:[self.idd integerValue] page:1 success:^(NSArray *datasource) {
        self.dataSource=[NSMutableArray arrayWithArray:datasource];
        [self tableViewReloadData];
        [self stopRefreshAfterSeconds];
        if ( self.dataSource.count>0) {
            self.currentPage=1;
        }
    } isCache:NO];
}

-(void)loadMore
{
    
    [HomeHttpTool getProductListType:[self.idd integerValue] page:1+self.currentPage success:^(NSArray *datasource) {
        [self.dataSource addObjectsFromArray:datasource];
        [self tableViewReloadData];
        if (datasource.count>0) {
            self.currentPage++;
        }
        self.shouldLoadMore=datasource.count>=self.pageSize;
        
    } isCache:YES];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return  self.dataSource.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.0001;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ProductCell* ce=[tableView dequeueReusableCellWithIdentifier:@"ProductCell" forIndexPath:indexPath];
    BaseModel* m=[ self.dataSource objectAtIndex:indexPath.row];
    [ce.proImageView sd_setImageWithURL:[m.thumb urlWithMainUrl]];
    [ce.proTitle setText:m.post_title];
    [ce.proContent setText:m.post_subtitle];
    return ce;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    BaseModel* m=[ self.dataSource objectAtIndex:indexPath.row];
    BaseWebViewController* we=[[BaseWebViewController alloc]initWithUrl:[html_product_detail urlWithMainUrl]];
    we.idd=m.idd.integerValue;
    we.title=@"产品详情";
    [self.navigationController pushViewController:we animated:YES];
    
}

@end
