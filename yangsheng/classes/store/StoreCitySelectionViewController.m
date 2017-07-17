//
//  StoreCitySelectionViewController.m
//  yangsheng
//
//  Created by Macx on 17/7/15.
//  Copyright © 2017年 jam. All rights reserved.
//

#import "StoreCitySelectionViewController.h"
#import "StoreHttpTool.h"

@interface StoreCitySelectionViewController ()

@end

@implementation StoreCitySelectionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title=[self.level isEqualToString:CityLevelProvince]?@"选择省":[self.level isEqualToString:CityLevelCity]?@"选择市":@"选择区";
    
    [self refresh];
    // Do any additional setup after loading the view.
}

-(void)refresh
{
    [self stopRefreshAfterSeconds];
    
    [StoreHttpTool getCitysWithLevel:self.level keywords:self.keywords success:^(NSArray *datasource) {
        [self.dataSource removeAllObjects];
        [self.dataSource addObjectsFromArray:datasource];
        [self.tableView reloadData];
    } isCache:YES];
}

-(NSString*)level
{
    if (_level.length==0) {
        _level=@"province";
    }
    return _level;
}

-(NSString*)keywords
{
    BOOL isPro=[self.level isEqualToString:CityLevelProvince];
    return isPro?@"":_keywords;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataSource.count;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell* cell=[tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell==nil) {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
    }
    CityModel* city=[self.dataSource objectAtIndex:indexPath.row];
    cell.textLabel.text=city.name;
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    CityModel* city=[self.dataSource objectAtIndex:indexPath.row];
    
    StoreCitySelectionViewController* ob=[[StoreCitySelectionViewController alloc]initWithStyle:UITableViewStylePlain];
    ob.isStoreLocation=self.isStoreLocation;
    if (city) {
        NSMutableArray* thisCities=[NSMutableArray arrayWithArray:self.lastLevelCities];
        [thisCities addObject:city];
        ob.lastLevelCities=thisCities;
    }
    ob.keywords=city.adcode;
    if ([self.level isEqualToString:CityLevelProvince]) {
        ob.level=CityLevelCity;
    }
    else if([self.level isEqualToString:CityLevelCity])
    {
        if (self.isStoreLocation) {
            ob.level=CityLevelDistrict;
        }
        else
        {
            [CityModel saveCity:city];
            [[NSNotificationCenter defaultCenter]postNotificationName:SelectedNewCityNotification object:nil];
            [self.navigationController dismissViewControllerAnimated:YES completion:nil];
            return;
        }
    }
    else if([self.level isEqualToString:CityLevelDistrict])
    {
        if (self.isStoreLocation) {
            NSArray* cities=ob.lastLevelCities;
            [[NSNotificationCenter defaultCenter]postNotificationName:SelectedNewCityNotification object:nil userInfo:[NSDictionary dictionaryWithObject:cities forKey:CityLevelCity]];
            [self.navigationController dismissViewControllerAnimated:YES completion:nil];
            return;
        }
    }
    else
    {
        [self.navigationController dismissViewControllerAnimated:YES completion:nil];
        return;
    }
    
    [self.navigationController pushViewController:ob animated:YES];
}

-(NSArray*)lastLevelCities
{
    if (_lastLevelCities==nil) {
        _lastLevelCities=[NSArray array];
    }
    return _lastLevelCities;
}

@end
