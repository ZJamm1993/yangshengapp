//
//  TeamMonthStarViewController.m
//  yangsheng
//
//  Created by Macx on 17/7/14.
//  Copyright © 2017年 jam. All rights reserved.
//

#import "TeamMonthStarViewController.h"
#import "HomeHttpTool.h"
#import "HomeMonthStarCell.h"
@interface TeamMonthStarViewController ()

@end

@implementation TeamMonthStarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title=@"每月之星";
    [self loadMore];
    [self showLoadMoreView];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)refresh
{
    [HomeHttpTool getMonthStarPage:1 size:self.pageSize success:^(NSArray *datasource) {
        [self.dataSource removeAllObjects];
        [self.dataSource addObjectsFromArray:datasource];
        [self tableViewReloadData];
        [self stopRefreshAfterSeconds];
        if (datasource.count>0) {
            self.currentPage=1;
        }
    } isCache:NO];
}

-(void)loadMore
{
    
    [HomeHttpTool getMonthStarPage:1+self.currentPage size:self.pageSize  success:^(NSArray *datasource) {
        [self.dataSource addObjectsFromArray:datasource];
        [self tableViewReloadData];
        if (datasource.count>0) {
            self.currentPage++;
        }
//        self.shouldLoadMore=datasource.count>=self.pageSize;
        
    } isCache:YES];
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
    HomeMonthStarCell* c=[tableView dequeueReusableCellWithIdentifier:@"HomeMonthStarCell" forIndexPath:indexPath];
    BaseModel* sta=[self.dataSource objectAtIndex:indexPath.row];
    [c.starImageView sd_setImageWithURL:[sta.thumb urlWithMainUrl]];
    c.starTitle.text=sta.post_title;
    c.starContent.text=sta.ios_content;
    return c;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    BaseModel* m=[self.dataSource objectAtIndex:indexPath.row];
    BaseWebViewController* we=[[BaseWebViewController alloc]initWithUrl:[html_star_detail urlWithMainUrl]];
    we.idd=m.idd.integerValue;
    we.title=@"每月之星";
    [self.navigationController pushViewController:we animated:YES];
}

@end
