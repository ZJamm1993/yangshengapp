//
//  BaseLoadMoreFooterView.m
//  yangsheng
//
//  Created by bangju on 2017/10/18.
//  Copyright © 2017年 jam. All rights reserved.
//

#import "BaseLoadMoreFooterView.h"

@implementation BaseLoadMoreFooterView
{
    UILabel* textLabel;
    UIActivityIndicatorView* indicatorView;
    UIButton* invisibleButton;
}

+(instancetype)defaultFooter
{
    BaseLoadMoreFooterView * lo=[[BaseLoadMoreFooterView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 44)];
    
    return lo;
}

-(instancetype)initWithFrame:(CGRect)frame
{
    self=[super initWithFrame:frame];
    if (self) {
        [self config];
    }
    return self;
}

-(void)config
{
    self.backgroundColor=[UIColor clearColor];
    
    textLabel=[[UILabel alloc]initWithFrame:self.bounds];
    textLabel.backgroundColor=[UIColor clearColor];
    textLabel.textColor=[UIColor lightGrayColor];
    textLabel.font=[UIFont systemFontOfSize:13];
    textLabel.textAlignment=NSTextAlignmentCenter;
    textLabel.text=@"加载更多";
    [self addSubview:textLabel];
    
    indicatorView=[[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    indicatorView.frame=self.bounds;
    [indicatorView setHidesWhenStopped:YES];
    [self addSubview:indicatorView];
    
    invisibleButton=[[UIButton alloc]initWithFrame:self.bounds];
    [invisibleButton addTarget:self action:@selector(goToLoadMore) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:invisibleButton];
    
    self.loading=NO;
}

-(void)goToLoadMore
{
    if (self.loading) {
        return;
    }
    if ([self.delegate respondsToSelector:@selector(loadMoreFooterViewShouldStartLoadMore:)]) {
        [self.delegate loadMoreFooterViewShouldStartLoadMore:self];
    }
}

-(void)setLoading:(BOOL)loading
{
    _loading=loading;
    textLabel.hidden=loading;
//    indicatorView.hidden=!loading;
    if(loading)
    {
        [indicatorView startAnimating];
    }
    else
    {
        [indicatorView stopAnimating];
    }
}

-(void)startLoading
{
    [self goToLoadMore];
}

-(void)endLoadingWithText:(NSString *)text
{
    self.loading=NO;
    textLabel.text=text;
}

@end
