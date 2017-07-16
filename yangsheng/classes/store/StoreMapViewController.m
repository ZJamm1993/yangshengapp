//
//  StoreMapViewController.m
//  yangsheng
//
//  Created by jam on 17/7/16.
//  Copyright © 2017年 jam. All rights reserved.
//

#import "StoreMapViewController.h"

@interface StoreMapViewController ()
{
    MKCoordinateRegion region;
    MKMapView* map;
}
@end

@implementation StoreMapViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title=@"门店地图";
    
    map=[[MKMapView alloc]initWithFrame:self.view.bounds];
    map.showsUserLocation=YES;
    map.showsScale=YES;
    map.showsCompass=YES;
    [self.view addSubview:map];
    // Do any additional setup after loading the view.
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    map.frame=self.view.bounds;
    
    double zoomFloat=0.1;
    region=MKCoordinateRegionMake(self.center, MKCoordinateSpanMake(zoomFloat,zoomFloat));
    [map setRegion:region animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
