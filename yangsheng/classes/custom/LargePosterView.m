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
    imageView=[[UIImageView alloc]initWithFrame:self.bounds];
    [self addSubview:imageView];
    imageView.image=[UIImage imageNamed:self.imageName];
    
    largeBgButton=[[UIButton alloc]initWithFrame:self.bounds];
    [largeBgButton addTarget:self action:@selector(urlPress) forControlEvents:UIControlEventTouchUpInside];
    
}

-(void)urlPress
{
    
}

@end
