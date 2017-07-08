//
//  HomeTeamViewController.m
//  yangsheng
//
//  Created by jam on 17/7/6.
//  Copyright © 2017年 jam. All rights reserved.
//

#import "HomeTeamViewController.h"
#import "HomeMonthStarCell.h"

@interface HomeTeamViewController ()

@end

@implementation HomeTeamViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section==0) {
        return 0;
    }
    else if(section==1)
    {
        return 1;
    }
    else if(section==2)
    {
        return 0;
    }
    return 0;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return UITableViewAutomaticDimension;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==1) {
        HomeMonthStarCell* c=[tableView dequeueReusableCellWithIdentifier:@"HomeMonthStarCell" forIndexPath:indexPath];
        return c;
    }
    
    else
    {
        return nil;
    }
}

@end
