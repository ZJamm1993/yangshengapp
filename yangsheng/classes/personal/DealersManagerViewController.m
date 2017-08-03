//
//  DealersManagerViewController.m
//  yangsheng
//
//  Created by Macx on 2017/8/3.
//  Copyright © 2017年 jam. All rights reserved.
//

#import "DealersManagerViewController.h"
#import "ZZHttpTool.h"
#import "UserModel.h"

#define DealersManagerLoginUrl @"http://yangsen.hyxmt.cn/ServiceAPI/usercenter/Manager.aspx"
#define DealersManagerDefaultUrl @"http://yangsen.hyxmt.cn/a/Manager/Default.aspx"

@interface DealersManagerViewController()<UIWebViewDelegate>

@end

@implementation DealersManagerViewController
{
    UIWebView* web;
    UIActivityIndicatorView* indicator;
}

-(void)dealloc
{
    web.delegate=nil;
    [web stopLoading];
}

-(void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title=@"经销商管理";
    CGRect bou=[[UIScreen mainScreen]bounds];
    bou.size.height=bou.size.height-64;
    //扑街咯
    web=[[UIWebView alloc]initWithFrame:bou];
    web.delegate=self;
    web.dataDetectorTypes=UIDataDetectorTypeNone;
    web.scrollView.showsVerticalScrollIndicator=NO;
    web.scrollView.showsHorizontalScrollIndicator=NO;
    [self.view addSubview:web];
    
    indicator=[[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    indicator.center=CGPointMake(self.view.center.x, 64);
    indicator.hidesWhenStopped=YES;
    [indicator stopAnimating];
    [self.view addSubview:indicator];
    
    //?action=login&password=888888&UserName=q123456&refurl=/a/Manager/Default.aspx
    
//    UserModel* user=[UserModel getUser];
    
    [indicator startAnimating];
    
    NSMutableDictionary* params=[NSMutableDictionary dictionary];
    [params setValue:@"login" forKey:@"action"];
    [params setValue:@"888888" forKey:@"password"];
    [params setValue:@"q123456" forKey:@"UserName"];
    [params setValue:@"/a/Manager/Default.aspx" forKey:@"refurl"];
    
    [ZZHttpTool get:DealersManagerLoginUrl params:params usingCache:NO success:^(NSDictionary *loginResp) {
        NSLog(@"%@",loginResp);
        if ([[loginResp valueForKey:@"id"]integerValue]==1) {
            [web loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:DealersManagerDefaultUrl]]];
        }
        else
        {
            [MBProgressHUD showErrorMessage:[loginResp valueForKey:@"messages"]];
        }
    } failure:^(NSError *loginErr) {
        NSLog(@"%@",loginErr);
        [MBProgressHUD showErrorMessage:@"网络不佳"];
    }];
}

-(void)webViewDidFinishLoad:(UIWebView *)webView
{
    [indicator stopAnimating];
}

//fucking cookie
/*
NSMutableDictionary *cookieProperties = [NSMutableDictionary dictionary];

[cookieProperties setObject:@"ManagerUserView" forKey:NSHTTPCookieName];
NSString *cookie = [[NSUserDefaults standardUserDefaults] objectForKey:@"ManagerUserView"];

if (cookie == nil) {
    
    [cookieProperties setObject:@"" forKey:NSHTTPCookieValue];
}else{
    
    //        NSString *cookieStr = cookie;
    [cookieProperties setObject:cookie forKey:NSHTTPCookieValue];
}

//出错
[cookieProperties setObject:@"demo.8612315.cn" forKey:NSHTTPCookieDomain];
[cookieProperties setObject:@"/" forKey:NSHTTPCookiePath];
[cookieProperties setObject:@"0" forKey:NSHTTPCookieVersion];
[cookieProperties setObject:[NSDate dateWithTimeIntervalSinceNow:3600*24*30] forKey:NSHTTPCookieExpires];

NSHTTPCookie *cookieuser = [NSHTTPCookie cookieWithProperties:cookieProperties];
[[NSHTTPCookieStorage sharedHTTPCookieStorage] setCookie:cookieuser];



NSArray *allcookies  = [[NSHTTPCookieStorage sharedHTTPCookieStorage] cookies];

NSLog(@"所有的cookies = %@",allcookies);

[(UIWebView*)_engineWebView loadRequest:request];
return nil;
*/

@end
