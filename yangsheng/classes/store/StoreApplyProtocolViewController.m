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

@interface StoreApplyProtocolViewController ()

@end

@implementation StoreApplyProtocolViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"开店协议";
    
    NSURL* urlstr=[html_storeprotocol urlWithMainUrl];
    NSURLRequest* req=[NSURLRequest requestWithURL:urlstr];
    [self.web loadRequest:req];
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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

@end
