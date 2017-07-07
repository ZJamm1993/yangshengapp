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
    return @"http://192.168.1.131:8090";
}

+(NSString*)fullUrlWithTail:(NSString *)tail
{
    NSString* str=[NSString stringWithFormat:@"%@/%@",[self main],tail];
    return str;
}

@end

@implementation NSString(Url)

-(NSString*)urlStringWithMainUrl
{
    return [ZZUrlTool fullUrlWithTail:self];
}

-(NSURL*)urlWithMainUrl
{
    return [NSURL URLWithString:[self urlStringWithMainUrl]];
}

@end
