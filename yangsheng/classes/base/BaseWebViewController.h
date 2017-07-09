//
//  BaseWebViewController.h
//  yangsheng
//
//  Created by jam on 17/7/8.
//  Copyright © 2017年 jam. All rights reserved.
//

#import "BaseViewController.h"

@interface BaseWebViewController : BaseViewController

-(instancetype)initWithUrl:(NSURL*)url;
-(instancetype)initWithHtml:(NSString*)html;

@property (nonatomic,strong) NSURL* url;
@property (nonatomic,strong) NSString* html;
@property (nonatomic,strong,readonly) UIWebView* webView;

-(void)loadWithCustomUrl:(NSURL*)url complete:(void(^) ())completeblock;

@end
