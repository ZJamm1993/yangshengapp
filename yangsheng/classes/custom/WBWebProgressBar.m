//
//  WBWebProgressBar.m
//  WBWebProgressBar
//
//  Created by Jamm on 16/1/20.
//  Copyright © 2016年 Jamm. All rights reserved.
//

#import "WBWebProgressBar.h"

#define START_VALUE 0.0
#define PREPARED_VALUE 0.1
#define LOADING_VALUE 0.8
#define COMPLETED_VALUE 1.0

@implementation WBWebProgressBar
{
    UIProgressView* progressA; //first progress
    UIProgressView* progressB; //second progress
}
-(id)initWithFrame:(CGRect)frame
{
    self=[super initWithFrame:frame];
    if(self)
    {
        progressA=[[UIProgressView alloc]initWithFrame:CGRectMake(0,0,frame.size.width,frame.size.height)];
        progressA.trackTintColor=[UIColor clearColor];
        [self addSubview:progressA];
        
        progressB=[[UIProgressView alloc]initWithFrame:CGRectMake(0,0,frame.size.width,frame.size.height)];
        progressB.trackTintColor=[UIColor clearColor];
        [self addSubview:progressB];
    }
    return self;
}

-(void)setProgressTintColor:(UIColor *)progressTintColor
{
    _progressTintColor=progressTintColor;
    progressA.progressTintColor=_progressTintColor;
    progressB.progressTintColor=_progressTintColor;
}

-(void)WBWebProgressPreparing
{
    progressA.alpha=1;
    progressB.alpha=1;
    [progressA setProgress:START_VALUE animated:NO];
    [progressB setProgress:START_VALUE animated:NO];
    
    [progressA setProgress:PREPARED_VALUE animated:YES];
}

-(void)WBWebProgressStartLoading
{
    progressA.alpha=1;
    progressB.alpha=1;
    
    [UIView animateWithDuration:7.5 delay:0 options:0 animations:^{
        [progressA setProgress:LOADING_VALUE animated:YES];
    } completion:nil];
}

-(void)WBWebProgressCompleted
{
    CGFloat time=0.5;
    [UIView animateWithDuration:time delay:0 options:0 animations:^{
        [progressB setProgress:COMPLETED_VALUE animated:YES];
    } completion:^(BOOL finish)
     {
         
     }];
    [progressA performSelector:@selector(setAlpha:) withObject:0 afterDelay:time];
    [UIView animateWithDuration:0.5 delay:time options:0 animations:^{
        progressB.alpha=0;
    } completion:nil];
}

@end
