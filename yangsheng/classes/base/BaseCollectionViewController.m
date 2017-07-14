//
//  BaseCollectionViewController.m
//  yangsheng
//
//  Created by Macx on 17/7/14.
//  Copyright © 2017年 jam. All rights reserved.
//

#import "BaseCollectionViewController.h"
#import <SystemConfiguration/SystemConfiguration.h>
#import "Reachability.h"

@interface BaseCollectionViewController ()
{
    UIRefreshControl* refreshControl;
    AdvertiseView* advHeader;
    BOOL hasNetwork;
    NSInteger lastCount;
}
@end

@implementation BaseCollectionViewController

static NSString * const reuseIdentifier = @"Cell";

- (void)viewDidLoad {
    [super viewDidLoad];
    hasNetwork=NO;
    
    self.shouldLoadMore=YES;
    
    self.automaticallyAdjustsScrollViewInsets=NO;
    
    refreshControl=[[UIRefreshControl alloc]init];
    [self.collectionView addSubview:refreshControl];
    [refreshControl addTarget:self action:@selector(refresh) forControlEvents:UIControlEventValueChanged];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(networkStateChange:) name:kReachabilityChangedNotification object:nil];
    
    
    // Uncomment the following line to preserve selection between presentations
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Register cell classes
    self.collectionView.collectionViewLayout=self.collectionViewLayout;
    self.collectionView.bounces=YES;
    self.collectionView.alwaysBounceVertical=YES;
    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:reuseIdentifier];
    self.collectionView.backgroundColor=[UIColor colorWithWhite:1 alpha:1];
    
//    [self setAdvertiseHeaderViewWithPicturesUrls:@[@"",@""]];
    // Do any additional setup after loading the view.
}

-(NSMutableArray*)dataSource
{
    if (_dataSource==nil) {
        _dataSource=[NSMutableArray array];
    }
    return _dataSource;
}

-(UIInterfaceOrientationMask)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskPortrait;
}

-(NSInteger)pageSize
{
    if (_pageSize<=0) {
        NSDictionary* d=[ZZHttpTool pageParams];
        
        _pageSize=[[d valueForKey:@"pagesize"]integerValue];
    }
    return _pageSize;
}

-(void)networkStateChange:(NSNotification*)noti
{
    Reachability* reach=[noti object];
    if (reach.currentReachabilityStatus!=NotReachable) {
        if (hasNetwork==NO) {
            if (self.currentPage<=0) {
                [self refresh];
            }
        }
        hasNetwork=YES;
    }
    else
    {
        hasNetwork=NO;
    }
}

-(void)dealloc
{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}

#pragma mark - Refresh And Load More

-(void)setUrlString:(NSString *)urlString
{
    _urlString=urlString;
}

-(void)firstLoad
{
    
}

-(void)refresh
{
    //    [self.dataSource removeAllObjects];
    
    //    NSString* url=@"ht tp://api.change.so/v1/videos/ranking.json";
    //    NSDictionary* par=@{@"page":@"1",@"per_page":@"20",@"since":@"weekly"};
    //    [ZZHttpTool get:url params:par success:^(NSDictionary *responseObject) {
    //
    //    } failure:^(NSError *error) {
    //
    //    }];
}

-(void)stopRefreshAfterSeconds
{
    [refreshControl performSelector:@selector(endRefreshing) withObject:nil afterDelay:2];
}

-(void)loadMore
{
    
}

-(void)reloadWithDictionary:(NSDictionary*)dict
{
    
}

-(void)collectionView:(UICollectionView *)collectionView willDisplayCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath
{
    //    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    
    if ((indexPath.section==[collectionView numberOfSections]-1)&&(indexPath.row==[collectionView numberOfItemsInSection:indexPath.section]-1)) {
        self.shouldLoadMore=_dataSource.count!=lastCount;
        lastCount=_dataSource.count;
        if (self.shouldLoadMore) {
            [self loadMore];
        }
    }
}

#pragma mark - Advertiseview header

-(void)setAdvertiseHeaderViewWithPicturesUrls:(NSArray *)picturesUrls
{
    if (!advHeader) {
        
        advHeader=[AdvertiseView defaultAdvertiseView];
        CGRect fr=advHeader.frame;
        fr.origin.y=-fr.size.height;
        advHeader.frame=fr;
        advHeader.delegate=self;
    }
    
    advHeader.picturesUrls=picturesUrls;
    if (picturesUrls.count>0) {
        [advHeader removeFromSuperview];
        [self.collectionView addSubview:advHeader];
        CGFloat top=advHeader.frame.size.height;
        if (refreshControl.isRefreshing) {
            top=top+60;
        }
        self.collectionView.contentInset=UIEdgeInsetsMake(top, 0, 0, 0);
        
//        CGRect refreshFrame=refreshControl.frame;
//        refreshFrame.origin.y=-advHeader.frame.size.height-refreshFrame.size.height;
//        refreshControl.frame=refreshFrame;
    }
    else
    {
        [advHeader removeFromSuperview];
        CGFloat top=0;
        if (refreshControl.isRefreshing) {
            top=top+60;
        }
        self.collectionView.contentInset=UIEdgeInsetsMake(top, 0, 0, 0);
        
//        CGRect refreshFrame=refreshControl.frame;
//        refreshFrame.origin.y=-refreshFrame.size.height;
//        refreshControl.frame=refreshFrame;
    }
    [refreshControl removeFromSuperview];
    [self.collectionView addSubview:refreshControl];
}

-(void)advertiseView:(AdvertiseView *)adver didSelectedIndex:(NSInteger)index
{
    NSLog(@"advertise:%@ did selected index:%d",advHeader,(int)index);
}

//-(void)scrollViewDidScroll:(UIScrollView *)scrollView
//{
//    [self reframeRefreshControlWithScrollView:scrollView];
//}
//
//-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
//{
//    [self reframeRefreshControlWithScrollView:scrollView];
//}
//
//-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
//{
//    [self reframeRefreshControlWithScrollView:scrollView];
//}
//
//-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
//{
//    
//}
//
//-(void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView
//{
//    
//}
//
//-(void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView
//{
//    
//}

-(void)reframeRefreshControlWithScrollView:(UIScrollView*)scrollView
{
    if (scrollView==self.collectionView) {
        NSLog(@"offset:%@",NSStringFromCGPoint(scrollView.contentOffset));
        NSLog(@"refresh:%@",NSStringFromCGRect(refreshControl.frame));
        CGRect fr =refreshControl.frame;
        fr.origin.y=scrollView.contentOffset.y;
        
        [refreshControl removeFromSuperview];
        [self.collectionView addSubview:refreshControl];
        refreshControl.frame=fr;
    }
}

-(UICollectionViewLayout*)collectionViewLayout
{
    UICollectionViewFlowLayout* flow=[[UICollectionViewFlowLayout alloc]init];
    
    CGFloat sw=[[UIScreen mainScreen]bounds].size.width;
    CGFloat m=5;
    CGFloat w=(sw-2*m)/2;
    CGFloat h=w;
    
    flow.itemSize=CGSizeMake(w, h);
    flow.minimumLineSpacing=m;
    flow.minimumInteritemSpacing=m;
    flow.sectionInset=UIEdgeInsetsMake(0,0,0,0);

    flow.headerReferenceSize=advHeader.frame.size;
    
    return flow;
}

-(void)setNothingFooterView
{
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/



- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    cell.backgroundColor=[UIColor redColor];
    // Configure the cell
    
    return cell;
}

#pragma mark <UICollectionViewDelegate>


// Uncomment this method to specify if the specified item should be highlighted during tracking
- (BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath {
	return YES;
}

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
