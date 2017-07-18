//
//  StoreMapViewController.m
//  yangsheng
//
//  Created by jam on 17/7/16.
//  Copyright © 2017年 jam. All rights reserved.
//

#import "StoreMapViewController.h"
#import "StoreHttpTool.h"
#import "StoreMapAnnotation.h"
#import "StoreAnnotationView.h"

@interface StoreMapViewController ()<MKMapViewDelegate>
{
    MKCoordinateRegion region;
    MKMapView* map;
    
    NSArray* storeList;
    NSArray* annotations;
    
//    NSTimer* timeer;
    BOOL moved;
}
@end

@implementation StoreMapViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title=@"门店地图";
    
    map=[[MKMapView alloc]initWithFrame:self.view.bounds];

    double zoomFloat=30;
    region=MKCoordinateRegionMake(self.center, MKCoordinateSpanMake(zoomFloat,zoomFloat));
    [map setRegion:region animated:YES];
    
    map.delegate=self;
    map.showsUserLocation=YES;
    
//    map.showsScale=YES;
//    map.showsCompass=YES; //ios9
    
    [self.view addSubview:map];
    
    
    // Do any additional setup after loading the view.
    
    [StoreHttpTool getAllStoreMapListSuccess:^(NSArray *data) {
        storeList=data;
        NSMutableArray* an=[NSMutableArray array];
        for (StoreModel* m in storeList) {
            StoreMapAnnotation* ma=[[StoreMapAnnotation alloc]init];
            double lat=m.lat.doubleValue;
            double lng=m.lng.doubleValue;
            ma.title=m.store_title;
            ma.subtitle=m.store_address;
            ma.coordinate=CLLocationCoordinate2DMake(lat, lng);
            [an addObject:ma];
        }
        annotations=an;
        [map removeAnnotations:map.annotations];
        [map addAnnotations:annotations];
    } isCache:NO];
    
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    map.frame=self.view.bounds;
}

-(void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    [self refreshMap];
    // Dispose of any resources that can be recreated.
}

-(void)dealloc
{
    map.delegate=nil;
    [map removeFromSuperview];
}

-(void)refreshMap
{
    map.mapType=MKMapTypeHybrid;
    map.mapType=MKMapTypeStandard;
}

-(void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation
{
    if (moved==NO) {
        
        CLLocationCoordinate2D center = userLocation.location.coordinate;
        
        // 设置区域跨度
        MKCoordinateSpan span = MKCoordinateSpanMake(20, 20);
        
        // 创建一个区域
        MKCoordinateRegion regn = MKCoordinateRegionMake(center, span);
        // 设置地图显示区域
        [mapView setRegion:regn animated:YES];
    }
    moved=YES;
}

-(MKAnnotationView*)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation
{
    if([annotation isKindOfClass:[MKUserLocation class]])
    {
        NSString* idd=@"userlocation";
        MKPinAnnotationView* view=(MKPinAnnotationView*)[map dequeueReusableAnnotationViewWithIdentifier:idd];
        if (view==nil) {
            view=[[MKPinAnnotationView alloc]initWithAnnotation:annotation reuseIdentifier:idd];
//            view.pinTintColor=[UIColor blueColor];
            view.canShowCallout=YES;
        }
        return view;
    }
    else if([annotation isKindOfClass:[StoreMapAnnotation class]])
    {
        
        NSString* idd=@"mmmm";
        StoreAnnotationView* view=(StoreAnnotationView*)[map dequeueReusableAnnotationViewWithIdentifier:idd];
        if (view==nil) {
            view=[[StoreAnnotationView alloc]initWithAnnotation:annotation reuseIdentifier:idd];
        }
        return view;
    }
    
    return nil;
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
