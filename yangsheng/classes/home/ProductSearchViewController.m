//
//  ProductSearchViewController.m
//  yangsheng
//
//  Created by Macx on 17/7/17.
//  Copyright © 2017年 jam. All rights reserved.
//

#import "ProductSearchViewController.h"
#import "HomeHttpTool.h"
#import "ProductCell.h"

@interface ProductSearchViewController ()<UISearchBarDelegate>
{
    UISearchBar* _searchBar;
    NSString* searchingString;
}
@end

@implementation ProductSearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _searchBar=[[UISearchBar alloc]init];
    _searchBar.tintColor=pinkColor;
    _searchBar.placeholder=@"搜索产品";
    //#warning test searching
    //    _searchBar.text=@"品";
    _searchBar.delegate=self;
    _searchBar.backgroundColor=[UIColor clearColor];
    
    self.navigationItem.titleView=_searchBar;
    // Do any additional setup after loading the view.
    
    UIBarButtonItem* back=[[UIBarButtonItem alloc]initWithTitle:@"取消" style:UIBarButtonItemStylePlain target:self action:@selector(cancel)];
    self.navigationItem.rightBarButtonItem=back;
    
    self.navigationItem.leftBarButtonItem=[[UIBarButtonItem alloc]initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
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
    _searchBar.backgroundColor=[UIColor clearColor];
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
    [HomeHttpTool searchProductName:searchingString page:1 success:^(NSArray *datasource) {
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
    [HomeHttpTool searchProductName:searchingString page:1+self.currentPage success:^(NSArray *datasource) {
        [self.dataSource addObjectsFromArray:datasource];
        [self tableViewReloadData];
        if (datasource.count>0) {
            self.currentPage++;
        }
        //        self.shouldLoadMore=datasource.count>=self.pageSize;
        
    } isCache:YES];
}

-(void)searchBarCancelButtonClicked:(UISearchBar *)searchBar
{
    [searchBar resignFirstResponder];
}

-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    searchingString=searchBar.text;
    [self refresh];
    [searchBar resignFirstResponder];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataSource.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.0001;
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
