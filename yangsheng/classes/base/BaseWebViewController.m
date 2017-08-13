//
//  BaseWebViewController.m
//  yangsheng
//
//  Created by jam on 17/7/8.
//  Copyright © 2017年 jam. All rights reserved.
//

#import "BaseWebViewController.h"
#import "ZZUrlTool.h"
#import "UserModel.h"
#import "ZZHttpTool.h"
//#import "WBWebProgressBar.h"

@interface BaseWebViewController ()<UIWebViewDelegate>
@property (nonatomic,strong) UIWebView* ios8WebView;
@end

@implementation BaseWebViewController
{
    UIImageView* loadingImageView;
    UIActivityIndicatorView* loadingIndicator;
}

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

-(void)dealloc
{
    self.ios8WebView.delegate=nil;
}

-(UIWebView*)ios8WebView
{
    if (_ios8WebView==nil) {
        _ios8WebView=[[UIWebView alloc]initWithFrame:self.view.bounds];
        _ios8WebView.dataDetectorTypes=UIDataDetectorTypeNone;
        _ios8WebView.delegate=self;
        [self.view addSubview:_ios8WebView];
    }
    NSLog(@"uiwebview");
    return _ios8WebView;
}

-(UIView*)webUIView
{
    return self.ios8WebView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor whiteColor];
    
    loadingIndicator=[[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    loadingIndicator.center=CGPointMake(self.view.center.x, 64);
    loadingIndicator.hidesWhenStopped=YES;
//    loadingIndicator.backgroundColor=[UIColor redColor];
    [loadingIndicator stopAnimating];
    [self.view addSubview:loadingIndicator];
    
    
    if(self.html.length>0)
    {
        [self loadHtml:self.html];
    }
    else if (self.url) {
        NSString* abs=[self.url absoluteString];
        
        NSMutableDictionary* params=[NSMutableDictionary dictionary];
        [params setValue:[NSNumber numberWithInteger:self.idd] forKey:@"id"];
        if (self.type.length>0) {
            [params setValue:self.type forKey:@"type"];
        }
        [params setValue:@"ios" forKey:@"sys"];
        NSString* access_token=[[UserModel getUser]access_token];
        if (access_token.length>0) {
            [params setValue:access_token forKey:@"access_token"];
        }
        
        NSArray* keys=[params allKeys];
        NSMutableArray* keysAndValues=[NSMutableArray array];
        for (NSString* key in keys) {
            NSString* value=[params valueForKey:key];
            
            NSString* kv=[NSString stringWithFormat:@"%@=%@",key,value];
            [keysAndValues addObject:kv];
        }
        
        NSString* body=[keysAndValues componentsJoinedByString:@"&"];
        
        if (body.length>0) {
            abs=[NSString stringWithFormat:@"%@%@%@",abs,[abs containsString:@"?"]?@"":@"?",body];
        }
        
        if (![abs containsString:[ZZUrlTool main]]) {
            abs=[ZZUrlTool fullUrlWithTail:abs];
        }
//        abs=@"http://192.168.1.131:82/index.html";
//        abs=@"https://www.baidu.com";
        self.url=[NSURL URLWithString:abs];
        
        /*
         <html>
         <head>
         <meta charset=UTF-8>
         <style type=text/css>
         body {background-color: white}
         div {background-color:#f0f0f0;color:#f0f0f0;}
         br {height:5;}
         .img_large{width:100%;height:160;}
         .img_small{width:50%;height:100;}
         .text_long{width:100%;height:20;}
         .text_short{width:60%;height:20;}
         </style>
         </head>
         <body>
         <div class=img_large>a</div><br>
         <div class=text_long>a</div><br>
         <div class=text_long>a</div><br>
         <div class=text_short>a</div><br>
         <div class=img_small>a</div><br>
         <div class=text_long>a</div><br>
         <div class=text_long>a</div><br>
         <div class=text_short>a</div><br>
         </body>
         </html>
         */
        
        NSString *filePath = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"hhh.html"];
        
        NSError* err=nil;
        NSString* mTxt=[NSString stringWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:&err];
        [self.ios8WebView loadHTMLString:mTxt baseURL:nil];
        
        NSLog(@"webview:  %@",abs);
        NSURLRequest* req=[NSURLRequest requestWithURL:self.url];
        
        [self.ios8WebView performSelector:@selector(loadRequest:) withObject:req afterDelay:0.5];
        
        [loadingIndicator removeFromSuperview];
        [self.view addSubview:loadingIndicator];
        [loadingIndicator startAnimating];
        
    }
}

-(void)loadHtml:(NSString*)htmlString
{
    [self.ios8WebView loadHTMLString:htmlString baseURL:self.url];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    self.webUIView.frame=self.view.bounds;
}

-(void)webViewDidStartLoad:(UIWebView *)webView
{
    [loadingIndicator startAnimating];
}

-(void)webViewDidFinishLoad:(UIWebView *)webView
{
//    self.ios8WebView.hidden=NO;
    [loadingIndicator stopAnimating];
}

@end
