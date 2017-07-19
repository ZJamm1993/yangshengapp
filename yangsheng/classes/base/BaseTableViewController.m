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

@interface BaseTableViewController ()
{
    AdvertiseView* advHeader;
    NSInteger lastCount;
    BOOL hasNetwork;
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
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(networkStateChange:) name:kReachabilityChangedNotification object:nil];
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
}

-(void)stopRefreshAfterSeconds
{
    [self.refreshControl performSelector:@selector(endRefreshing) withObject:nil afterDelay:2];
}

-(void)loadMore
{
    
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
//    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    if ((indexPath.section==[tableView numberOfSections]-1)&&(indexPath.row==[tableView numberOfRowsInSection:indexPath.section]-1)) {
        self.shouldLoadMore=_dataSource.count!=lastCount;
        lastCount=_dataSource.count;
        if (self.shouldLoadMore) {
            [self loadMore];
        }
    }
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
    NSLog(@"advertise:%@ did selected index:%d",advHeader,(int)index);
}

-(void)setNothingFooterView
{
    //NothingFooterCell* ff=[NothingFooterCell defaultFooterCell];
    //self.tableView.tableFooterView=ff;
}

-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    if (scrollView==self.tableView) {
        [self.tableView endEditing:YES];
    }
}

@end
