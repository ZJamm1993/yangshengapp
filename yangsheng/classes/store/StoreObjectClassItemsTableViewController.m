//
//  StoreObjectClassItemsTableViewController.m
//  yangsheng
//
//  Created by bangju on 2017/11/27.
//  Copyright © 2017年 jam. All rights reserved.
//

#import "StoreObjectClassItemsTableViewController.h"
#import "StoreHttpTool.h"
#import "StoreClassItemTableViewCell.h"

@interface StoreObjectClassItemsTableViewController ()

@end

@implementation StoreObjectClassItemsTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self refresh];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)refresh
{
    [StoreHttpTool getStoreItemsCid:self.cid success:^(NSArray* datasource){
        if (datasource.count>0) {
            [self.dataSource removeAllObjects];
            [self.dataSource addObjectsFromArray:datasource];
            //            [self.collectionView reloadData];
            [self.tableView reloadData];
        }
    } isCache:NO];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataSource.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.001;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 10;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    StoreClassItemTableViewCell* c=[tableView dequeueReusableCellWithIdentifier:@"StoreClassItemTableViewCell" forIndexPath:indexPath];
    //    c.backgroundColor=[UIColor redColor];
    StoreItem* i=[self.dataSource objectAtIndex:indexPath.row];
    c.title.text=i.post_title;
    [c.image sd_setImageWithURL:[i.thumb urlWithMainUrl]];
    c.backgroundColor=[UIColor clearColor];
    return c;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    StoreItem* m=[ self.dataSource objectAtIndex:indexPath.row];
    BaseWebViewController* we=[[BaseWebViewController alloc]initWithUrl:[html_store_item_detail urlWithMainUrl]];
    we.idd=m.idd.integerValue;
    we.title=m.name;
    [self.navigationController pushViewController:we animated:YES];
}

@end
