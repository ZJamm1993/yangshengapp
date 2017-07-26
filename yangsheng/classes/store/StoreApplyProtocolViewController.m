//
//  StoreApplyProtocolViewController.m
//  yangsheng
//
//  Created by Macx on 17/7/17.
//  Copyright © 2017年 jam. All rights reserved.
//

#import "StoreApplyProtocolViewController.h"
#import "StoreApplySubmitViewController.h"

@interface StoreApplyProtocolViewController ()
@end

@implementation StoreApplyProtocolViewController

- (void)viewDidLoad {
    self.url=[html_storeprotocol urlWithMainUrl];
    [super viewDidLoad];
    self.title=@"开店协议";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    CGRect fr=self.view.bounds;
    fr.size.height=fr.size.height-92;
    self.webView.frame=fr;
    
}


- (IBAction)goNext:(id)sender {
    StoreApplySubmitViewController* sub=[[UIStoryboard storyboardWithName:@"Store" bundle:nil]instantiateViewControllerWithIdentifier:@"StoreApplySubmitViewController"];
    [self.navigationController pushViewController:sub animated:YES];
}


@end
