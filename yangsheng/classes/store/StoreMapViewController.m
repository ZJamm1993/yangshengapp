//
//  StoreMapViewController.m
//  yangsheng
//
//  Created by jam on 17/7/16.
//  Copyright © 2017年 jam. All rights reserved.
//

#import "StoreMapViewController.h"
#import "StoreMapAnnotation.h"
#import "StoreAnnotationView.h"
#import <MAMapKit/MAMapkit.h>
#import <AMapSearchKit/AMapSearchKit.h>

#import "ZZNaviMapSelectionViewController.h"

@interface StoreMapViewController ()<MAMapViewDelegate,AMapSearchDelegate,StoreAnnotationViewDelegate>
{
    MACoordinateRegion region;
    MAMapView* map;
    MAUserLocationRepresentation* userLocationRepresentation;
    AMapSearchAPI* search;
    BOOL moved;
}
@end

@implementation StoreMapViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title=@"门店地图";
    
    map=[[MAMapView alloc]initWithFrame:self.view.bounds];

//    double zoomFloat=30;
//    region=MACoordinateRegionMake(self.center, MACoordinateSpanMake(zoomFloat,zoomFloat));
//    [map setRegion:region animated:YES];
    
    map.delegate=self;
    map.showsUserLocation=YES;
//    map.showsCompass=YES;
    map.rotateCameraEnabled=NO;
//    map.compassOrigin=CGPointMake(map.compassOrigin.x, map.compassOrigin.y+64);
    
    //先显示中国区域
    MACoordinateSpan span = MACoordinateSpanMake(50, 62);
    CLLocationCoordinate2D coordinate = CLLocationCoordinate2DMake(28, 104);
    MACoordinateRegion regoin = MACoordinateRegionMake(coordinate, span);
    map.region = regoin;
    
    userLocationRepresentation=[[MAUserLocationRepresentation alloc]init];
    [map updateUserLocationRepresentation:userLocationRepresentation];
    
    [self.view addSubview:map];
    
    
    // Do any additional setup after loading the view.
//    return;
    
    if (self.presetShops.count>0) {
        [map removeAnnotations:map.annotations];
        NSArray* anns=[self annotionsFromStores:self.presetShops];
        [map addAnnotations:anns];
    }
    else
    {
        [StoreHttpTool getAllStoreMapListSuccess:^(NSArray *data) {
            self.presetShops=data;
            NSArray* annotations=[self annotionsFromStores:self.presetShops];
            [map removeAnnotations:map.annotations];
            [map addAnnotations:annotations];
        } isCache:NO];
    }
    
}

-(NSArray*)annotionsFromStores:(NSArray*)stores
{
    NSMutableArray* an=[NSMutableArray array];
    for (StoreModel* m in stores) {
        StoreMapAnnotation* ma=[[StoreMapAnnotation alloc]init];
        double lat=m.lat.doubleValue;
        double lng=m.lng.doubleValue;
        ma.title=m.store_title;
        ma.subtitle=m.store_address;
        ma.coordinate=CLLocationCoordinate2DMake(lat, lng);
        [an addObject:ma];
    }
    return an;
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    map.frame=self.view.bounds;
}

//-(void)viewWillDisappear:(BOOL)animated
//{
//    [super viewWillDisappear:animated];
//    [self refreshMap];
//    map.delegate=nil;
//    [map removeFromSuperview];
//}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)dealloc
{
    map.delegate=nil;
    [map removeFromSuperview];
}

//-(void)refreshMap
//{
////    map.mapType=MKMapTypeHybrid;
////    map.mapType=MKMapTypeStandard;
//}

-(void)mapView:(MAMapView *)mapView didUpdateUserLocation:(MAUserLocation *)userLocation updatingLocation:(BOOL)updatingLocation
{
    if (moved==NO) {
        CLLocationCoordinate2D userCenter = userLocation.location.coordinate;
        
        // 设置区域跨度
        double s=0;
        MACoordinateSpan span = MACoordinateSpanMake(s,s);
        CLLocationCoordinate2D center=userCenter;
        if (self.presetShops.count>0) {
            
            NSArray* ans=map.annotations;
            StoreMapAnnotation* firsan=[ans firstObject];
            
            double min_lat=firsan.coordinate.latitude;
            double min_lng=firsan.coordinate.longitude;
            
            double max_lat=min_lat;
            double max_lng=min_lng;
            
            for (StoreMapAnnotation* an in ans) {
                double lat=an.coordinate.latitude;
                double lng=an.coordinate.longitude;
                
                if (lat<min_lat) {
                    min_lat=lat;
                }
                if (lat>max_lat) {
                    max_lat=lat;
                }
                if (lng<min_lng) {
                    min_lng=lng;
                }
                if (lng>max_lng) {
                    max_lng=lng;
                }
            }
            
            double lat=center.latitude;
            double lng=center.longitude;
            
            if (lat<min_lat) {
                min_lat=lat;
            }
            if (lat>max_lat) {
                max_lat=lat;
            }
            if (lng<min_lng) {
                min_lng=lng;
            }
            if (lng>max_lng) {
                max_lng=lng;
            }
            
            center.latitude=(min_lat+max_lat)/2;
            center.longitude=(min_lng+max_lng)/2;
            
            span.latitudeDelta=fabs(min_lat-max_lat)*2;
            span.longitudeDelta=fabs(min_lng-max_lng)*2;
            
            moved=YES;
            
            if (self.presetShops.count==1) {
                //open search api
                if (search==nil) {
                    search = [[AMapSearchAPI alloc] init];
                    search.delegate = self;
                }
                
                NSArray* anis=[self annotionsFromStores:self.presetShops];
                id<MAAnnotation> ano=[anis firstObject];
                
                AMapDrivingRouteSearchRequest *navi = [[AMapDrivingRouteSearchRequest alloc] init];
                
                navi.requireExtension = YES;
                navi.strategy = 5;
                
                /* 出发点. */
                navi.origin = [AMapGeoPoint locationWithLatitude:userCenter.latitude longitude:userCenter.longitude];
                /* 目的地. */
                navi.destination = [AMapGeoPoint locationWithLatitude:ano.coordinate.latitude longitude:ano.coordinate.longitude];
                [search AMapDrivingRouteSearch:navi];
            }
        }
        
        // 创建一个区域
        MACoordinateRegion regn = MACoordinateRegionMake(center, span);
        // 设置地图显示区域
        [mapView setRegion:regn animated:NO];
    }
}

-(void)selectTheOnlyAnnotation
{
    if (self.presetShops.count==1) {
        NSArray* anns=[self annotionsFromStores:self.presetShops];
        [map selectAnnotation:anns.firstObject animated:NO];
    }
}

-(MAAnnotationView*)mapView:(MAMapView *)mapView viewForAnnotation:(id<MAAnnotation>)annotation
{
    if ([annotation isKindOfClass:[MAUserLocation class]]) {
        return nil;
    }
    else if([annotation isKindOfClass:[StoreMapAnnotation class]])
    {
        
        NSString* idd=@"mmmm";
        StoreAnnotationView* view=(StoreAnnotationView*)[map dequeueReusableAnnotationViewWithIdentifier:idd];
        if (view==nil) {
            view=[[StoreAnnotationView alloc]initWithAnnotation:annotation reuseIdentifier:idd];
        }
        view.delegate=self;
        return view;
    }
    
    return nil;
}

- (MAOverlayRenderer *)mapView:(MAMapView *)mapView rendererForOverlay:(id <MAOverlay>)overlay
{
    if ([overlay isKindOfClass:[MAPolyline class]])
    {
        MAPolylineRenderer *polylineRenderer = [[MAPolylineRenderer alloc] initWithPolyline:overlay];
        
        polylineRenderer.lineWidth    = 8.f;
        polylineRenderer.strokeColor  = [UIColor colorWithRed:0 green:0 blue:1 alpha:0.6];
        polylineRenderer.lineJoinType = kMALineJoinRound;
        polylineRenderer.lineCapType  = kMALineCapRound;
        
        return polylineRenderer;
    }
    return nil;
}

-(void)onRouteSearchDone:(AMapRouteSearchBaseRequest *)request response:(AMapRouteSearchResponse *)response
{
    if(response.count>0)
    {
        AMapPath* path=[response.route.paths firstObject];
        NSInteger count=path.steps.count;
        CLLocationCoordinate2D* cs=[self coordinatesWithPath:path count:count];
        
//        for (int i=0; i<count; i++) {
//            CLLocationCoordinate2D co=cs[i];
//            NSLog(@"%f,%f",co.latitude,co.longitude);
//        }
        
        MAPolyline* poly=[MAPolyline polylineWithCoordinates:cs count:count];
        [map addOverlay:poly];
        free(cs);
        cs=NULL;
        
        [self performSelector:@selector(selectTheOnlyAnnotation) withObject:nil afterDelay:1];
    }
}

-(CLLocationCoordinate2D*)coordinatesWithPath:(AMapPath*)path count:(NSInteger)count
{
    CLLocationCoordinate2D* coos=malloc(count*sizeof(CLLocationCoordinate2D));
    
    for (int i=0; i<count; i++) {
        AMapStep* step=[path.steps objectAtIndex:i];
        NSString* li=step.polyline;
        NSArray* coStrs=[li componentsSeparatedByString:@";"];
        NSString* coStr=[coStrs firstObject];
        NSArray* latLng=[coStr componentsSeparatedByString:@","];
        double lat=[latLng.lastObject doubleValue];
        double lng=[latLng.firstObject doubleValue];
        CLLocationCoordinate2D coooo=CLLocationCoordinate2DMake(lat, lng);
        coos[i]=coooo;
    }
    
    return coos;
}

-(void)storeAnnotationView:(StoreAnnotationView *)annotationView didClickNaviButton:(UIButton *)naviButton
{
    [self askToNaviMapWithAnnotation:annotationView.annotation];
}

-(void)askToNaviMapWithAnnotation:(id<MAAnnotation>)annotation
{
    if ([annotation isKindOfClass:[StoreMapAnnotation class]]) {
        StoreMapAnnotation* ano=(StoreMapAnnotation*)annotation;
        ZZNaviMapSelectionViewController* selection=[ZZNaviMapSelectionViewController naviAlertControllerWithTargetName:ano.title targetCoordinate:ano.coordinate];
        [self presentViewController:selection animated:YES completion:nil];
    }
}

@end
