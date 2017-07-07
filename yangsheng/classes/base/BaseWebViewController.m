//
//  BaseWebViewController.m
//  yangsheng
//
//  Created by jam on 17/7/8.
//  Copyright © 2017年 jam. All rights reserved.
//

#import "BaseWebViewController.h"

@interface BaseWebViewController ()<UIWebViewDelegate>
{
    UIWebView* webv;
}
@end

@implementation BaseWebViewController

-(instancetype)initWithUrl:(NSURL *)url
{
    self=[super init];
    _url=url;
    return self;
}

-(instancetype)initWithHtml:(NSString *)html
{
    self=[super init];
    _html=html;
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    webv=[[UIWebView alloc]initWithFrame:self.view.bounds];
    [self.view addSubview:webv];
    
    webv.delegate=self;
    webv.scalesPageToFit=YES;
    if (self.url) {
        NSURLRequest* req=[NSURLRequest requestWithURL:self.url];
        [webv loadRequest:req];
    }
    else if(self.html.length>0)
    {
        [webv loadHTMLString:self.html baseURL:nil];
    }
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    webv.frame=self.view.bounds;
}

-(void)dealloc
{
    webv.delegate=nil;
}

-(BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    return YES;
}

@end
