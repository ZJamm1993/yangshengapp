//
//  BaseTableViewController.h
//  yangsheng
//
//  Created by jam on 17/7/6.
//  Copyright © 2017年 jam. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AdvertiseView.h"
#import "NothingFooterCell.h"
#import "ZZHttpTool.h"

@interface BaseTableViewController : UITableViewController<AdvertiseViewDelegate>

@property (nonatomic,strong) NSMutableArray* dataSource;
@property (nonatomic,strong) NSMutableArray* advsArray;
@property (nonatomic,strong) NSString* urlString;

@property (nonatomic,assign) NSInteger currentPage;
@property (nonatomic,assign) NSInteger pageSize;
@property (nonatomic,assign) BOOL shouldLoadMore;

-(void)firstLoad;
-(void)refresh;
-(void)stopRefreshAfterSeconds;

-(void)loadMore;

-(void)setAdvertiseHeaderViewWithPicturesUrls:(NSArray*)picturesUrls;
//-(void)setNothingFooterView;
-(void)showNothingLabelText:(NSString*)text;
-(void)hideNothingLabel;

-(void)tableViewReloadData;

@end
