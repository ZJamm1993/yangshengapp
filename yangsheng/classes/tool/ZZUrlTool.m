//
//  ZZUrlTool.m
//  yangsheng
//
//  Created by Macx on 17/7/7.
//  Copyright © 2017年 jam. All rights reserved.
//

#import "ZZUrlTool.h"

@implementation ZZUrlTool

+(NSString*)main
{
    return @"http://120.25.1.238:8090";
//    return @"http://192.168.1.131:8090";
}

+(NSString*)fullUrlWithTail:(NSString *)tail
{
    NSString* str=[NSString stringWithFormat:@"%@/%@",[self main],tail];
    return str;
}

@end
