//
//  PickerShadowContainer.h
//  yangsheng
//
//  Created by Macx on 17/7/20.
//  Copyright © 2017年 jam. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PickerShadowContainer : UIView

@property (nonatomic,copy) void(^completionBlock)();

+(void)showPickerContainerWithView:(UIView*)view;

+(void)showPickerContainerWithView:(UIView *)view completion:(void(^)())completion;

@end
