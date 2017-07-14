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
#define html_activity_detail @"/themes/ys_ios/home/activity_detail.html"
#define html_brandBigEvent_detail @"/themes/ys_ios/home/brandBigEvent_detail.html"
#define html_newBigEvent_detail @"/themes/ys_ios/home/newBigEvent_detail.html"
#define html_case_detail @"/themes/ys_ios/home/case_detail.html"
#define html_course_detail @"/themes/ys_ios/course/detail.html"

@interface BaseWebViewController : BaseViewController

-(instancetype)initWithUrl:(NSURL*)url;
-(instancetype)initWithHtml:(NSString*)html;

@property (nonatomic,assign) NSInteger idd;
@property (nonatomic,strong) NSString* type;
@property (nonatomic,strong) NSURL* url;
@property (nonatomic,strong) NSString* html;
@property (nonatomic,strong,readonly) UIWebView* webView;

-(void)loadWithCustomUrl:(NSURL*)url complete:(void(^) ())completeblock;

@end
