//
//  TeamCompanyListViewController.m
//  yangsheng
//
//  Created by Macx on 17/7/14.
//  Copyright © 2017年 jam. All rights reserved.
//

#import "TeamCompanyListViewController.h"
#import "HomeHttpTool.h"
#import "TeamCollectionViewCell.h"

@interface TeamCompanyListViewController ()

@end

@implementation TeamCompanyListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"公司团队";
    
    [self loadMore];
    // Do any additional setup after loading the view.
    
//    [self setAdvertiseHeaderViewWithPicturesUrls:@[@"a",@"b"]];
    
    [self.collectionView registerNib:[UINib nibWithNibName:@"TeamCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"TeamCollectionViewCell"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)refresh
{
    [HomeHttpTool getTeamsPage:1 size:self.pageSize success:^(NSArray *datasource) {
        [self.dataSource removeAllObjects];
        [self.dataSource addObjectsFromArray:datasource];
        //        [self.collectionView reloadData];
        [self.collectionView reloadSections:[NSIndexSet indexSetWithIndexesInRange:NSMakeRange(0, self.collectionView.numberOfSections)]];
        [self stopRefreshAfterSeconds];
        if (datasource.count>0) {
            self.currentPage=1;
        }
    } isCache:NO];
}

-(void)loadMore
{
    
    [HomeHttpTool getTeamsPage:1+self.currentPage size:self.pageSize  success:^(NSArray *datasource) {
        [self.dataSource addObjectsFromArray:datasource];
        //        [self.collectionView reloadData];
        [self.collectionView reloadSections:[NSIndexSet indexSetWithIndexesInRange:NSMakeRange(0, self.collectionView.numberOfSections)]];
        if (datasource.count>0) {
            self.currentPage++;
        }
//        self.shouldLoadMore=datasource.count>=self.pageSize;
        
    } isCache:YES];
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
    TeamCollectionViewCell* cell=[collectionView dequeueReusableCellWithReuseIdentifier:@"TeamCollectionViewCell" forIndexPath:indexPath];
    BaseModel* m=[self.dataSource objectAtIndex:indexPath.row];
    [cell.image sd_setImageWithURL:[m.thumb urlWithMainUrl]];
    cell.title.text=m.post_title;
    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    [collectionView deselectItemAtIndexPath:indexPath animated:YES];
    BaseWebViewController* we=[[BaseWebViewController alloc]initWithUrl:[html_team_detail urlWithMainUrl]];
    BaseModel* m=[self.dataSource objectAtIndex:indexPath.row];
    we.idd=m.idd.integerValue;
    we.title=@"公司团队";
    [self.navigationController pushViewController:we animated:YES];
}

-(UICollectionViewLayout*)collectionViewLayout
{
    UICollectionViewFlowLayout* flow=[[UICollectionViewFlowLayout alloc]init];
    
    CGFloat sw=[[UIScreen mainScreen]bounds].size.width;
    CGFloat m=5;
    CGFloat w=(sw-4*m)/2;
    CGFloat h=w+40;
    
    flow.itemSize=CGSizeMake(w, h);
    flow.minimumLineSpacing=0;
    flow.minimumInteritemSpacing=m;
    flow.sectionInset=UIEdgeInsetsMake(m,m,m,m);
    
    return flow;
}

@end
