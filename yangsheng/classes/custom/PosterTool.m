//
//  PosterTool.m
//  yangsheng
//
//  Created by bangju on 2017/11/3.
//  Copyright © 2017年 jam. All rights reserved.
//

#import "PosterTool.h"
#import "ZZHttpTool.h"
#import "NaviController.h"

//#define PosterShowingStartTimeIntervalKey @"923u98runc23ksj98j"
//#define PosterShowingEndTimeIntervalKey @"09i90i90i2390i239e"

#define PosterShouldShowKey @"a239r239u98238e"

@implementation PosterTool


+(void)show1111ActivityIfNeed
{
    static PosterTool* tool;
    if (tool==nil) {
        tool=[[PosterTool alloc]init];
    }
    
//    BOOL should=[[[NSUserDefaults standardUserDefaults]valueForKey:PosterShouldShowKey]boolValue];
//    
//    if (should) {
//        if(!tool.showed){
//            [[LargePosterView posterWithImageName:@"1111activity" url:@"/themes/ys/ys-activity/page/activityRule.html" delegate:tool]show];
//            tool.showed=YES;
//        }
//    }
    if (!tool.showed) {
        [ZZHttpTool get:[ZZUrlTool fullUrlWithTail:@"/Portal/Index/getloadingshow"] params:nil usingCache:NO success:^(NSDictionary *res) {
            NSDictionary* data=[res valueForKey:@"data"];
            BOOL isshow=[[data valueForKey:@"isshow"]boolValue];
//            isshow=NO;
            [[NSUserDefaults standardUserDefaults]setValue:[NSNumber numberWithBool:isshow] forKey:PosterShouldShowKey];
            if (isshow) {
                [[LargePosterView posterWithImageName:@"1111activity" url:@"/themes/ys/ys-activity/page/activityRule.html" delegate:tool]show];
                tool.showed=YES;
            }
        } failure:nil];
    }
    
}

-(void)largePosterDidTappedUrl:(NSString *)url
{
    UITabBarController* tab=(UITabBarController*)[UIApplication sharedApplication].keyWindow.rootViewController;
    if ([tab isKindOfClass:[UITabBarController class]]) {
        UINavigationController* nav=tab.selectedViewController;
        if ([nav isKindOfClass:[UINavigationController class]]) {
            
            BaseWebViewController* web=[[BaseWebViewController alloc]initWithUrl:[url urlWithMainUrl]];
            [nav pushViewController:web animated:YES];
        }
    }
}

@end
