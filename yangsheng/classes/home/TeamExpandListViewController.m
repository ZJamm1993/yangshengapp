//
//  TeamExpandListViewController.m
//  yangsheng
//
//  Created by Macx on 17/7/14.
//  Copyright © 2017年 jam. All rights reserved.
//

#import "TeamExpandListViewController.h"
#import "HomeTeamExtCell.h"
#import "HomeHttpTool.h"

@interface TeamExpandListViewController ()

@end

@implementation TeamExpandListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"团队拓展";
    // Do any additional setup after loading the view.
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
    [HomeHttpTool getExpandPage:1 size:self.pageSize success:^(NSArray *datasource) {
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
    
    [HomeHttpTool getExpandPage:1+self.currentPage size:self.pageSize  success:^(NSArray *datasource) {
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
    HomeTeamExtCell* c=[tableView dequeueReusableCellWithIdentifier:@"HomeTeamExtCell" forIndexPath:indexPath];
    BaseModel* ext=[self.dataSource objectAtIndex:indexPath.row];
    [c.extBgImageView sd_setImageWithURL:[ext.thumb urlWithMainUrl]];
    c.extTitle.text=ext.post_title;
    c.extContent.text=ext.post_subtitle;
    c.extDateLabel.text=ext.post_modified;
    return c;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    BaseModel* m=[self.dataSource objectAtIndex:indexPath.row];
    BaseWebViewController* we=[[BaseWebViewController alloc]initWithUrl:[html_activity_detail urlWithMainUrl]];
    we.idd=m.idd.integerValue;
    we.title=@"团队拓展";
    [self.navigationController pushViewController:we animated:YES];
}

@end
