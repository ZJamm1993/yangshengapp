//
//  ZZHttpTool.h
//  yangsheng
//
//  Created by jam on 17/7/6.
//  Copyright © 2017年 jam. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZZUrlTool.h"

@interface ZZHttpTool : NSObject

+(void)get:(NSString *)url params:(NSDictionary *)params usingCache:(BOOL)isCache success:(void (^)(NSDictionary *))success failure:(void (^)(NSError *))failure;

+(void)post:(NSString *)url params:(NSDictionary *)params success:(void(^)(NSDictionary* responseObject))success failure:(void(^)(NSError *error))failure;

@end