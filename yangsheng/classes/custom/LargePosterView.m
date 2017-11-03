//
//  LargePosterView.m
//  yangsheng
//
//  Created by bangju on 2017/11/2.
//  Copyright © 2017年 jam. All rights reserved.
//

#import "LargePosterView.h"

@implementation LargePosterView
{
    UIImageView* imageView;
    UIButton* largeBgButton;
    UIButton* smallCountDownButton;
    NSTimer* timer;
    NSInteger second;
}

+(instancetype)posterWithImageName:(NSString *)imageName url:(NSString *)url delegate:(id)delegate
{
    LargePosterView* pa=[[LargePosterView alloc]initWithFrame:[[UIScreen mainScreen]bounds]];
    pa.imageName=imageName;
    pa.url=url;
    pa.delegate=delegate;
    return pa;
}

-(instancetype)initWithFrame:(CGRect)frame
{
    self=[super initWithFrame:frame];
    if(self)
    {
        [self addViews];
    }
    return self;
}

-(void)setImageName:(NSString *)imageName
{
    _imageName=imageName;
    UIImage* img=[UIImage imageNamed:imageName];
    if (img) {
        imageView.image=img;
    }
    else
    {
        [imageView sd_setImageWithURL:[NSURL URLWithString:imageName]];
    }
}

-(void)addViews
{
    second=3;
    
    imageView=[[UIImageView alloc]initWithFrame:self.bounds];
    [self addSubview:imageView];
    imageView.image=[UIImage imageNamed:self.imageName];
    
    largeBgButton=[[UIButton alloc]initWithFrame:self.bounds];
    [largeBgButton addTarget:self action:@selector(urlPress) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:largeBgButton];
    
    UIView* sha=[[UIView alloc]initWithFrame:CGRectMake(self.frame.size.width-64, 20, 64, 64)];
    [self addSubview:sha];
    
    smallCountDownButton=[[UIButton alloc]initWithFrame:CGRectMake(0, 0, 32, 32)];
    smallCountDownButton.backgroundColor=[UIColor colorWithWhite:0 alpha:0.5];
    [smallCountDownButton setTitle:[NSString stringWithFormat:@"%ld",(long)second] forState:UIControlStateNormal];
    [smallCountDownButton.titleLabel setFont:[UIFont systemFontOfSize:13]];
    [smallCountDownButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [smallCountDownButton.layer setCornerRadius:16];
    smallCountDownButton.center=CGPointMake(sha.frame.size.width/2, sha.frame.size.height/2);
    [smallCountDownButton addTarget:self action:@selector(skip) forControlEvents:UIControlEventTouchUpInside];
    [sha addSubview:smallCountDownButton];
    
    timer=[NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(countDown) userInfo:nil repeats:YES];
    [timer setFireDate:[NSDate date]];
}

-(void)show
{
    [self removeFromSuperview];
    [[[UIApplication sharedApplication]keyWindow]addSubview:self];
}

-(void)hide
{
    [timer invalidate];
    [UIView animateWithDuration:0.25 animations:^{
        self.alpha=0;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

-(void)urlPress
{
    if ([self.delegate respondsToSelector:@selector(largePosterDidTappedUrl:)]) {
        [self.delegate largePosterDidTappedUrl:self.url];
    }
    [self hide];
}

-(void)skip
{
    [self hide];
}

-(void)countDown
{
    if (second==0) {
        [timer invalidate];
        [self hide];
        return;
    }
    [smallCountDownButton setTitle:[NSString stringWithFormat:@"%ld",(long)second] forState:UIControlStateNormal];
    second--;
    
}

-(void)dealloc
{
    [timer invalidate];
}

@end
