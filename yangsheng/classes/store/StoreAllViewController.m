//
//  StoreAllViewController.m
//  yangsheng
//
//  Created by Macx on 17/7/13.
//  Copyright © 2017年 jam. All rights reserved.
//

#import "StoreAllViewController.h"
#import "StoreHttpTool.h"
#import "StoreSmallCell.h"

#import "StoreDetailViewController.h"

@interface StoreAllViewController ()

@end

@implementation StoreAllViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"附近所有门店";
    [self loadMore];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)refresh
{
    [StoreHttpTool getNeighbourStoreListPage:1 lng:self.lng lat:self.lat mult:5 cityCode:self.citycode success:^(NSArray *datasource) {
        [self.dataSource removeAllObjects];
        [self.dataSource addObjectsFromArray:datasource];
        [self tableViewReloadData];
        [self stopRefreshAfterSeconds];
        if (self.dataSource.count>0) {
            self.currentPage=1;
        }
    } isCache:NO];
}

-(void)loadMore
{
    [StoreHttpTool getNeighbourStoreListPage:1+self.currentPage lng:self.lng lat:self.lat mult:5 cityCode:self.citycode success:^(NSArray *datasource) {
        [self.dataSource addObjectsFromArray:datasource];
        [self tableViewReloadData];
        if (datasource.count>0) {
            self.currentPage++;
        }
//        self.shouldLoadMore=datasource.count>=self.pageSize;
        
    } isCache:YES];
}

//-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    if (indexPath.section==0) {
//        return 100;
//    }
//    return UITableViewAutomaticDimension;
//}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
//    if (section==0) {
//        return 1;
//    }
//    else if(section==1)
//    {
//        return self.dataSource.count+1;
//    }
//    return 0;
    return self.dataSource.count;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
//    if (indexPath.section==0) {
//        ButtonsCell* c=[tableView dequeueReusableCellWithIdentifier:@"TopButtonsCell" forIndexPath:indexPath];
//        c.delegate=self;
//        c.buttonsTitles=[NSArray arrayWithObjects:@"服务项目",@"服务预约",@"申请开店",@"门店地图", nil];
//        c.buttonsImageNames=[NSArray arrayWithObjects:@"store_project",@"store_reservation",@"store_Shop",@"store_map", nil];
//        return c;
//    }
//    else if(indexPath.section==1)
//    {
//        if (indexPath.row==0) {
//            UITableViewCell* c=[tableView dequeueReusableCellWithIdentifier:@"StoreHeaderCell" forIndexPath:indexPath];
//            return c;
//        }
//        else
//        {
            StoreSmallCell* c=[tableView dequeueReusableCellWithIdentifier:@"StoreSmallCell" forIndexPath:indexPath];
            StoreModel* m=[self.dataSource objectAtIndex:indexPath.row];
            c.storeAddress.text=m.store_address;
            c.storeContact.text=[NSString stringWithFormat:@"%@/%@",m.store_author,m.store_tel];
            c.storeName.text=m.store_title;
            [c.storeImage sd_setImageWithURL:[m.thumb urlWithMainUrl]];
            return c;
//        }
//    }
//    else
//    {
//        return nil;
//    }
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
