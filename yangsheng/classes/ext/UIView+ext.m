//
//  UIView+ext.m
//  yangsheng
//
//  Created by Macx on 17/7/9.
//  Copyright © 2017年 jam. All rights reserved.
//

#import "UIView+ext.h"

@implementation UIView (ext)

-(void)removeAllSubviews
{
    NSArray* arr=self.subviews;
    for (UIView* vi in arr) {
        [vi removeFromSuperview];
    }
}

@end
