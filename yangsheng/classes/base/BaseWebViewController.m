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

@interface BaseWebViewController ()//<UIWebViewDelegate>
@property (nonatomic,strong) UIWebView* ios8WebView;
@property (nonatomic,strong) WKWebView* ios9WebView;
@end

@implementation BaseWebViewController

{
    //    UIWebView* webv;
    UIImageView* loadingImageView;
    WBWebProgressBar* progressBar;
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

-(WKWebView*)ios9WebView
{
    if (_ios9WebView==nil) {
        
        _ios9WebView=[[WKWebView alloc]initWithFrame:self.view.bounds];
        _ios9WebView.configuration.allowsInlineMediaPlayback=YES;
        
//        _webView.delegate=self;
//        _webView.dataDetectorTypes=UIDataDetectorTypeNone;
        [self.view addSubview:_ios9WebView];
    }
    NSLog(@"wkwebview");
    return _ios9WebView;
}

-(UIWebView*)ios8WebView
{
    if (_ios8WebView==nil) {
        _ios8WebView=[[UIWebView alloc]initWithFrame:self.view.bounds];
        _ios8WebView.dataDetectorTypes=UIDataDetectorTypeNone;
        [self.view addSubview:_ios8WebView];
    }
    NSLog(@"uiwebview");
    return _ios8WebView;
}

-(UIView*)webUIView
{
    if ([[[UIDevice currentDevice]systemVersion]floatValue]<9.0) {
        return self.ios8WebView;
    }
    return self.ios9WebView;
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
        NSLog(@"webview:  %@",abs);
        NSURLRequest* req=[NSURLRequest requestWithURL:self.url];
//        [self.webView loadRequest:req];
//        return;
        
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
                [self loadHtml:htmlStr];
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

-(void)loadHtml:(NSString*)htmlString
{
    if ([[[UIDevice currentDevice]systemVersion]floatValue]<9.0) {
        [self.ios8WebView loadHTMLString:htmlString baseURL:self.url];
    }
    else
    {
        [self.ios9WebView loadHTMLString:htmlString baseURL:self.url];
    }
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

//-(void)dealloc
//{
//    self.webView.delegate=nil;
//}

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
