//
//  AdvertiseView.m
//  yangsheng
//
//  Created by Macx on 17/7/7.
//  Copyright © 2017年 jam. All rights reserved.
//

#import "AdvertiseView.h"

const CGFloat advertiseViewAutoScrollTime=3.0;

@interface AdvertiseView()<UIScrollViewDelegate>
{
    NSTimer* timer;
    UIScrollView* scroll;
    UIPageControl* pageControl;
    UIView* shadow;
}
@end

@implementation AdvertiseView

+(instancetype)defaultAdvertiseView
{
    AdvertiseView* a=[[AdvertiseView alloc]initWithFrame:CGRectMake(0, 0, [[UIScreen mainScreen]bounds].size.width, [[UIScreen mainScreen]bounds].size.width*0.45)];
    a.backgroundColor=[UIColor lightGrayColor];
    return a;
}

-(void)setPicturesUrls:(NSArray *)picturesUrls
{
    if (!timer) {
        timer=[NSTimer scheduledTimerWithTimeInterval:advertiseViewAutoScrollTime target:self selector:@selector(scrollToNextPage) userInfo:nil repeats:YES];
        [timer setFireDate:[NSDate dateWithTimeIntervalSinceNow:advertiseViewAutoScrollTime]];
    }
    _picturesUrls=[NSArray arrayWithArray:picturesUrls];
    
    NSArray* subs=[self subviews];
    for (UIView* vi in subs) {
        [vi removeFromSuperview];
    }
    
    
    CGFloat w=self.bounds.size.width;
    CGFloat h=self.bounds.size.height;
    
    scroll=[[UIScrollView alloc]initWithFrame:self.bounds];
    
    scroll.scrollsToTop=NO;
    scroll.pagingEnabled=YES;
    scroll.showsHorizontalScrollIndicator=NO;
    scroll.showsVerticalScrollIndicator=NO;
    scroll.delegate=self;
    
    [self addSubview:scroll];
    
    for (int i=0; i<picturesUrls.count; i++) {
        
        UIImageView* img=[[UIImageView alloc]initWithFrame:CGRectMake(w*i, 0, w, h)];
        img.contentMode=UIViewContentModeScaleAspectFill;
        img.clipsToBounds=YES;
        [img sd_setImageWithURL:[NSURL URLWithString:[picturesUrls objectAtIndex:i]]];
        [scroll addSubview:img];
    }
    
    scroll.contentSize=CGSizeMake(w*picturesUrls.count, h);
    scroll.contentOffset=CGPointMake(0, 0);
    
    
    UIButton* btn=[[UIButton alloc]initWithFrame:CGRectMake(0, 0, scroll.contentSize.width, scroll.contentSize.height)];
    [btn addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    [scroll addSubview:btn];
    
    [self scrollToPage:0];
    
    
    
    pageControl=[[UIPageControl alloc]init];
    pageControl.numberOfPages=_picturesUrls.count;
    pageControl.pageIndicatorTintColor=[UIColor whiteColor];
    pageControl.currentPageIndicatorTintColor=pinkColor;
    pageControl.center=CGPointMake(w/2, h-20);
    [self addSubview:pageControl];
    
    if (picturesUrls.count<=1) {
        pageControl.hidden=YES;
    }
    
    shadow=[[UIView alloc]init];
    shadow.backgroundColor=[UIColor groupTableViewBackgroundColor];
    shadow.frame=CGRectMake(0, self.frame.size.height-0.5, self.frame.size.width, 0.5);
    [self addSubview:shadow];
}

-(void)buttonClick:(UIButton*)btn
{
    if (self.delegate) {
        if ([self.delegate respondsToSelector:@selector(advertiseView:didSelectedIndex:)]) {
            [self.delegate advertiseView:self didSelectedIndex:[self currentPage]];
        }
    }
}

-(void)scrollToPage:(NSInteger)page
{
//    NSLog(@"to %d",page);
    if (page>=_picturesUrls.count) {
        page=0;
    }
    CGFloat offx=scroll.frame.size.width*page;
    [scroll setContentOffset:CGPointMake(offx, 0) animated:YES];
    
//    pageControl.currentPage=page;
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    pageControl.currentPage=[self currentPage];
}

-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [timer setFireDate:[NSDate distantFuture]];
}

-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    [timer setFireDate:[NSDate dateWithTimeIntervalSinceNow:advertiseViewAutoScrollTime]];
}

-(NSInteger)currentPage
{
    return (NSInteger)(scroll.contentOffset.x/scroll.frame.size.width);
}

-(NSInteger)numbersOfPage
{
    return _picturesUrls.count;
}

-(void)scrollToNextPage
{
    NSInteger curr=[self currentPage];
    [self scrollToPage:curr+1];
}

-(void)dealloc
{
    scroll.delegate=nil;
    [timer invalidate];
    NSLog(@"adver deal");
}

@end
