//
//  NeewsListViewController.m
//  yangsheng
//
//  Created by Macx on 17/7/10.
//  Copyright © 2017年 jam. All rights reserved.
//

#import "NeewsListViewController.h"
#import "HomeHttpTool.h"
#import "NeewsCell.h"
#import "BaseWebViewController.h"

@interface NeewsListViewController ()
{
    NSArray* data;
}
@end

@implementation NeewsListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title=@"新闻中心";
    
    [self loadMore];
    [self setNothingFooterView];
    // Do any additional setup after loading the view.
}

-(void)refresh
{
    [HomeHttpTool getNeewsListPage:1 success:^(NSArray *datasource) {
        data=datasource;
        [self.tableView reloadData];
        [self stopRefreshAfterSeconds];
        if (data.count>0) {
            self.currentPage=1;
        }
    } isCache:NO];
}

-(void)loadMore
{
    
    [HomeHttpTool getNeewsListPage:++self.currentPage success:^(NSArray *datasource) {
        NSMutableArray* arr=[NSMutableArray array];
        [arr addObjectsFromArray:data?:[NSArray array]];
        [arr addObjectsFromArray:datasource];
        data=arr;
        [self.tableView reloadData];
        if (datasource.count>0) {
            self.currentPage++;
        }
        self.shouldLoadMore=datasource.count>=20;
        
    } isCache:YES];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return data.count;
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
    NeewsCell* ce=[tableView dequeueReusableCellWithIdentifier:@"NeewsCell" forIndexPath:indexPath];
    BaseModel* m=[data objectAtIndex:indexPath.row];
    [ce.neeImg sd_setImageWithURL:[m.thumb urlWithMainUrl]];
    ce.neeTitle.text=m.post_title;
    ce.neeCount.text=[NSString stringWithFormat:@"%d人正在学习",(int)m.post_hits];
    ce.neeDate.text=m.post_modified;
    return ce;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    BaseModel* m=[data objectAtIndex:indexPath.row];
    BaseWebViewController* we=[[BaseWebViewController alloc]initWithUrl:[html_news_detail urlWithMainUrl]];
    we.idd=m.idd.integerValue;
    we.title=@"新闻详情";
    [self.navigationController pushViewController:we animated:YES];
    
}

@end