//
//  BaseWebViewController.h
//  yangsheng
//
//  Created by jam on 17/7/8.
//  Copyright © 2017年 jam. All rights reserved.
//

#import "BaseViewController.h"

#define html_brandStory @"/themes/ys_ios/home/brandStory.html"
#define html_founder_detail @"/themes/ys_ios/home/founder_detail.html"
#define html_news_detail @"/themes/ys_ios/home/news_detail.html"
#define html_product_detail @"/themes/ys_ios/home/product_detail.html"
#define html_QA_detail @"/themes/ys_ios/home/QA_detail.html"
#define html_star_detail @"/themes/ys_ios/home/star_detail.html"
#define html_team_detail @"/themes/ys_ios/home/team_detail.html"

@interface BaseWebViewController : BaseViewController

-(instancetype)initWithUrl:(NSURL*)url;
-(instancetype)initWithHtml:(NSString*)html;

@property (nonatomic,assign) NSInteger idd;
@property (nonatomic,strong) NSURL* url;
@property (nonatomic,strong) NSString* html;
@property (nonatomic,strong,readonly) UIWebView* webView;

-(void)loadWithCustomUrl:(NSURL*)url complete:(void(^) ())completeblock;

@end
