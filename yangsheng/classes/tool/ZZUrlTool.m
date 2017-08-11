//
//  ZZUrlTool.m
//  yangsheng
//
//  Created by Macx on 17/7/7.
//  Copyright © 2017年 jam. All rights reserved.
//

#import "ZZUrlTool.h"
#import "UniversalModel.h"

@implementation ZZUrlTool

+(NSString*)main
{
//    return @"http://120.25.1.238:8090";
//    return @"http://192.168.1.131:8090";
    return @"http://ys.bangju.com";
}

+(NSString*)fullUrlWithTail:(NSString *)tail
{
    NSString* str=[NSString stringWithFormat:@"%@/%@",[self main],tail];
    return str;
}

//+(NSURL*)qqUrl
//{
//    //[NSURL URLWithString:@"mqq://im/chat?chat_type=wpa&uin=157696423&version=1&src_type=web"]
//    NSString* qq=[[UniversalModel getUniversal]qq_number];
//    if (qq.length==0) {
////        qq=@"10001";
//        return nil;
//    }
////    return nil;
//    NSString* qqu=[NSString stringWithFormat:@"mqq://im/chat?chat_type=wpa&uin=%@&version=1&src_type=web",qq];
//    return [NSURL URLWithString:qqu];
//}

@end
