//
//  StoreApplyProtocolViewController.m
//  yangsheng
//
//  Created by Macx on 17/7/17.
//  Copyright © 2017年 jam. All rights reserved.
//

#import "StoreApplyProtocolViewController.h"
#import "StoreApplySubmitViewController.h"

#import "StoreHttpTool.h"

@interface StoreApplyProtocolViewController ()<UIWebViewDelegate>
{
    UIImageView* loadingImageView;
}
@end

@implementation StoreApplyProtocolViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"开店协议";
    
    NSURL* urlstr=[html_storeprotocol urlWithMainUrl];
    NSURLRequest* req=[NSURLRequest requestWithURL:urlstr];
    self.web.delegate=self;
    [self.web loadRequest:req];
    
    loadingImageView=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height-64-100)];
    loadingImageView.image=[UIImage imageNamed:@"webview_loading"];
    [self.view addSubview:loadingImageView];
    loadingImageView.alpha=0.5;
    loadingImageView.hidden=NO;
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)dealloc
{
    self.web.delegate=nil;
    [self.web stopLoading];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
- (IBAction)goNext:(id)sender {
    StoreApplySubmitViewController* sub=[[UIStoryboard storyboardWithName:@"Store" bundle:nil]instantiateViewControllerWithIdentifier:@"StoreApplySubmitViewController"];
    [self.navigationController pushViewController:sub animated:YES];
}

-(void)webViewDidFinishLoad:(UIWebView *)webView
{
    loadingImageView.hidden=YES;
}

@end
