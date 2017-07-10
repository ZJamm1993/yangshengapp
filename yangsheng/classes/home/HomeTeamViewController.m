//
//  HomeTeamViewController.m
//  yangsheng
//
//  Created by jam on 17/7/6.
//  Copyright © 2017年 jam. All rights reserved.
//

#import "HomeTeamViewController.h"

#import "HomeMonthStarCell.h"
#import "HomeFounderCell.h"
#import "HomeTeamExtCell.h"

#import "NothingFooterCell.h"

#import "HomeHttpTool.h"

typedef NS_ENUM(NSInteger,HomeTeamSection)
{
    HomeTeamSectionStar,
    HomeTeamSectionCom,
    HomeTeamSectionExt,
    HomeTeamSectionNumbers
};

@interface HomeTeamViewController ()<AdvertiseViewDelegate>
{
    NSMutableArray* advsArray;
    NSMutableArray* starsArray;
    NSMutableArray* teamsArray;
    NSMutableArray* extsArray;
    UITapGestureRecognizer* tapGesture;
}

@end

@implementation HomeTeamViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setNothingFooterView];
    
    tapGesture=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapGestureDidTap:)];
    [self.tableView addGestureRecognizer:tapGesture];
    
    [self firstLoad];
    // Do any additional setup after loading the view.
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
    [HomeHttpTool getAdversType:6 success:^(NSArray *datasource) {
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
    [HomeHttpTool getTeamsSuccess:^(NSArray *datasource) {
        teamsArray=[NSMutableArray arrayWithArray:datasource];
        [self.tableView reloadData];
    } isCache:isCache];
    
    //
    [HomeHttpTool getMonthStarSuccess:^(NSArray *datasource) {
        starsArray=[NSMutableArray arrayWithArray:datasource];
        [self.tableView reloadData];
    } isCache:isCache];
    
    //
    [HomeHttpTool getExpandSuccess:^(NSArray *datasource) {
        extsArray=[NSMutableArray arrayWithArray:datasource];
        [self.tableView reloadData];
    } isCache:isCache];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return HomeTeamSectionNumbers;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section==HomeTeamSectionStar) {
        return starsArray.count+1;
    }
    else if(section==HomeTeamSectionCom)
    {
        NSInteger rs=teamsArray.count/2;
        if (teamsArray.count%2>0) {
            rs=rs+1;
        }
        return rs+1;
    }
    else if(section==HomeTeamSectionExt)
    {
        return extsArray.count+1;
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
    if (indexPath.section==HomeTeamSectionStar) {
        if (indexPath.row==0) {
            UITableViewCell* c=[tableView dequeueReusableCellWithIdentifier:@"MonthStarHeaderCell" forIndexPath:indexPath];
            return c;
        }
        else
        {
            HomeMonthStarCell* c=[tableView dequeueReusableCellWithIdentifier:@"HomeMonthStarCell" forIndexPath:indexPath];
            BaseModel* sta=[starsArray objectAtIndex:indexPath.row-1];
            [c.starImageView sd_setImageWithURL:[sta.thumb urlWithMainUrl]];
            c.starTitle.text=sta.post_title;
            c.starContent.text=sta.ios_content;
            return c;
        }
    }
    else if(indexPath.section==HomeTeamSectionCom)
    {
        if (indexPath.row==0) {
            UITableViewCell* c=[tableView dequeueReusableCellWithIdentifier:@"CompanyHeaderCell" forIndexPath:indexPath];
            return c;
        }
        else
        {
            HomeFounderCell* c=[tableView dequeueReusableCellWithIdentifier:@"HomeFounderCell" forIndexPath:indexPath];
            
            NSInteger tr=indexPath.row-1;
            NSInteger leftIndex=tr*2;
            NSInteger rightIndex=leftIndex+1;
            
            NSMutableArray* fous=[NSMutableArray array];
            if (leftIndex<teamsArray.count) {
                [fous addObject:[teamsArray objectAtIndex:leftIndex]];
            }
            if (rightIndex<teamsArray.count) {
                [fous addObject:[teamsArray objectAtIndex:rightIndex]];
            }
            
            c.founders=fous;
            
            return c;
        }
    }
    else if(indexPath.section==HomeTeamSectionExt)
    {
        if (indexPath.row==0) {
            UITableViewCell* c=[tableView dequeueReusableCellWithIdentifier:@"TeamExtHeaderCell" forIndexPath:indexPath];
            return c;
        }
        else
        {
            HomeTeamExtCell* c=[tableView dequeueReusableCellWithIdentifier:@"HomeTeamExtCell" forIndexPath:indexPath];
            
            BaseModel* ext=[extsArray objectAtIndex:indexPath.row-1];
            [c.extBgImageView sd_setImageWithURL:[ext.thumb urlWithMainUrl]];
            c.extTitle.text=ext.post_title;
            c.extContent.text=ext.post_excerpt;
            c.extDateLabel.text=ext.post_modified;
            return c;
        }
        
    }
    
    else
    {
        return nil;
    }
}

-(void)tapGestureDidTap:(UITapGestureRecognizer*)ta
{
    CGPoint point = [ta locationInView:self.tableView];
    NSIndexPath * indexPath = [self.tableView indexPathForRowAtPoint:point];
    if (indexPath) {
        NSInteger sec=indexPath.section;
        NSInteger row=indexPath.row;
        
        if (sec==HomeTeamSectionCom) {
            if (row>0) {
                NSInteger tr=row-1;
                NSInteger leftIndex=tr*2;
                NSInteger rightIndex=leftIndex+1;
                BOOL left=point.x<[[UIScreen mainScreen]bounds].size.width/2;
                
                BaseModel* unknownFounder=nil;
                
                if (left) {
                    if (leftIndex<teamsArray.count) {
                        unknownFounder=[teamsArray objectAtIndex:leftIndex];
                    }
                }
                else
                {
                    if (rightIndex<teamsArray.count) {
                        unknownFounder=[teamsArray objectAtIndex:rightIndex];
                    }
                }
                NSLog(@"founder %@",unknownFounder.description);
            }
        }
        
    }
}



@end
