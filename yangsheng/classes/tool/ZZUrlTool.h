//
//  ZZUrlTool.h
//  yangsheng
//
//  Created by Macx on 17/7/7.
//  Copyright © 2017年 jam. All rights reserved.
//

#import <Foundation/Foundation.h>

#define QQURL [ZZUrlTool qqUrl]

@interface ZZUrlTool : NSObject

+(NSString*)main;

+(NSString*)fullUrlWithTail:(NSString*)tail;

+(NSURL*)qqUrl;

@end