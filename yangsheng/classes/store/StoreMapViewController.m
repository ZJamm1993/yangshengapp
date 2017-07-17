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

@interface StoreMapViewController ()<MKMapViewDelegate>
{
    MKCoordinateRegion region;
    MKMapView* map;
    
    NSArray* storeList;
    NSArray* annotations;
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
        
        [map addAnnotations:annotations];
    } isCache:NO];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    map.frame=self.view.bounds;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation
{
    
}

-(MKAnnotationView*)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation
{
    NSString* idd=@"mmmm";
    MKAnnotationView* view=[map dequeueReusableAnnotationViewWithIdentifier:idd];
    if (view==nil) {
        view=[[MKAnnotationView alloc]initWithAnnotation:annotation reuseIdentifier:idd];
    }
    view.image=[UIImage imageNamed:@"position"];
    return view;
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
