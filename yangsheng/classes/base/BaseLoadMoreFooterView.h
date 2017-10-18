//
//  BaseLoadMoreFooterView.h
//  yangsheng
//
//  Created by bangju on 2017/10/18.
//  Copyright © 2017年 jam. All rights reserved.
//

#import <UIKit/UIKit.h>

@class BaseLoadMoreFooterView;
@protocol BaseLoadMoreFooterViewDelegate <NSObject>

@optional
-(void)loadMoreFooterViewShouldStartLoadMore:(BaseLoadMoreFooterView*)footerView;

@end

@interface BaseLoadMoreFooterView : UIView

@property (nonatomic,assign) BOOL loading;
@property (nonatomic,weak) id<BaseLoadMoreFooterViewDelegate> delegate;

+(instancetype)defaultFooter;

-(void)startLoading;
-(void)endLoadingWithText:(NSString*)text;

@end
