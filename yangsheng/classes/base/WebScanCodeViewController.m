//
//  WebScanCodeViewController.m
//  yangsheng
//
//  Created by bangju on 2017/11/2.
//  Copyright © 2017年 jam. All rights reserved.
//

#import "WebScanCodeViewController.h"

@interface WebScanCodeViewController ()

@end

@implementation WebScanCodeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)onResult:(NSString *)result
{
    
    [self.navigationController popViewControllerAnimated:NO];
    if([self.delegate respondsToSelector:@selector(codeScanerOnResult:)])
    {
        [self.delegate codeScanerOnResult:result];
    }
}

@end
