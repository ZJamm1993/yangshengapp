//
//  BaseTableViewController.h
//  yangsheng
//
//  Created by jam on 17/7/6.
//  Copyright © 2017年 jam. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseTableViewController : UITableViewController

@property (nonatomic,strong) NSMutableArray* dataSource;
@property (nonatomic,strong) NSString* urlString;

@property (nonatomic,assign) NSInteger currentPage;
@property (nonatomic,assign) BOOL shouldLoadMore;

-(void)firstLoad;
-(void)refresh;
-(void)stopRefreshAfterSeconds;

-(void)loadMore;

@end
