//
//  CustomPagerController.h
//  TYPagerControllerDemo
//
//  Created by tany on 16/5/17.
//  Copyright © 2016年 tanyang. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ZZPagerController;
@class ZZPagerMenu;

@protocol ZZPagerControllerDataSource<NSObject>

@required
-(NSInteger)numbersOfChildControllersInPagerController:(ZZPagerController*)pager;
-(UIViewController*)pagerController:(ZZPagerController*)pager viewControllerAtIndex:(NSInteger)index;
-(NSString*)pagerController:(ZZPagerController*)pager titleAtIndex:(NSInteger)index;

@optional
-(CGRect)pagerController:(ZZPagerController*)pager frameForContentView:(UIScrollView*)scrollView;
-(CGRect)pagerController:(ZZPagerController*)pager frameForMenuView:(ZZPagerMenu*)menu;

@end

@interface ZZPagerController : UIViewController

@property (nonatomic,weak) id<ZZPagerControllerDataSource> dataSource;
@property (nonatomic,strong) UIColor* menuNormalColor;
@property (nonatomic,strong) UIColor* menuSelectedColor;
-(void)refreshSubviews;

@end

@protocol ZZPagerMenuDatasource <NSObject>
@required
-(NSInteger)numbersOfTitlesForMenu:(ZZPagerMenu*)menu;
-(NSString*)pagerMenu:(ZZPagerMenu*)menu titleAtIndex:(NSInteger)index;
@end

@protocol ZZPagerMenuDelegate <NSObject>

@optional
-(void)pagerMenu:(ZZPagerMenu*)menu didSelectAtIndex:(NSInteger)index;

@end

@interface ZZPagerMenu : UIView

@property (nonatomic,weak) id<ZZPagerMenuDatasource> dataSource;
@property (nonatomic,weak) id<ZZPagerMenuDelegate> delegate;

@property (nonatomic,strong) UIColor* normalColor;
@property (nonatomic,strong) UIColor* selectedColor;

@property (nonatomic,assign) CGFloat currentPage;
-(void)refreshSubviews;

@end
