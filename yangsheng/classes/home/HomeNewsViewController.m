//
//  HomeNewsViewController.m
//  yangsheng
//
//  Created by Macx on 17/7/7.
//  Copyright © 2017年 jam. All rights reserved.
//

#import "HomeNewsViewController.h"
#import "HomeHttpTool.h"
#import "NewsLargeCell.h"
#import "NewsSmallCell.h"

@interface HomeNewsViewController ()
{
    NSMutableArray* brandEvents;
    NSMutableArray* latestEvents;
    NSArray* advsArray;
}
@end

@implementation HomeNewsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self firstLoad];
    // Do any additional setup after loading the view.
    [self setNothingFooterView];
}

-(void)firstLoad
{
    [super firstLoad];
    [self getDataUsingCache:YES];
}

-(void)refresh
{
    [super refresh];
    [self getDataUsingCache:NO];
    [self stopRefreshAfterSeconds];
}

-(void)getDataUsingCache:(BOOL)isCache
{
    //
    [HomeHttpTool getAdversType:8 success:^(NSArray *datasource) {
        advsArray=[NSMutableArray arrayWithArray:datasource];
        NSMutableArray* pics=[NSMutableArray array];
        for (BaseModel* ad in advsArray) {
            NSString* th=ad.thumb;
            NSString* fu=[ZZUrlTool fullUrlWithTail:th];
            [pics addObject:fu];
        }
        [self setAdvertiseHeaderViewWithPicturesUrls:pics];
    } isCache:isCache];
    
    //
    [HomeHttpTool getBrandEventSuccess:^(NSArray *datasource) {
        brandEvents=[NSMutableArray arrayWithArray:datasource];
        [self tableViewReloadData];
    } isCache:isCache];
    
    //
    [HomeHttpTool getLatestEventSuccess:^(NSArray *datasource) {
        latestEvents=[NSMutableArray arrayWithArray:datasource];
        [self tableViewReloadData];
    } isCache:isCache];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section==0) {
        return brandEvents.count+1;
    }
    else if(section==1)
    {
        return latestEvents.count+1;
    }
    return 0;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 4;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section==0) {
        return 0.0001;
    }
    return 4;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==0) {
        if (indexPath.row==0) {
            UITableViewCell* c=[tableView dequeueReusableCellWithIdentifier:@"LargeHeaderCell" forIndexPath:indexPath];
            return c;
        }
        else
        {
            NewsLargeCell* c=[tableView dequeueReusableCellWithIdentifier:@"NewsLargeCell" forIndexPath:indexPath];
            BaseModel* m=[brandEvents objectAtIndex:indexPath.row-1];
            c.title.text=m.post_title;
            [c.img sd_setImageWithURL:[m.thumb urlWithMainUrl]];
            c.date.text=m.post_modified;
            return c;
        }
    }
    else if (indexPath.section==1) {
        if (indexPath.row==0) {
            UITableViewCell* c=[tableView dequeueReusableCellWithIdentifier:@"SmallHeaderCell" forIndexPath:indexPath];
            return c;
        }
        else
        {
            NewsSmallCell* c=[tableView dequeueReusableCellWithIdentifier:@"NewsSmallCell" forIndexPath:indexPath];
            BaseModel* m=[latestEvents objectAtIndex:indexPath.row-1];
            c.title.text=m.post_title;
            [c.img sd_setImageWithURL:[m.thumb urlWithMainUrl]];
            c.content.text=m.post_excerpt;
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
    NSInteger sec=indexPath.section;
    NSInteger row=indexPath.row;
    NSArray* arr=sec==0?brandEvents:latestEvents;
    NSString* url=sec==0?html_brandBigEvent_detail:html_newBigEvent_detail;
    if (row>0) {
        BaseModel* m=[arr objectAtIndex:row-1];
        BaseWebViewController* we=[[BaseWebViewController alloc]initWithUrl:[url urlWithMainUrl]];
        we.idd=m.idd.integerValue;
        we.title=m.post_title;
        [self.navigationController pushViewController:we animated:YES];
    }
}

@end
