//
//  NothingWarningView.m
//  yangsheng
//
//  Created by Macx on 17/7/20.
//  Copyright © 2017年 jam. All rights reserved.
//

#import "NothingWarningView.h"

@implementation NothingWarningView

+(instancetype)nothingViewWithWarning:(NSString *)str
{
    NothingWarningView* not=[[[UINib nibWithNibName:@"NothingWarningView" bundle:nil]instantiateWithOwner:nil options:nil]firstObject];
    not.frame=[[UIScreen mainScreen]bounds];
    not.label.text=str;
    
    return not;
}

@end
