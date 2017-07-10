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
    [HomeHttpTool getBrandEventSuccess:^(NSArray *datasource) {
        brandEvents=[NSMutableArray arrayWithArray:datasource];
        [self.tableView reloadData];
    } isCache:isCache];
    
    //
    [HomeHttpTool getLatestEventSuccess:^(NSArray *datasource) {
        latestEvents=[NSMutableArray arrayWithArray:datasource];
        [self.tableView reloadData];
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

@end
