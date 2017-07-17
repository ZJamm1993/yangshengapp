//
//  ZZUrlTool.h
//  yangsheng
//
//  Created by Macx on 17/7/7.
//  Copyright © 2017年 jam. All rights reserved.
//

#import <Foundation/Foundation.h>

#define QQURL [NSURL URLWithString:@"mqq://im/chat?chat_type=wpa&uin=493638384&version=1&src_type=web"]

@interface ZZUrlTool : NSObject

+(NSString*)main;

+(NSString*)fullUrlWithTail:(NSString*)tail;

@end