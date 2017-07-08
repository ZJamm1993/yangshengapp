//
//  HomeStoryViewController.m
//  yangsheng
//
//  Created by jam on 17/7/6.
//  Copyright © 2017年 jam. All rights reserved.
//

#import "HomeStoryViewController.h"

#import "AdvertiseView.h"

#import "HomeHeaderCell.h"

#import "HomeProductClassCell.h"
#import "HomeProductHeaderCell.h"

#import "HomeQACell.h"

#import "HomeFounderCell.h"

#import "HomeEnterprisePublicityCell.h"

#import "HomeHttpTool.h"

@interface HomeStoryViewController ()
{
    NSMutableArray* productClassArray;
    NSMutableArray* qaArray;
    NSMutableArray* founderArray;
    NSMutableArray* advsArray;
    NSMutableArray* enterArray;
    
    UITapGestureRecognizer* tapGesture;
    
    AdvertiseView* advHeader;
}
@end

@implementation HomeStoryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    advHeader=[[AdvertiseView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.width*0.6)];
    advHeader.backgroundColor=[UIColor lightGrayColor];
    self.tableView.tableHeaderView=advHeader;
    
    [self.tableView registerNib:[UINib nibWithNibName:@"HomeHeaderCell" bundle:nil] forCellReuseIdentifier:@"HomeHeaderCell"];
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
    [HomeHttpTool getAdversSuccess:^(NSArray *datasource) {
        advsArray=[NSMutableArray arrayWithArray:datasource];
        NSMutableArray* pics=[NSMutableArray array];
        for (ModelAdvs* ad in advsArray) {
            NSString* th=ad.thumb;
            NSString* fu=[ZZUrlTool fullUrlWithTail:th];
            [pics addObject:fu];
        }
        advHeader.picturesUrls=pics;
    } isCache:isCache];
    
    //
    [HomeHttpTool getProductClassSuccess:^(NSArray *datasource) {
        productClassArray=[NSMutableArray arrayWithArray:datasource];
        [self.tableView reloadData];
    } isCache:isCache];
    
    //
    [HomeHttpTool getQuesAnsRandomSuccess:^(NSArray *datasource) {
        qaArray=[NSMutableArray arrayWithArray:datasource];
        [self.tableView reloadData];
    } isCache:isCache];
    
    //
    [HomeHttpTool getFoundersSuccess:^(NSArray *datasource) {
        founderArray=[NSMutableArray arrayWithArray:datasource];
        [self.tableView reloadData];
    } isCache:isCache];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 5;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section==0) {
        return 1;
    }
    else if(section==1)
    {
        return productClassArray.count+1;
    }
    else if(section==2)
    {
        return qaArray.count+1;
    }
    else if(section==3)
    {
        NSInteger rs=founderArray.count/2;
        if (founderArray.count%2>0) {
            rs=rs+1;
        }
        return rs+1;
    }
    else if(section==4)
    {
#warning testing
        return 2;
    }
    return 0;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger sec=indexPath.section;
    NSInteger row=indexPath.row;
    if (sec==0) {
        return 100;
    }
    else if(sec==1)
    {
        if (row==0) {
            return 60;
        }
        else
        {
            return 200;
        }
    }
    else if(sec==2)
    {
        if (row==0) {
            return 100;
        }
        else
        {
            return UITableViewAutomaticDimension;
        }
    }
    else if(sec==3)
    {
        if (row==0) {
            return 90;
        }
        else
        {
            return [[UIScreen mainScreen]bounds].size.width/2-25+35;
        }
    }
    else if(sec==4)
    {
        if (row==0) {
            return 90;
        }
        else
        {
            return UITableViewAutomaticDimension;
        }
    }
    return 0.0001;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger sec=indexPath.section;
    NSInteger row=indexPath.row;
    if (sec==0) {
        HomeHeaderCell* c=[tableView dequeueReusableCellWithIdentifier:@"HomeHeaderCell" forIndexPath:indexPath];
        return c;
    }
    else if(sec==1)
    {
        if (row==0) {
            HomeProductHeaderCell* c=[tableView dequeueReusableCellWithIdentifier:@"HomeProductHeaderCell" forIndexPath:indexPath];
            NSMutableArray* arr=[NSMutableArray array];
            for (ModelProductClass* pro in productClassArray) {
                NSString* name=pro.name;
                if (name) {
                    [arr addObject:name];
                }
            }
            NSString* subtitle=[arr componentsJoinedByString:@"&"];
            c.productHeaderSubtitleLabel.text=subtitle;
            return c;
        }
        else
        {
            HomeProductClassCell* c=[tableView dequeueReusableCellWithIdentifier:@"HomeProductClassCell" forIndexPath:indexPath];
            ModelProductClass* pro=[productClassArray objectAtIndex:row-1];
            c.productName.text=pro.name;
            [c.productThumb sd_setImageWithURL:[pro.thumb urlWithMainUrl]];
            return c;
        }
    }
    else if(sec==2)
    {
        if (row==0) {
            UITableViewCell* c=[tableView dequeueReusableCellWithIdentifier:@"HomeQAHeaderCell" forIndexPath:indexPath];
            return c;
        }
        else
        {
            HomeQACell* c=[tableView dequeueReusableCellWithIdentifier:@"HomeQACell" forIndexPath:indexPath];
            ModelQA* qa=[qaArray objectAtIndex:row-1];
            c.qaTitleLabel.text=[NSString stringWithFormat:@"# %@",qa.post_title];
            c.qaContentLabel.text=qa.post_excerpt;
            c.qaReadLabel.text=[NSString stringWithFormat:@"%ld阅览",(long)qa.post_hits];
            return c;
        }
    }
    else if(sec==3)
    {
        if (row==0) {
            UITableViewCell* c=[tableView dequeueReusableCellWithIdentifier:@"HomeFounderHeaderCell" forIndexPath:indexPath];
            return c;
        }
        else
        {
            HomeFounderCell* c=[tableView dequeueReusableCellWithIdentifier:@"HomeFounderCell" forIndexPath:indexPath];
            
            NSInteger tr=row-1;
            NSInteger leftIndex=tr*2;
            NSInteger rightIndex=leftIndex+1;
            
            NSMutableArray* fous=[NSMutableArray array];
            if (leftIndex<founderArray.count) {
                [fous addObject:[founderArray objectAtIndex:leftIndex]];
            }
            if (rightIndex<founderArray.count) {
                [fous addObject:[founderArray objectAtIndex:rightIndex]];
            }
            
            c.founders=fous;
            
            return c;
        }
    }
    else if(sec==4)
    {
        if (row==0) {
            UITableViewCell* c=[tableView dequeueReusableCellWithIdentifier:@"HomePublicityHeaderCell" forIndexPath:indexPath];
            return c;
        }
        else
        {
            HomeEnterprisePublicityCell* c=[tableView dequeueReusableCellWithIdentifier:@"HomeEnterprisePublicityCell" forIndexPath:indexPath];
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
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    //
//    NSLog(@"tab:%@",indexPath.description);
}

-(void)tapGestureDidTap:(UITapGestureRecognizer*)ta
{
    CGPoint point = [ta locationInView:self.tableView];
    NSIndexPath * indexPath = [self.tableView indexPathForRowAtPoint:point];
    if (indexPath) {
        NSInteger sec=indexPath.section;
        NSInteger row=indexPath.row;
        
        if (sec==3) {
            if (row>0) {
                NSInteger tr=row-1;
                NSInteger leftIndex=tr*2;
                NSInteger rightIndex=leftIndex+1;
                BOOL left=point.x<[[UIScreen mainScreen]bounds].size.width/2;
                
                ModelFounder* unknownFounder=nil;
                
                if (left) {
                    if (leftIndex<founderArray.count) {
                        unknownFounder=[founderArray objectAtIndex:leftIndex];
                    }
                }
                else
                {
                    if (rightIndex<founderArray.count) {
                        unknownFounder=[founderArray objectAtIndex:rightIndex];
                    }
                }
                NSLog(@"founder %@",unknownFounder.description);
            }
        }
        
    }
}

@end
