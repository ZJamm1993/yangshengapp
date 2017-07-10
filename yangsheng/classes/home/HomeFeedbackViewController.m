//
//  HomeFeedbackViewController.m
//  yangsheng
//
//  Created by Macx on 17/7/7.
//  Copyright © 2017年 jam. All rights reserved.
//

#import "HomeFeedbackViewController.h"

#import "HomeHttpTool.h"
#import "HomeFeedBackCell.h"
#import "HomeFeedBackHeaderCell.h"

@interface HomeFeedbackViewController ()<AdvertiseViewDelegate>
{
    NSArray* sectionsArray;
    NSArray* rowsArray;
    
    NSArray* oneKindArray;
    NSArray* advsArray;
}
@end

@implementation HomeFeedbackViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if (self.isOneKindList) {
        [self loadMore];
    }
    else
    {
        [self firstLoad];
    }
    // Do any additional setup after loading the view.
}

-(void)firstLoad
{
    [super firstLoad];
    if (!self.isOneKindList) {
        [self getDataUsingCache:YES];
    }
}

-(void)refresh
{
    [super refresh];
    if (self.isOneKindList) {
        
        [HomeHttpTool getFeedbackListType:[self.cid integerValue] page:1 success:^(NSArray *datasource) {
            oneKindArray=datasource;
            [self.tableView reloadData];
            [self stopRefreshAfterSeconds];
            if (oneKindArray.count>0) {
                self.currentPage=1;
            }
        } isCache:NO];
    }
    else
    {
        [self getDataUsingCache:NO];
        [self stopRefreshAfterSeconds];
    }
}

-(void)loadMore
{
    if (self.isOneKindList) {
        [HomeHttpTool getFeedbackListType:[self.cid integerValue] page:++self.currentPage success:^(NSArray *datasource) {
            NSMutableArray* arr=[NSMutableArray array];
            [arr addObjectsFromArray:oneKindArray?:[NSArray array]];
            [arr addObjectsFromArray:datasource];
            oneKindArray=arr;
            [self.tableView reloadData];
            if (datasource.count>0) {
                self.currentPage++;
            }
            self.shouldLoadMore=datasource.count>=20;
            
        } isCache:YES];
    }
}


-(void)getDataUsingCache:(BOOL)isCache
{
    //
    [HomeHttpTool getAdversType:7 success:^(NSArray *datasource) {
        advsArray=[NSMutableArray arrayWithArray:datasource];
        NSMutableArray* pics=[NSMutableArray array];
        for (BaseModel* ad in advsArray) {
            NSString* th=ad.thumb;
            NSString* fu=[ZZUrlTool fullUrlWithTail:th];
            [pics addObject:fu];
        }
        [self setAdvertiseHeaderViewWithPicturesUrls:pics];
    } isCache:isCache];
    
    [HomeHttpTool getFeedbackAllListSize:2 success:^(NSArray *sections, NSArray *rows) {
        sectionsArray=sections;
        rowsArray=rows;
        [self.tableView reloadData];
    } isCache:isCache];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (self.isOneKindList) {
        return 1;//return oneKindArray.count;
    }
    return sectionsArray.count;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (self.isOneKindList) {
        return oneKindArray.count;
    }
    NSArray* rows=[rowsArray objectAtIndex:section];
    return rows.count+1;
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
    if (self.isOneKindList) {
        HomeFeedBackCell* c=[tableView dequeueReusableCellWithIdentifier:@"HomeFeedBackCell" forIndexPath:indexPath];
        BaseModel* m=[oneKindArray objectAtIndex:indexPath.row];
        [c.feeBgImage sd_setImageWithURL:[m.thumb urlWithMainUrl]];
        c.feeTitle.text=m.post_title;
        c.feeContent.text=m.post_excerpt;
        return c;
    }
    if (indexPath.row==0) {
        HomeFeedBackHeaderCell* c=[tableView dequeueReusableCellWithIdentifier:@"HomeFeedBackHeaderCell" forIndexPath:indexPath];
        BaseModel* m=[sectionsArray objectAtIndex:indexPath.section];
        c.feeTitle.text=m.name;
        c.feeSubTitle.text=m.ddescription;
        return c;
    }
    else
    {
        HomeFeedBackCell* c=[tableView dequeueReusableCellWithIdentifier:@"HomeFeedBackCell" forIndexPath:indexPath];
        NSArray* arr=[rowsArray objectAtIndex:indexPath.section];
        BaseModel* m=[arr objectAtIndex:indexPath.row-1];
        [c.feeBgImage sd_setImageWithURL:[m.thumb urlWithMainUrl]];
        c.feeTitle.text=m.post_title;
        c.feeContent.text=m.post_excerpt;
        return c;
    }
}

-(void)tableView:(UITableView*)tableView didSelectRowAtIndexPath:(nonnull NSIndexPath *)indexPath
{
    if (self.isOneKindList) {
        
    }
    else
    {
        if (indexPath.row==0) {
            BaseModel* m=[sectionsArray objectAtIndex:indexPath.section];
            HomeFeedbackViewController* fe=[[UIStoryboard storyboardWithName:@"Home" bundle:nil]instantiateViewControllerWithIdentifier:@"HomeFeedback"];
            fe.title=m.name;
            fe.cid=m.cid;
            fe.isOneKindList=YES;
            [self.navigationController pushViewController:fe animated:YES];
        }
    }
}

@end
