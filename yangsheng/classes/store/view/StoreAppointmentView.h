//
//  StoreAppointmentView.h
//  yangsheng
//
//  Created by Macx on 17/7/15.
//  Copyright © 2017年 jam. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger,AppointmentType)
{
    
    AppointmentTypeNormal,
    AppointmentTypePhone,
    AppointmentTypeCheck,
};

@class StoreAppointmentView;

@protocol StoreAppointmentViewDelegate <NSObject>

-(void)storeAppointmentView:(StoreAppointmentView*)view didSelectType:(AppointmentType)type;

@end

@interface StoreAppointmentView : UIView

@property (nonatomic,weak) id<StoreAppointmentViewDelegate>delegate;
+(instancetype)defaultAppointmentViewWithTypes:(NSArray*)types;

@end
