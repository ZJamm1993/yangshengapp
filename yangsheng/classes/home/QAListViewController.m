//
//  QAListViewController.m
//  yangsheng
//
//  Created by Macx on 17/7/9.
//  Copyright © 2017年 jam. All rights reserved.
//

#import "QAListViewController.h"
#import "HomeQACell.h"
#import "HomeHttpTool.h"

@interface QAListViewController ()
{
     
}
@end

@implementation QAListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title=@"问答Q&A";
    
    [self loadMore];
    // Do any additional setup after loading the view.
}

-(void)refresh
{
    //
    [HomeHttpTool getAdversType:9 success:^(NSArray *datasource) {
        self.advsArray=[NSMutableArray arrayWithArray:datasource];
        NSMutableArray* pics=[NSMutableArray array];
        for (BaseModel* ad in self.advsArray) {
            NSString* th=ad.thumb;
            NSString* fu=[ZZUrlTool fullUrlWithTail:th];
            [pics addObject:fu];
        }
        [self setAdvertiseHeaderViewWithPicturesUrls:pics];
    } isCache:NO];
    
    [HomeHttpTool getQAListPage:1 success:^(NSArray *datasource) {
        
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
    //
    [HomeHttpTool getAdversType:9 success:^(NSArray *datasource) {
        self.advsArray=[NSMutableArray arrayWithArray:datasource];
        NSMutableArray* pics=[NSMutableArray array];
        for (BaseModel* ad in self.advsArray) {
            NSString* th=ad.thumb;
            NSString* fu=[ZZUrlTool fullUrlWithTail:th];
            [pics addObject:fu];
        }
        [self setAdvertiseHeaderViewWithPicturesUrls:pics];
    } isCache:YES];
    
    [HomeHttpTool getQAListPage:1+self.currentPage success:^(NSArray *datasource) {
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
    HomeQACell* ce=[tableView dequeueReusableCellWithIdentifier:@"HomeQACell" forIndexPath:indexPath];
    BaseModel* qa=[ self.dataSource objectAtIndex:indexPath.row];
    ce.qaTitleLabel.text=[NSString stringWithFormat:@"# %@",qa.post_title];
    ce.qaContentLabel.text=qa.post_excerpt;
    ce.qaReadLabel.text=[NSString stringWithFormat:@"%ld阅览",(long)qa.post_hits];
    return ce;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    BaseModel* m=[ self.dataSource objectAtIndex:indexPath.row];
    BaseWebViewController* we=[[BaseWebViewController alloc]initWithUrl:[html_QA_detail urlWithMainUrl]];
    we.idd=m.idd.integerValue;
    we.title=@"详情";
    [self.navigationController pushViewController:we animated:YES];
    
}

@end
