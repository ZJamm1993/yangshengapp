//
//  StoreRootViewController.m
//  yangsheng
//
//  Created by Macx on 17/7/13.
//  Copyright © 2017年 jam. All rights reserved.
//

#import "StoreRootViewController.h"
#import "StoreSearchViewController.h"
#import "StoreAllViewController.h"

#import "StoreHttpTool.h"
#import "HomeHttpTool.h"

#import "ButtonsCell.h"
#import "StoreSmallCell.h"

@interface StoreRootViewController ()<ButtonsCellDelegate>
{
    NSArray* advsArray;
    StoreSearchViewController* searchVc;
}
@end

@implementation StoreRootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.tableView registerClass:[ButtonsCell class] forCellReuseIdentifier:@"TopButtonsCell"];
    // Do any additional setup after loading the view.
    [self refreshWithCache:YES];
    
    self.title=@"门店";
    
    UIBarButtonItem* sea=[[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemSearch target:self action:@selector(goToSearch)];
    self.navigationItem.rightBarButtonItem=sea;
    
//    self.navigationItem.backBarButtonItem=nil;
}

-(void)goToSearch
{
    if (searchVc==nil) {
        searchVc=[[UIStoryboard storyboardWithName:@"Store" bundle:nil]instantiateViewControllerWithIdentifier:@"StoreSearchViewController"];
    }
    [self.navigationController pushViewController:searchVc animated:YES];
}

-(void)refresh
{
    [self refreshWithCache:NO];
}

-(void)refreshWithCache:(BOOL)cache
{
    [HomeHttpTool getAdversType:2 success:^(NSArray *datasource) {
        advsArray=[NSMutableArray arrayWithArray:datasource];
        NSMutableArray* pics=[NSMutableArray array];
        for (BaseModel* ad in advsArray) {
            NSString* th=ad.thumb;
            NSString* fu=[ZZUrlTool fullUrlWithTail:th];
            [pics addObject:fu];
        }
        [self setAdvertiseHeaderViewWithPicturesUrls:pics];
    } isCache:cache];
    
    [StoreHttpTool getNeighbourStoreListPage:1 lng:@"" lat:@"" mult:5 success:^(NSArray *datasource) {
        [self.dataSource removeAllObjects];
        [self.dataSource addObjectsFromArray:datasource];
        [self.tableView reloadData];
        [self stopRefreshAfterSeconds];
        //        if (self.dataSource.count>0) {
        //            self.currentPage=1;
        //        }
    } isCache:cache];
}

//-(void)loadMore
//{
//    [StoreHttpTool getNeighbourStoreListPage:1+self.currentPage lng:@"" lat:@"" mult:5 success:^(NSArray *datasource) {
//        [self.dataSource addObjectsFromArray:datasource];
//        [self.tableView reloadData];
//        if (datasource.count>0) {
//            self.currentPage++;
//        }
//        self.shouldLoadMore=datasource.count>=20;
//        
//    } isCache:YES];
//}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==0) {
        return 100;
    }
    return UITableViewAutomaticDimension;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section==0) {
        return 1;
    }
    else if(section==1)
    {
        return self.dataSource.count+1;
    }
    return 0;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==0) {
        ButtonsCell* c=[tableView dequeueReusableCellWithIdentifier:@"TopButtonsCell" forIndexPath:indexPath];
        c.delegate=self;
        c.buttonsTitles=[NSArray arrayWithObjects:@"服务项目",@"服务预约",@"申请开店",@"门店地图", nil];
        c.buttonsImageNames=[NSArray arrayWithObjects:@"store_project",@"store_reservation",@"store_Shop",@"store_map", nil];
        return c;
    }
    else if(indexPath.section==1)
    {
        if (indexPath.row==0) {
            UITableViewCell* c=[tableView dequeueReusableCellWithIdentifier:@"StoreHeaderCell" forIndexPath:indexPath];
            return c;
        }
        else
        {
            StoreSmallCell* c=[tableView dequeueReusableCellWithIdentifier:@"StoreSmallCell" forIndexPath:indexPath];
            StoreModel* m=[self.dataSource objectAtIndex:indexPath.row-1];
            c.storeAddress.text=m.store_address;
            c.storeContact.text=[NSString stringWithFormat:@"%@/%@",m.store_author,m.store_tel];
            c.storeName.text=m.store_title;
            [c.storeImage sd_setImageWithURL:[m.thumb urlWithMainUrl]];
            return c;
        }
    }
    else
    {
        return nil;
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.section==1) {
        if (indexPath.row==0) {
            StoreAllViewController* all=[[UIStoryboard storyboardWithName:@"Store" bundle:nil]instantiateViewControllerWithIdentifier:@"StoreAllViewController"];
            [self.navigationController pushViewController:all animated:YES];
        }
    }
}

@end
