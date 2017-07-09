//
//  ZZHttpTool.m
//  yangsheng
//
//  Created by jam on 17/7/6.
//  Copyright © 2017年 jam. All rights reserved.
//

#import "ZZHttpTool.h"

@implementation ZZHttpTool

+(NSMutableDictionary*)pageParams
{
    NSMutableDictionary* d=[NSMutableDictionary dictionary];
    [d setValue:@"1" forKey:@"page"];
    [d setValue:@"20" forKey:@"pagesize"];
    return d;
}

+(void)get:(NSString *)url params:(NSDictionary *)params usingCache:(BOOL)isCache success:(void (^)(NSDictionary *))success failure:(void (^)(NSError *))failure
{
    [self requestMethod:@"GET" url:url params:params usingCache:isCache success:success failure:failure];
}

+(void)post:(NSString *)url params:(NSDictionary *)params success:(void (^)(NSDictionary *))success failure:(void (^)(NSError *))failure
{
    [self requestMethod:@"POST" url:url params:params usingCache:NO success:success failure:failure];
}

+(void)requestMethod:(NSString*)method url:(NSString *)url params:(NSDictionary *)params usingCache:(BOOL)isCache success:(void (^)(NSDictionary *))success failure:(void (^)(NSError *))failure
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
        
        if (isGet) {
//            [cache setMemoryCapacity:2048];
//            [cache setDiskCapacity:20480];
            
            request.cachePolicy=isCache?NSURLRequestReturnCacheDataElseLoad:NSURLRequestReloadIgnoringLocalCacheData;
            
            if (isCache) {
                NSURLCache* cache=[NSURLCache sharedURLCache];
                NSCachedURLResponse* cacheResp=[cache cachedResponseForRequest:request];
                NSData* cachedData=cacheResp.data;
                if (cachedData) {
                    
                    NSDictionary* cachedDict=[ZZHttpTool dictionaryWithResponseData:cacheResp.data];
                    if (success) {
                        success(cachedDict);
                    }
                    return;
                }
            }
        }
        
        NSURLSession* session=[NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
        NSURLSessionDataTask* dataTast=[session dataTaskWithRequest:request completionHandler:^(NSData * data, NSURLResponse * response, NSError * error) {
//            NSLog(@"data:\n%@",data);
//            NSLog(@"resp:\n%@",response);
//            NSLog(@"erro:\n%@",error);
            
            dispatch_async(dispatch_get_main_queue(), ^{
                if (data) {
                    NSDictionary* result=[ZZHttpTool dictionaryWithResponseData:data];
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

+(NSDictionary*)dictionaryWithResponseData:(NSData*)data
{
    if (!data) {
        return nil;
    }
    NSString *receiveStr = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
    
    receiveStr=[receiveStr stringByReplacingOccurrencesOfString:@"null" withString:@"{}"];
    
    NSData * data2 = [receiveStr dataUsingEncoding:NSUTF8StringEncoding];
    
    NSDictionary* result=[NSJSONSerialization JSONObjectWithData:data2 options:NSJSONReadingMutableLeaves error:nil];
    return result;
}



@end

