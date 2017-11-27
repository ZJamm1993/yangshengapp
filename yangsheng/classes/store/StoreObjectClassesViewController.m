//
//  StoreObjectClassesViewController.m
//  yangsheng
//
//  Created by bangju on 2017/11/27.
//  Copyright © 2017年 jam. All rights reserved.
//

#import "StoreObjectClassesViewController.h"
#import "StoreClassLongImageTableViewCell.h"
#import "StoreObjectClassItemsTableViewController.h"
#import "StoreHttpTool.h"

@interface StoreObjectClassesViewController ()

@end

@implementation StoreObjectClassesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"服务项目";
    [self refresh];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)refresh
{
    [StoreHttpTool getStoreClassItemsSuccess:^(NSArray *datasource) {
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
    StoreClassLongImageTableViewCell* c=[tableView dequeueReusableCellWithIdentifier:@"StoreClassLongImageTableViewCell" forIndexPath:indexPath];
    //    c.backgroundColor=[UIColor redColor];
    StoreItem* i=[self.dataSource objectAtIndex:indexPath.row];
    [c.image sd_setImageWithURL:[i.thumb urlWithMainUrl]];
    c.backgroundColor=[UIColor clearColor];
    return c;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    StoreObjectClassItemsTableViewController* items=[[UIStoryboard storyboardWithName:@"Store" bundle:nil]instantiateViewControllerWithIdentifier:@"StoreObjectClassItemsTableViewController"];
    
    StoreItem* i=[self.dataSource objectAtIndex:indexPath.row];
    items.title=i.name;
    items.cid=i.idd;
    [self.navigationController pushViewController:items animated:YES];
}

@end
