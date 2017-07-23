//
//  StoreAnnotationView.h
//  yangsheng
//
//  Created by Macx on 17/7/18.
//  Copyright © 2017年 jam. All rights reserved.
//

#import <MapKit/MapKit.h>
#import <MAMapKit/MAMapkit.h>

@class StoreAnnotationView;

@protocol StoreAnnotationViewDelegate <NSObject>

-(void)storeAnnotationView:(StoreAnnotationView*)annotationView didClickNaviButton:(UIButton*)naviButton;

@end

@interface StoreAnnotationView : MAAnnotationView

@property (nonatomic,weak) id<StoreAnnotationViewDelegate>delegate;

@end
