//
//  ZZNaviMapSelectionViewController.h
//  yangsheng
//
//  Created by jam on 17/7/23.
//  Copyright © 2017年 jam. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

@interface ZZNaviMapSelectionViewController : UIAlertController

+(instancetype)naviAlertControllerWithTargetName:(NSString*)name targetCoordinate:(CLLocationCoordinate2D)coordinate;

@end
