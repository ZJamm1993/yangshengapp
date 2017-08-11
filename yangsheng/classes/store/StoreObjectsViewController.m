//
//  StoreObjectsViewController.m
//  yangsheng
//
//  Created by jam on 17/7/13.
//  Copyright © 2017年 jam. All rights reserved.
//

#import "StoreObjectsViewController.h"
#import "ServiceObjectCell.h"
#import "StoreHttpTool.h"

@interface StoreObjectsViewController (){
}

@end

@implementation StoreObjectsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"服务项目";
    // Do any additional setup after loading the
    
    [self.collectionView registerNib:[UINib nibWithNibName:@"ServiceObjectCell" bundle:nil] forCellWithReuseIdentifier:@"ServiceObjectCell"];
    self.collectionView.backgroundColor=[UIColor colorWithWhite:0.9 alpha:1];
    [self firstLoad];
}

-(void)refresh
{
    [self stopRefreshAfterSeconds];
    [StoreHttpTool getStoreItemsSuccess:^(NSArray *datasource) {
        if (datasource.count>0) {
            [self.dataSource removeAllObjects];
            [self.dataSource addObjectsFromArray:datasource];
            //            [self.collectionView reloadData];
            [self.collectionView reloadSections:[NSIndexSet indexSetWithIndexesInRange:NSMakeRange(0, self.collectionView.numberOfSections)]];
        }
    } isCache:NO];
}

-(void)firstLoad
{
    [StoreHttpTool getStoreItemsSuccess:^(NSArray *datasource) {
        if (datasource.count>0) {
            [self.dataSource removeAllObjects];
            [self.dataSource addObjectsFromArray:datasource];
            //            [self.collectionView reloadData];
            [self.collectionView reloadSections:[NSIndexSet indexSetWithIndexesInRange:NSMakeRange(0, self.collectionView.numberOfSections)]];
        }
    } isCache:YES];
}

-(UICollectionViewLayout*)collectionViewLayout
{
    UICollectionViewFlowLayout* flow=[[UICollectionViewFlowLayout alloc]init];
    
    CGFloat sw=[[UIScreen mainScreen]bounds].size.width;
    CGFloat m=0.5;
    CGFloat w=(sw-2*m)/3;
    CGFloat h=w;
    
    flow.itemSize=CGSizeMake(w, h);
    flow.minimumLineSpacing=m;
    flow.minimumInteritemSpacing=m;
    flow.sectionInset=UIEdgeInsetsMake(0,0,0,0);
    
    return flow;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.dataSource.count;
}

-(UICollectionViewCell*)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    ServiceObjectCell* c=[collectionView dequeueReusableCellWithReuseIdentifier:@"ServiceObjectCell" forIndexPath:indexPath];
//    c.backgroundColor=[UIColor redColor];
    StoreItem* i=[self.dataSource objectAtIndex:indexPath.row];
    [c.img sd_setImageWithURL:[i.thumb urlWithMainUrl]];
    c.title.text=i.name;
    return c;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    [collectionView deselectItemAtIndexPath:indexPath animated:YES];
    
    StoreItem* m=[ self.dataSource objectAtIndex:indexPath.row];
    BaseWebViewController* we=[[BaseWebViewController alloc]initWithUrl:[html_store_item_detail urlWithMainUrl]];
    we.idd=m.idd.integerValue;
    we.title=m.name;
    [self.navigationController pushViewController:we animated:YES];
}

@end
