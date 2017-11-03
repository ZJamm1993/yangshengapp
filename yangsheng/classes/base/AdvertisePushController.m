//
//  AdvertisePushController.m
//  yangsheng
//
//  Created by bangju on 2017/11/1.
//  Copyright © 2017年 jam. All rights reserved.
//

#import "AdvertisePushController.h"

@implementation AdvertisePushController

+(void)handleController:(UIViewController *)viewController withObject:(BaseModel *)object
{
    NSLog(@"%@",object.thumb);
    NSLog(@"%@",NSStringFromClass([viewController class]));
    
    NSString* href=object.href;
//    href=@"https://m.baidu.com";
    
//    object.requestedToken=object.thumb.length%2==0;
    
    if (href.length>0) {
        
//        if (object.requested_token) {
//            if ([[UserModel getUser]access_token].length==0) {
//                [MBProgressHUD showErrorMessage:@"需要登录"];
//                return;
//            }
//        }
        
        NSString* fullHref=[ZZUrlTool fullUrlWithTail:href];
        NSURL* url=[NSURL URLWithString:fullHref];
        BaseWebViewController* web=[[BaseWebViewController alloc]initWithUrl:url];
        [viewController.navigationController pushViewController:web animated:YES];
    }
}

@end
