//
//  StoreRootViewController.m
//  yangsheng
//
//  Created by Macx on 17/7/13.
//  Copyright © 2017年 jam. All rights reserved.
//

#import "StoreRootViewController.h"
#import "StoreSearchViewController.h"
#import "StoreAllViewController.h"
#import "StoreObjectsViewController.h"

#import "StoreHttpTool.h"
#import "HomeHttpTool.h"

#import "ButtonsCell.h"
#import "StoreSmallCell.h"

#import <CoreLocation/CoreLocation.h>

#define UserLastLocationKey @"ojijoiooiijo"
#define UserLastLocationLatitudeKey @"iiuiuuhwefiu"
#define UserLastLocationLongitudeKey @"i298sdfiosdfoi"

@interface StoreRootViewController ()<ButtonsCellDelegate,CLLocationManagerDelegate>
{
    NSArray* advsArray;
    StoreSearchViewController* searchVc;
    CLLocationManager* locationManager;
    NSString* currentLng;
    NSString* currentLat;
}
@end

@implementation StoreRootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.tableView registerClass:[ButtonsCell class] forCellReuseIdentifier:@"TopButtonsCell"];
    // Do any additional setup after loading the view.
    
    
    self.title=@"门店";
    
//    UIBarButtonItem* sea=[[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemSearch target:self action:@selector(goToSearch)];
//    self.navigationItem.rightBarButtonItem=sea;
//    
    locationManager=[[CLLocationManager alloc]init];
    locationManager.delegate=self;
    locationManager.desiredAccuracy=kCLLocationAccuracyHundredMeters;
    
    if ([locationManager respondsToSelector:@selector(requestAlwaysAuthorization)]) {
        NSLog(@"requestAlwaysAuthorization");
        [locationManager requestWhenInUseAuthorization];
    }
    [locationManager startUpdatingLocation];
    
    [self refreshWithCache:YES];
}

-(void)goToSearch
{
    if (searchVc==nil) {
        searchVc=[[UIStoryboard storyboardWithName:@"Store" bundle:nil]instantiateViewControllerWithIdentifier:@"StoreSearchViewController"];
    }
    [self.navigationController pushViewController:searchVc animated:YES];
}

-(void)refresh
{
    [self refreshWithCache:NO];
}

-(void)refreshWithCache:(BOOL)cache
{
    [HomeHttpTool getAdversType:2 success:^(NSArray *datasource) {
        advsArray=[NSMutableArray arrayWithArray:datasource];
        NSMutableArray* pics=[NSMutableArray array];
        for (BaseModel* ad in advsArray) {
            NSString* th=ad.thumb;
            NSString* fu=[ZZUrlTool fullUrlWithTail:th];
            [pics addObject:fu];
        }
        [self setAdvertiseHeaderViewWithPicturesUrls:pics];
    } isCache:cache];
    
    NSDictionary* loca=[[NSUserDefaults standardUserDefaults]valueForKey:UserLastLocationKey];
    
    currentLng=[loca valueForKey:UserLastLocationLongitudeKey];
    currentLat=[loca valueForKey:UserLastLocationLatitudeKey];
    
    [StoreHttpTool getNeighbourStoreListPage:1 lng:currentLng lat:currentLat mult:5 success:^(NSArray *datasource) {
        [self.dataSource removeAllObjects];
        [self.dataSource addObjectsFromArray:datasource];
        [self tableViewReloadData];
        [self stopRefreshAfterSeconds];
        //        if (self.dataSource.count>0) {
        //            self.currentPage=1;
        //        }
    } isCache:cache];
}

//-(void)loadMore
//{
//    [StoreHttpTool getNeighbourStoreListPage:1+self.currentPage lng:@"" lat:@"" mult:5 success:^(NSArray *datasource) {
//        [self.dataSource addObjectsFromArray:datasource];
//        [self tableViewReloadData];
//        if (datasource.count>0) {
//            self.currentPage++;
//        }
//        self.shouldLoadMore=datasource.count>=self.pageSize;
//        
//    } isCache:YES];
//}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==0) {
        return 100;
    }
    return UITableViewAutomaticDimension;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section==0) {
        return 1;
    }
    else if(section==1)
    {
        return self.dataSource.count+1;
    }
    return 0;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==0) {
        ButtonsCell* c=[tableView dequeueReusableCellWithIdentifier:@"TopButtonsCell" forIndexPath:indexPath];
        c.delegate=self;
        c.buttonsTitles=[NSArray arrayWithObjects:@"服务项目",@"搜索门店",@"申请开店",@"门店地图", nil];
        c.buttonsImageNames=[NSArray arrayWithObjects:@"store_project",@"store_search",@"store_Shop",@"store_map", nil];
        return c;
    }
    else if(indexPath.section==1)
    {
        if (indexPath.row==0) {
            UITableViewCell* c=[tableView dequeueReusableCellWithIdentifier:@"StoreHeaderCell" forIndexPath:indexPath];
            return c;
        }
        else
        {
            StoreSmallCell* c=[tableView dequeueReusableCellWithIdentifier:@"StoreSmallCell" forIndexPath:indexPath];
            StoreModel* m=[self.dataSource objectAtIndex:indexPath.row-1];
            c.storeAddress.text=m.store_address;
            c.storeContact.text=[NSString stringWithFormat:@"%@/%@",m.store_author,m.store_tel];
            c.storeName.text=m.store_title;
            [c.storeImage sd_setImageWithURL:[m.thumb urlWithMainUrl]];
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
    
    if (indexPath.section==1) {
        if (indexPath.row==0) {
            StoreAllViewController* all=[[UIStoryboard storyboardWithName:@"Store" bundle:nil]instantiateViewControllerWithIdentifier:@"StoreAllViewController"];
            all.lat=currentLat;
            all.lng=currentLng;
            [self.navigationController pushViewController:all animated:YES];
        }
    }
}

-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations
{
    CLLocation* location=[locations lastObject];
    CLLocationCoordinate2D coor=location.coordinate;
    
    NSMutableDictionary* locaDic=[NSMutableDictionary dictionary];
    currentLat=[[NSNumber numberWithDouble:coor.latitude]stringValue];
    currentLng=[[NSNumber numberWithDouble:coor.longitude]stringValue];

    [locaDic setValue:currentLat forKey:UserLastLocationLatitudeKey];
    [locaDic setValue:currentLng forKey:UserLastLocationLongitudeKey];
    [[NSUserDefaults standardUserDefaults]setValue:locaDic forKey:UserLastLocationKey];
    
    [manager stopUpdatingLocation];
}

-(void)buttonsCell:(ButtonsCell *)cell didClickedIndex:(NSInteger)index
{
    if (index==0) {
        StoreObjectsViewController* ob=[[StoreObjectsViewController alloc]initWithCollectionViewLayout:[[UICollectionViewFlowLayout alloc]init]];
        [self.navigationController pushViewController:ob animated:YES];
    }
    else if(index==1)
    {
        [self goToSearch];
    }
}

@end
