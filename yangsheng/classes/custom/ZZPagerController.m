//
//  CustomPagerController.m
//  TYPagerControllerDemo
//
//  Created by tany on 16/5/17.
//  Copyright © 2016年 tanyang. All rights reserved.
//

#import "ZZPagerController.h"

@interface ZZPagerController ()<UIScrollViewDelegate,ZZPagerMenuDatasource,ZZPagerMenuDelegate>
{
    UIScrollView* contentView;
    ZZPagerMenu* menuView;
    CGRect menuFrame;
    CGRect contentFrame;
    NSInteger childrenCount;
    NSMutableArray* controllers;
    NSMutableArray* titles;
}
@end

@implementation ZZPagerController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets=NO;
    
    controllers=[NSMutableArray array];
    titles=[NSMutableArray array];
    
    contentView=[[UIScrollView alloc]init];
    contentView.pagingEnabled=YES;
    contentView.showsHorizontalScrollIndicator=NO;
    contentView.showsVerticalScrollIndicator=NO;
    contentView.bounces=YES;
    contentView.alwaysBounceHorizontal=YES;
    contentView.alwaysBounceVertical=NO;
    contentView.scrollsToTop=NO;
    contentView.delegate=self;
    [self.view addSubview:contentView];
    
    menuView=[[ZZPagerMenu alloc]init];
    menuView.dataSource=self;
    menuView.delegate=self;
    menuView.selectedColor=[UIColor colorWithRed:1 green:0.5 blue:0.5 alpha:1];
    menuView.normalColor=[UIColor colorWithRed:0.5 green:0.5 blue:0.5 alpha:1];
    menuView.backgroundColor=[UIColor whiteColor];
    [self.view addSubview:menuView];
}

-(void)setMenuNormalColor:(UIColor *)menuNormalColor
{
    _menuNormalColor=menuNormalColor;
    menuView.normalColor=_menuNormalColor;
}

-(void)setMenuSelectedColor:(UIColor *)menuSelectedColor
{
    _menuSelectedColor=menuSelectedColor;
    menuView.selectedColor=_menuSelectedColor;
}

-(void)setDataSource:(id<ZZPagerControllerDataSource>)dataSource
{
    _dataSource=dataSource;
    [self refreshSubviews];
}

-(void)refreshSubviews
{
    menuFrame=CGRectMake(0, 0, 0, 0);
    contentFrame=self.view.bounds;
    
    if(self.dataSource) {
        if ([self.dataSource respondsToSelector:@selector(pagerController:frameForMenuView:)]) {
            menuFrame=[self.dataSource pagerController:self frameForMenuView:menuView];
        }
        if ([self.dataSource respondsToSelector:@selector(pagerController:frameForContentView:)]) {
            contentFrame=[self.dataSource pagerController:self frameForContentView:contentView];
        }
        
        
        if ([self.dataSource respondsToSelector:@selector(numbersOfChildControllersInPagerController:)]) {
            childrenCount=[self.dataSource numbersOfChildControllersInPagerController:self];
            [controllers removeAllObjects];
            [titles removeAllObjects];
            for (int i=0; i<childrenCount; i++) {
                if ([self.dataSource respondsToSelector:@selector(pagerController:titleAtIndex:)]) {
                    NSString* ti=[self.dataSource pagerController:self titleAtIndex:i];
                    if (!ti) {
                        ti=@"";
                    }
                    if (ti) {
                        [titles addObject:ti];
                    }
                }
                if ([self.dataSource respondsToSelector:@selector(pagerController:viewControllerAtIndex:)]) {
                    UIViewController* vc=[self.dataSource pagerController:self viewControllerAtIndex:i];
                    if (!vc) {
                        vc=[[UIViewController alloc]init];
                    }
                    if (vc) {
                        [controllers addObject:vc];
                    }
                }
            }
        }
    }
    
    if (childrenCount!=controllers.count) {
        return;
    }
    if (childrenCount!=titles.count) {
        return;
    }
    
    menuView.frame=menuFrame;
    contentView.frame=contentFrame;
    
    contentView.contentSize=CGSizeMake(contentFrame.size.width*childrenCount, 0);
    NSArray* ch=contentView.subviews;
    for (UIView* ci in ch) {
        [ci removeFromSuperview];
    }
    for (UIViewController* vc in controllers) {
        [vc removeFromParentViewController];
    }
    
    for (int i=0; i<childrenCount; i++) {
        
        UIViewController* vc=[controllers objectAtIndex:i];
        if (!vc.parentViewController) {
            [self addChildViewController:vc];
            
            UIView* vi=vc.view;
            vi.frame=CGRectMake(contentFrame.size.width*i, 0, contentFrame.size.width, contentFrame.size.height);
            vi.autoresizingMask=UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
            [vi removeFromSuperview];
            [contentView addSubview:vi];
            if (i==0) {
                vi.userInteractionEnabled=YES;
            }
            else {
                vi.userInteractionEnabled=NO;
                vi.hidden=YES;
            }
            
            [vc didMoveToParentViewController:self];
        }
    }
    
    menuView.dataSource=self;
    menuView.delegate=self;
}

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    if (scrollView==contentView) {
        NSInteger index=[self pageIndexForScrollView:scrollView];
        for (int i=0;i<controllers.count;i++) {
            UIViewController* vc=[controllers objectAtIndex:i];
            BOOL isThat=(index==i);
            vc.view.userInteractionEnabled=isThat;
            vc.view.hidden=!isThat;
        }
    }
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    
    
    if (scrollView==contentView) {
//        NSInteger index=[self pageIndexForScrollView:scrollView];
//        NSLog(@"didScroll:%d",index);
        for (UIViewController* vc in controllers) {
            vc.view.hidden=NO;
        }
        
//        if (scrollView.isDragging) {
            CGFloat pagefloat=scrollView.contentOffset.x/scrollView.frame.size.width;
            menuView.currentPage=pagefloat;
//        }
    }
}

-(NSInteger)pageIndexForScrollView:(UIScrollView*)scrollView
{
    CGFloat offx=scrollView.contentOffset.x;
    NSInteger index=(offx+scrollView.frame.size.width/2)/(scrollView.frame.size.width);
    return index;
}

-(NSInteger)numbersOfTitlesForMenu:(ZZPagerMenu *)menu
{
    return titles.count;
}

-(NSString*)pagerMenu:(ZZPagerMenu *)menu titleAtIndex:(NSInteger)index
{
    return [titles objectAtIndex:index];
}

-(void)pagerMenu:(ZZPagerMenu *)menu didSelectAtIndex:(NSInteger)index
{
    CGFloat offx=index*contentView.frame.size.width;
    [contentView setContentOffset:CGPointMake(offx, 0) animated:YES];
}

@end











@interface ZZPagerMenu()
{
    NSInteger titleCount;
    NSMutableArray* titles;
    UIView* bg;
    UIView* line;
    BOOL shouldManualAnimation;
    NSMutableArray* btns;
}
@end

@implementation ZZPagerMenu

-(void)setDataSource:(id<ZZPagerMenuDatasource>)dataSource
{
    _dataSource=dataSource;
    [self refreshSubviews];
    [self clickingChangePage:0];
}

-(void)refreshSubviews
{
//    if (!bg) {
//        bg=[[UIVisualEffectView alloc]initWithEffect:[UIBlurEffect effectWithStyle:UIBlurEffectStyleExtraLight]];
//        [self addSubview:bg];
//    }
    
    if (!line) {
        line=[[UIView alloc]init];
        line.backgroundColor=self.selectedColor;
        [self addSubview:line];
    }
    
    if(!titles){
        titles=[NSMutableArray array];
    }
    
    if (!btns) {
        btns=[NSMutableArray array];
    }
    
//    bg.frame=self.bounds;
    
    for (UIView* vi in btns) {
        [vi removeFromSuperview];
    }
    [btns removeAllObjects];
    
    [titles removeAllObjects];
    
    if (self.dataSource) {
        if ([self.dataSource respondsToSelector:@selector(numbersOfTitlesForMenu:)]) {
            titleCount=[self.dataSource numbersOfTitlesForMenu:self];
        }
        
        if ([self.dataSource respondsToSelector:@selector(pagerMenu:titleAtIndex:)]) {
            for (int i=0;i<titleCount;i++) {
                NSString* ti=[self.dataSource pagerMenu:self titleAtIndex:i];
                if (!ti) {
                    ti=@"";
                }
                if (ti) {
                    [titles addObject:ti];
                }
            }
        }
    }
    
    if (titleCount!=titles.count) {
        return;
    }
    
    CGFloat bw=self.frame.size.width/titleCount;
    
    for (int i=0; i<titleCount; i++) {
        NSString* ti=[titles objectAtIndex:i];
        
        UIButton* btn=[[UIButton alloc]initWithFrame:self.bounds];
        [btn setTitle:ti forState:UIControlStateNormal];
        btn.titleLabel.font=[UIFont systemFontOfSize:15];
        [btn setTitleColor:self.normalColor forState:UIControlStateNormal];
        [btn setTitleColor:self.selectedColor forState:UIControlStateSelected];
        btn.tag=i;
        [btn sizeToFit];
        [btn addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        btn.center=CGPointMake(i*bw+bw/2, self.frame.size.height/2);
        [self addSubview:btn];
        [btns addObject:btn];
    }
}

-(void)clickingChangePage:(NSInteger)page
{
    [self selectedButtonAtIndex:page];
    if (page>=titleCount) {
        return;
    }
    
    if (line) {
        UIView* v=[btns objectAtIndex:page];
        CGFloat h=2;
        CGFloat y=self.frame.size.height-h;
        CGFloat w=v.frame.size.width;
        CGFloat x=v.frame.origin.x;
        shouldManualAnimation=NO;
        [UIView animateWithDuration:0.25 animations:^{
            line.frame=CGRectMake(x, y, w, h);
        } completion:^(BOOL finished) {
            shouldManualAnimation=YES;
        }];
    }
}

-(void)buttonClick:(UIButton*)btn
{
    NSInteger tag=btn.tag;
    [self clickingChangePage:tag];
    if (self.delegate) {
        if ([self.delegate respondsToSelector:@selector(pagerMenu:didSelectAtIndex:)]) {
            [self.delegate pagerMenu:self didSelectAtIndex:tag];
        }
    }
}

-(void)selectedButtonAtIndex:(NSInteger)index
{
    for (int i=0;i<btns.count;i++) {
        UIButton* bb=[btns objectAtIndex:i];
        bb.selected=(i==index);
    }
}

-(void)setCurrentPage:(CGFloat)currentPage
{
//    _currentPage=currentPage;
//    NSLog(@"%f",currentPage);
//    
//    NSLog(@"int %d",(int)-1.2);
    
    if (!shouldManualAnimation) {
        return;
    }
//    if (currentPage<0) {
//        currentPage=currentPage-1;
//    }
    
    CGFloat index=(CGFloat)((NSInteger)currentPage);
    if (currentPage<0) {
        index=index-1;
    }
    CGFloat percent=currentPage-index;
    
    CGRect min=CGRectMake(0, 0, 0, 0);
    CGRect max=CGRectMake(self.frame.size.width, 0, 0, 0);
    
    UIView* left=nil;
    if (index>=0&&index<btns.count) {
        left=[btns objectAtIndex:index];
    }
    UIView* right=nil;
    if (index+1>=0&&index+1<btns.count) {
        right=[btns objectAtIndex:index+1];
    }
    
    CGFloat x=min.origin.x;
    CGFloat width=min.size.width;
    
//    if (!left) {
//        left=[[UIView alloc]initWithFrame:min];
//    }
    if (left) {
        x=left.frame.origin.x;
        width=left.frame.size.width;
    }
    
    if (!right) {
        right=[[UIView alloc]initWithFrame:max];
    }
    
    if (right) {
        x=x+(right.frame.origin.x-x)*percent;
        width=width+(right.frame.size.width-width)*percent;
    }
    
    BOOL leftHeight=(percent<0.5);
    if ([left isKindOfClass:[UIButton class]]) {
        UIButton* lb=(UIButton*)left;
        lb.selected=leftHeight;
    }
    if ([right isKindOfClass:[UIButton class]]) {
        UIButton* rb=(UIButton*)right;
        rb.selected=!leftHeight;
    }
    
    CGRect fr=line.frame;
    fr.origin.x=x;
    fr.size.width=width;
    line.frame=fr;
}

-(void)setSelectedColor:(UIColor *)selectedColor
{
    _selectedColor=selectedColor;
    
    line.backgroundColor=_selectedColor;
    for (UIButton* b in btns) {
        [b setTitleColor:selectedColor forState:UIControlStateSelected];
    }
}

-(void)setNormalColor:(UIColor *)normalColor
{
    _normalColor=normalColor;
    
    for (UIButton* b in btns) {
        [b setTitleColor:normalColor forState:UIControlStateNormal];
    }
}

@end
