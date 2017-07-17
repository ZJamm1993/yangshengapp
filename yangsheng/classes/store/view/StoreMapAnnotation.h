//
//  StoreMapAnnotation.h
//  yangsheng
//
//  Created by Macx on 17/7/17.
//  Copyright © 2017年 jam. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

@interface StoreMapAnnotation : NSObject<MKAnnotation>

@property (nonatomic,assign) CLLocationCoordinate2D coordinate;
@property (nonatomic,copy) NSString* title;
@property (nonatomic,copy) NSString* subtitle;

@end
