//
//  BaseTableViewController.m
//  yangsheng
//
//  Created by jam on 17/7/6.
//  Copyright © 2017年 jam. All rights reserved.
//

#import "BaseTableViewController.h"
#import <SystemConfiguration/SystemConfiguration.h>
#import "Reachability.h"
#import "BaseModel.h"
#import "NothingWarningView.h"
#import "BaseLoadMoreFooterView.h"

@interface BaseTableViewController ()<BaseLoadMoreFooterViewDelegate>
{
    AdvertiseView* advHeader;
    NSInteger lastCount;
    BOOL hasNetwork;
    NothingWarningView* nothingView;
    BOOL isManualReload;
    BaseLoadMoreFooterView* loadMoreFooter;
}
@end

@implementation BaseTableViewController

-(NSMutableArray*)dataSource
{
    if (_dataSource==nil) {
        _dataSource=[NSMutableArray array];
    }
//    lastCount=_dataSource.count;
    return _dataSource;
}

-(NSMutableArray*)advsArray
{
    if (_advsArray==nil) {
        _advsArray=[NSMutableArray array];
    }
    return _advsArray;
}

-(UIInterfaceOrientationMask)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskPortrait;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    hasNetwork=NO;
    
    self.shouldLoadMore=YES;
//    self.tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    
    self.tableView.estimatedRowHeight=100;
    self.tableView.rowHeight=UITableViewAutomaticDimension;
    
    self.refreshControl=[[UIRefreshControl alloc]init];
    [self.tableView addSubview:self.refreshControl];
    [self.refreshControl addTarget:self action:@selector(refresh) forControlEvents:UIControlEventValueChanged];
    
    self.tableView.tableFooterView=[[UIView alloc]init];
    [self showLoadMoreView];
    
    self.tableView.separatorColor=[UIColor groupTableViewBackgroundColor];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(networkStateChange:) name:kReachabilityChangedNotification object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(scheduleRefresh) name:ScheduleRefreshNetWorkNotification object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(reloadDataNotification:) name:UITableViewReloadDataNotification object:nil];

//    [self.refreshControl beginRefreshing];
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self.view endEditing:YES];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [[UIApplication sharedApplication]setStatusBarStyle:UIStatusBarStyleDefault];
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

-(void)scheduleRefresh
{
//    NSLog(@"%@ scheduleRefreshing",NSStringFromClass([self class]));
//    [self.refreshControl beginRefreshing];
    lastCount=0;
    [self refresh];
}

-(void)reloadDataNotification:(NSNotification*)notification
{
    NSDictionary* userDef=notification.userInfo;
    UITableView* tableVi=[userDef valueForKey:@"tableView"];
    if (tableVi==self.tableView) {
        if (isManualReload) {
            NSLog(@"%@ reloaded data",NSStringFromClass([self class]));
            [self.refreshControl performSelector:@selector(endRefreshing) withObject:nil afterDelay:1];
        }
        else
        {
            isManualReload=YES;
        }
        
        [loadMoreFooter performSelector:@selector(endLoadingWithText:) withObject:@"加载更多" afterDelay:1];
    }
    
}

-(void)dealloc
{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
    NSLog(@"%@ deal",NSStringFromClass([self class]));
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
}

-(void)stopRefreshAfterSeconds
{
//    [self.refreshControl performSelector:@selector(endRefreshing) withObject:nil afterDelay:2];
    [self.refreshControl performSelector:@selector(endRefreshing) withObject:nil afterDelay:1];
}

-(void)loadMore
{
    [loadMoreFooter performSelector:@selector(endLoadingWithText:) withObject:@"" afterDelay:1];
}

-(void)reloadWithDictionary:(NSDictionary*)dict
{
    
}

-(void)tableViewReloadData
{
    [self.tableView reloadData];
}

#pragma mark - Table view data source


-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    UIView* bg=[[UIView alloc]initWithFrame:cell.bounds];
    bg.backgroundColor=[UIColor groupTableViewBackgroundColor];
    cell.selectedBackgroundView=bg;
//    cell.selectionStyle=UITableViewCellSelectionStyleNone;
//    if ((indexPath.section==[tableView numberOfSections]-1)&&(indexPath.row==[tableView numberOfRowsInSection:indexPath.section]-1)) {
//        self.shouldLoadMore=_dataSource.count!=lastCount;
//        lastCount=_dataSource.count;
////        NSString* loadmoreText=@"正在加载...";
//        if (self.shouldLoadMore) {
//            [self loadMore];
//        }
////        else
////        {
////            loadmoreText=@"";
////        }
////        [self setNothingFooterViewWithText:loadmoreText];
//    }
}

#pragma mark - table view delegate

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark - Advertiseview header

-(void)setAdvertiseHeaderViewWithPicturesUrls:(NSArray *)picturesUrls
{
    if (!advHeader) {
        
        advHeader=[AdvertiseView defaultAdvertiseView];
        advHeader.delegate=self;
    }
    
    advHeader.picturesUrls=picturesUrls;
    self.tableView.tableHeaderView=picturesUrls.count>0?advHeader:nil;
}

-(void)advertiseView:(AdvertiseView *)adver didSelectedIndex:(NSInteger)index
{
//    NSLog(@"advertise:%@ did selected index:%d",advHeader,(int)index);
    if (index<self.advsArray.count) {
        NSObject* ob=[self.advsArray objectAtIndex:index];
        if ([ob isKindOfClass:[BaseModel class]]) {
            BaseModel* mo=(BaseModel*)ob;
            NSLog(@"adv type:%@, id:%@",mo.name,mo.idd);
        }
    }
}

-(void)setNothingFooterViewWithText:(NSString*)text
{
    NothingFooterCell* ff=[NothingFooterCell defaultFooterCell];
    ff.nothingLabel.text=text;
    self.tableView.tableFooterView=ff;
    
}

-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    if (scrollView==self.tableView) {
        [self.tableView endEditing:YES];
    }
}

#pragma mark - nothing label

-(void)showNothingLabelText:(NSString *)text
{
    if (nothingView==nil) {
        nothingView=[NothingWarningView nothingViewWithWarning:text];
    }
    nothingView.label.text=text;
    [nothingView removeFromSuperview];
    [self.view addSubview:nothingView];
    
}

-(void)hideNothingLabel
{
    [nothingView removeFromSuperview];
}

#pragma mark - loadmore something

-(void)showLoadMoreView
{
    if (loadMoreFooter==nil) {
        loadMoreFooter=[BaseLoadMoreFooterView defaultFooter];
        loadMoreFooter.delegate=self;
    }
    self.tableView.tableFooterView=nil;
    self.tableView.tableFooterView=loadMoreFooter;
}

-(void)hideLoadMoreView
{
    if (self.tableView.tableFooterView==loadMoreFooter) {
        self.tableView.tableFooterView=nil;
    }
}

-(void)loadMoreFooterViewShouldStartLoadMore:(BaseLoadMoreFooterView *)footerView
{
    footerView.loading=YES;
    [self loadMore];
}

@end
