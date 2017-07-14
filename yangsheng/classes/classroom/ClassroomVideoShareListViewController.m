//
//  ClassroomVideoShareListViewController.m
//  yangsheng
//
//  Created by Macx on 17/7/13.
//  Copyright © 2017年 jam. All rights reserved.
//

#import "ClassroomVideoShareListViewController.h"
#import "ClassroomVideoShareCollectionCell.h"
#import "ClassroomHttpTool.h"
#import "HomeHttpTool.h"

@interface ClassroomVideoShareListViewController ()
{
    NSArray* advsArray;
}
@end

@implementation ClassroomVideoShareListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Register cell classes
    self.collectionView.collectionViewLayout=self.collectionViewLayout;
    [self.collectionView registerNib:[UINib nibWithNibName:@"ClassroomVideoShareCollectionCell" bundle:nil] forCellWithReuseIdentifier:@"ClassroomVideoShareCollectionCell"];
    
    [self loadMore];
    // Do any additional setup after loading the view.
    
    //    [self setAdvertiseHeaderViewWithPicturesUrls:@[@"a",@"b"]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)refresh
{
    //
    [HomeHttpTool getAdversType:5 success:^(NSArray *datasource) {
        advsArray=[NSMutableArray arrayWithArray:datasource];
        NSMutableArray* pics=[NSMutableArray array];
        for (BaseModel* ad in advsArray) {
            NSString* th=ad.thumb;
            NSString* fu=[ZZUrlTool fullUrlWithTail:th];
            [pics addObject:fu];
        }
        [self setAdvertiseHeaderViewWithPicturesUrls:pics];
    } isCache:NO];
    
    [ClassroomHttpTool getClassroomListType:4 page:1 size:self.pageSize success:^(NSArray *datasource) {
        [self.dataSource removeAllObjects];
        [self.dataSource addObjectsFromArray:datasource];
        [self.collectionView reloadData];
        [self stopRefreshAfterSeconds];
        if (datasource.count>0) {
            self.currentPage=1;
        }
//        [self setAdvertiseHeaderViewWithPicturesUrls:@[@"",@""]];
    } isCache:NO];
}

-(void)loadMore
{
    //
    [HomeHttpTool getAdversType:5 success:^(NSArray *datasource) {
        advsArray=[NSMutableArray arrayWithArray:datasource];
        NSMutableArray* pics=[NSMutableArray array];
        for (BaseModel* ad in advsArray) {
            NSString* th=ad.thumb;
            NSString* fu=[ZZUrlTool fullUrlWithTail:th];
            [pics addObject:fu];
        }
        [self setAdvertiseHeaderViewWithPicturesUrls:pics];
    } isCache:YES];
    
    [ClassroomHttpTool getClassroomListType:4 page:1+self.currentPage size:self.pageSize success:^(NSArray *datasource) {
        [self.dataSource addObjectsFromArray:datasource];
        [self.collectionView reloadData];
        if (datasource.count>0) {
            self.currentPage++;
        }
        self.shouldLoadMore=datasource.count>=self.pageSize;
        
    } isCache:YES];
}


-(UICollectionViewLayout*)collectionViewLayout
{
    UICollectionViewFlowLayout* flow=[[UICollectionViewFlowLayout alloc]init];
    
    CGFloat sw=[[UIScreen mainScreen]bounds].size.width;
    CGFloat m=5;
    CGFloat w=sw/2-3*m;
    CGFloat h=w*1.5;
    
    flow.itemSize=CGSizeMake(w, h);
    flow.minimumLineSpacing=2*m;
    flow.minimumInteritemSpacing=0;
    flow.sectionInset=UIEdgeInsetsMake(m,2*m,m,2*m);
    
    return flow;
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.dataSource.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    ClassroomVideoShareCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"ClassroomVideoShareCollectionCell" forIndexPath:indexPath];
//    cell.backgroundColor=[UIColor redColor];
    
    BaseModel* m=[self.dataSource objectAtIndex:indexPath.row];
    // Configure the cell
    cell.title.text=m.post_title;
    [cell.imageView sd_setImageWithURL:[m.thumb urlWithMainUrl]];
    
    return cell;
}

#pragma mark <UICollectionViewDelegate>

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    [collectionView deselectItemAtIndexPath:indexPath animated:YES];
    
    BaseModel* m=[self.dataSource objectAtIndex:indexPath.row];
    BaseWebViewController* we=[[BaseWebViewController alloc]initWithUrl:[html_course_detail urlWithMainUrl]];
    we.idd=m.idd.integerValue;
    we.type=@"c3";
    we.title=@"视频详情";
    [self.navigationController pushViewController:we animated:YES];
}

/*
// Uncomment this method to specify if the specified item should be highlighted during tracking
- (BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath {
	return YES;
}
*/

/*
// Uncomment this method to specify if the specified item should be selected
- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}
*/

/*
// Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
- (BOOL)collectionView:(UICollectionView *)collectionView shouldShowMenuForItemAtIndexPath:(NSIndexPath *)indexPath {
	return NO;
}

- (BOOL)collectionView:(UICollectionView *)collectionView canPerformAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	return NO;
}

- (void)collectionView:(UICollectionView *)collectionView performAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	
}
*/

@end
