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

@interface StoreSearchViewController ()<UISearchBarDelegate>
{
    UISearchBar* _searchBar;
    NSString* searchingString;
}
@end

@implementation StoreSearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _searchBar=[[UISearchBar alloc]init];
    _searchBar.tintColor=pinkColor;
    _searchBar.placeholder=@"搜索门店";
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

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
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
        [self.tableView reloadData];
        [self stopRefreshAfterSeconds];
        if (self.dataSource.count>0) {
            self.currentPage=1;
        }
    } isCache:NO];
}

-(void)loadMore
{
    [StoreHttpTool searchStoreWithKeyword:searchingString page:1+self.currentPage success:^(NSArray *datasource) {
        [self.dataSource addObjectsFromArray:datasource];
        [self.tableView reloadData];
        if (datasource.count>0) {
            self.currentPage++;
        }
        self.shouldLoadMore=datasource.count>=20;
        
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


@end
