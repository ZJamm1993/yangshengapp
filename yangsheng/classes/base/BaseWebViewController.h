//
//  BaseWebViewController.h
//  yangsheng
//
//  Created by jam on 17/7/8.
//  Copyright © 2017年 jam. All rights reserved.
//

#import "BaseViewController.h"
#import <WebKit/WebKit.h>

#define html_brandStory @"/Content/Page/show_brand"
#define html_founder_detail @"/Content/Founder/show"
#define html_news_detail @"/Content/News/show"
#define html_product_detail @"/Content/Goods/show"
#define html_QA_detail @"/Content/Qa/show"
#define html_star_detail @"/Content/monthstar/show"
#define html_team_detail @"/Content/Team/show"
#define html_activity_detail @"/Content/Expand/show"
#define html_brandBigEvent_detail @"/Content/Event/show"
#define html_newBigEvent_detail @"/Content/Event/show"
#define html_case_detail @"/Content/Case/show"
#define html_course_detail @"/Course/Post/show"
#define html_store_item_detail @"/Entity/Item/show"
//#define html_store_detail @"/themes/ys_ios/store/detail.html"

//#define html_protocol @"/public/protocal.html"
//#define html_contract @"/public/contract.html"
#define html_userprotocol @"/Content/Page/userprotocol.html"
#define html_storeprotocol @"/Content/Page/storeprotocol.html"
#define html_gsrdprivate @"/Content/Page/gsrdprivate.html"

@interface BaseWebViewController : BaseViewController

-(instancetype)initWithUrl:(NSURL*)url;
-(instancetype)initWithHtml:(NSString*)html;

@property (nonatomic,assign) NSInteger idd;
@property (nonatomic,strong) NSString* type;
@property (nonatomic,strong) NSURL* url;
@property (nonatomic,strong) NSString* html;
@property (nonatomic,strong) WKWebView* webView;

-(void)loadWithCustomUrl:(NSURL*)url complete:(void(^) ())completeblock;

@end
