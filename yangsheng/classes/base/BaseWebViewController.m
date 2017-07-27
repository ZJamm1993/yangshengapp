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
#import "WBWebProgressBar.h"

@interface BaseWebViewController ()<UIWebViewDelegate>
{
//    UIWebView* webv;
    UIImageView* loadingImageView;
    WBWebProgressBar* progressBar;
    UIActivityIndicatorView* loadingIndicator;
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

-(void)loadWithCustomUrl:(NSURL *)url complete:(void (^)())completeblock
{
    [ZZHttpTool get:url.absoluteString params:nil usingCache:YES success:^(NSDictionary * res) {
        NSDictionary* data=[res valueForKey:@"data"];
        
        NSString* title=[data valueForKey:@"post_title"];
        NSString* content=[data valueForKey:@"post_content"];
        
        self.url=url;
        self.html=content;
        
        [self.webView loadHTMLString:content baseURL:url];
        
        self.title=title;
        if (completeblock) {
            completeblock();
        }
    } failure:^(NSError * err) {
        
    }];
}

-(UIWebView*)webView
{
    if (_webView==nil) {
        _webView=[[UIWebView alloc]initWithFrame:self.view.bounds];
        _webView.delegate=self;
        _webView.dataDetectorTypes=UIDataDetectorTypeNone;
        [self.view addSubview:_webView];
    }
    return _webView;
}

-(void)setHtml:(NSString *)html
{
    _html=html;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor whiteColor];
    
    loadingImageView=[[UIImageView alloc]initWithFrame:self.view.bounds];
    loadingImageView.image=[UIImage imageNamed:@"webview_loading"];
    [self.view addSubview:loadingImageView];
//    loadingImageView.alpha=0.5;
    loadingImageView.hidden=YES;
    
    loadingIndicator=[[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    loadingIndicator.center=CGPointMake(self.view.center.x, 64);
    loadingIndicator.hidesWhenStopped=YES;
    [loadingIndicator stopAnimating];
    [self.view addSubview:loadingIndicator];
    
//    progressBar=[[WBWebProgressBar alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 0.5)];
//    progressBar.progressTintColor=pinkColor;
//    [self.view addSubview:progressBar];
    
    if(self.html.length>0)
    {
        [self.webView loadHTMLString:self.html baseURL:self.url];
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
        
//        abs=@"https://www.baidu.com";
        self.url=[NSURL URLWithString:abs];
        NSLog(@"webview:  %@",abs);
        NSURLRequest* req=[NSURLRequest requestWithURL:self.url];
//        [webv loadRequest:req];
        
        
        loadingImageView.hidden=NO;
        [progressBar WBWebProgressPreparing];
        [loadingIndicator startAnimating];
        
        NSURLSession* session=[NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
        NSURLSessionDataTask* dataTast=[session dataTaskWithRequest:req completionHandler:^(NSData * data, NSURLResponse * response, NSError * error) {
//                        NSLog(@"data:\n%@",data);
//                        NSLog(@"resp:\n%@",response);
//                        NSLog(@"erro:\n%@",error);
            
            dispatch_async(dispatch_get_main_queue(), ^{
                NSString* htmlStr=[[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
//                NSLog(@"%@",htmlStr);
                [self.webView loadHTMLString:htmlStr baseURL:self.url];
                [loadingIndicator stopAnimating];
                loadingImageView.hidden=YES;
                
                if (htmlStr.length==0||error) {
                    [MBProgressHUD showErrorMessage:@"网络不佳"];
                }
            });
            
        }];
        [dataTast resume];
        
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
    self.webView.frame=self.view.bounds;
}

-(void)dealloc
{
    self.webView.delegate=nil;
}

//-(BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
//{
//    if(navigationType==UIWebViewNavigationTypeLinkClicked)
//    {
////        BaseWebViewController* w=[[BaseWebViewController alloc]initWithUrl:[request URL]];
////        [self.navigationController pushViewController:w animated:YES];
//        return NO;
//        
//    }
//    return YES;
//}
//
//-(void)webViewDidStartLoad:(UIWebView *)webView
//{
//    [progressBar WBWebProgressStartLoading];
//}
//
//-(void)webViewDidFinishLoad:(UIWebView *)webView
//{
//    [progressBar WBWebProgressCompleted];
//    [loadingIndicator stopAnimating];
//}
//
//-(void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
//{
//    [MBProgressHUD showErrorMessage:@"网络不佳"];
//    [progressBar WBWebProgressCompleted];
//}


@end
