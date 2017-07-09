//
//  AdvertiseView.h
//  yangsheng
//
//  Created by Macx on 17/7/7.
//  Copyright © 2017年 jam. All rights reserved.
//

#import <UIKit/UIKit.h>

@class AdvertiseView;

@protocol AdvertiseViewDelegate <NSObject>

-(void)advertiseView:(AdvertiseView*)adver didSelectedIndex:(NSInteger)index;

@end

@interface AdvertiseView : UIView

+(instancetype)defaultAdvertiseView;
@property (nonatomic,weak) id<AdvertiseViewDelegate> delegate;
@property (nonatomic,strong) NSArray* picturesUrls;

@end
