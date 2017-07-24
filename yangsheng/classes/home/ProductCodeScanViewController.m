//
//  ProductCodeScanViewController.m
//  yangsheng
//
//  Created by Macx on 17/7/24.
//  Copyright © 2017年 jam. All rights reserved.
//

#import "ProductCodeScanViewController.h"
#import "ProductCodeTextViewController.h"
#import "ProductCheckViewController.h"
#import "HomeHttpTool.h"

@interface ProductCodeScanViewController ()

@end

@implementation ProductCodeScanViewController

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
    [MBProgressHUD showProgressMessage:@"正在查询"];
    [HomeHttpTool getProductCodeWithQRCode:result success:^ (NSDictionary* data) {
        [MBProgressHUD hide];
        NSLog(@"%@",@"what is it??");
        ProductCheckResultType type=[[data valueForKey:@"type"]integerValue];
        NSString* title=[data valueForKey:@"title"];
        NSString* detail=[data valueForKey:@"detail"];
        if (![[data allKeys]containsObject:@"type"]) {
            type=ProductCheckResultTypeUnknown;
        }
        if (type!=ProductCheckResultTypeUnknown) {
            
            ProductCodeTextViewController* te=[[UIStoryboard storyboardWithName:@"Home" bundle:nil]instantiateViewControllerWithIdentifier:@"ProductCodeTextViewController"];
            te.preString=detail;
            [self.navigationController pushViewController:te animated:YES];
        }
        else
        {
            ProductCheckViewController* ch=[[UIStoryboard storyboardWithName:@"Home" bundle:nil]instantiateViewControllerWithIdentifier:@"ProductCheckViewController"];
            ch.resultType=type;
            ch.resultTitle=title.length>0?title:@"未查询到相关信息";
            ch.resultDetail=detail;
            [self.navigationController pushViewController:ch animated:YES];
        }
    } isCache:NO];
}

@end
