//
//  ZZHttpTool.m
//  yangsheng
//
//  Created by jam on 17/7/6.
//  Copyright © 2017年 jam. All rights reserved.
//

#import "ZZHttpTool.h"

@implementation ZZHttpTool

+(void)get:(NSString *)url params:(NSDictionary *)params success:(void (^)(NSDictionary *))success failure:(void (^)(NSError *))failure
{
    [self requestMethod:@"GET" url:url params:params success:success failure:failure];
}

+(void)post:(NSString *)url params:(NSDictionary *)params success:(void (^)(NSDictionary *))success failure:(void (^)(NSError *))failure
{
    [self requestMethod:@"POST" url:url params:params success:success failure:failure];
}

+(void)requestMethod:(NSString*)method url:(NSString *)url params:(NSDictionary *)params success:(void (^)(NSDictionary *))success failure:(void (^)(NSError *))failure
{
    BOOL isGet=[method isEqualToString:@"GET"];
    BOOL isPost=[method isEqualToString:@"POST"];
    if (isGet||isPost) {
        
        NSArray* keys=[params allKeys];
        NSMutableArray* keysAndValues=[NSMutableArray array];
        for (NSString* key in keys) {
            NSString* value=[params valueForKey:key];
            NSString* kv=[NSString stringWithFormat:@"%@=%@",key,value];
            [keysAndValues addObject:kv];
        }
        
        NSString* body=[keysAndValues componentsJoinedByString:@"&"];
        
        if (isGet&&body.length>0) {
            url=[NSString stringWithFormat:@"%@?%@",url,body];
        }
        
        NSURL* _ur=[NSURL URLWithString:url];
        
        NSMutableURLRequest* request=[NSMutableURLRequest requestWithURL:_ur];
        request.HTTPMethod=method;
        
        if (isPost) {
            request.HTTPBody=[body dataUsingEncoding:NSUTF8StringEncoding];
        }
        
        
        NSURLSession* session=[NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
        NSURLSessionDataTask* dataTast=[session dataTaskWithRequest:request completionHandler:^(NSData * data, NSURLResponse * response, NSError * error) {
//            NSLog(@"data:\n%@",data);
//            NSLog(@"resp:\n%@",response);
//            NSLog(@"erro:\n%@",error);
            
            dispatch_async(dispatch_get_main_queue(), ^{
                if (data) {
                    NSString *receiveStr = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
                    
                    receiveStr=[receiveStr stringByReplacingOccurrencesOfString:@"null" withString:@"{}"];
                    
                    NSData * data2 = [receiveStr dataUsingEncoding:NSUTF8StringEncoding];
                    
                    NSDictionary* result=[NSJSONSerialization JSONObjectWithData:data2 options:NSJSONReadingMutableLeaves error:nil];
                    if (success) {
                        success(result);
                    }
                }
                else if(error)
                {
                    if (failure) {
                        failure(error);
                    }
                }
            });
            
        }];
        [dataTast resume];
    }
}

@end

