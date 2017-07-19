//
//  ZZHttpTool.m
//  yangsheng
//
//  Created by jam on 17/7/6.
//  Copyright © 2017年 jam. All rights reserved.
//

#import "ZZHttpTool.h"
#import "Reachability.h"

@implementation ZZHttpTool

+(NSMutableDictionary*)pageParams
{
    NSMutableDictionary* d=[NSMutableDictionary dictionary];
    [d setValue:@"1" forKey:@"page"];
    [d setValue:@"10" forKey:@"pagesize"];
    return d;
}

+(NSMutableDictionary*)pageParamsWithPage:(NSInteger)page size:(NSInteger)size
{
    NSMutableDictionary* d=[NSMutableDictionary dictionary];
    [d setValue:[NSNumber numberWithInteger:page] forKey:@"page"];
    [d setValue:[NSNumber numberWithInteger:size] forKey:@"pagesize"];
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
//    if (![Reachability reachabilityWithHostName:[ZZUrlTool main]]) {
//        if (failure) {
//            failure([NSError errorWithDomain:@"" code:404 userInfo:nil]);
//        }
//    }
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
            url = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
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
                    return;
                }
                else if(error)
                {
                    if (failure) {
                        failure(error);
                        
                    }
                    return;
                }
                failure(error);
                return;
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
    
//    receiveStr=[receiveStr stringByReplacingOccurrencesOfString:@"null" withString:@"nil"];//／／{\"zzz\":\"nillllll!\"}"];
    NSData * data2 = [receiveStr dataUsingEncoding:NSUTF8StringEncoding];
    
    NSDictionary* result=[NSJSONSerialization JSONObjectWithData:data2 options:NSJSONReadingMutableLeaves error:nil];
    result=AFJSONObjectByRemovingKeysWithNullValues(result, NSJSONReadingMutableLeaves);
    if(result==nil)
    {
        NSLog(@"%@",result);//why nil??
    }
    NSLog(@"%@",result);
    return result;
}

//writen by afnetworking , i dont know
static id AFJSONObjectByRemovingKeysWithNullValues(id JSONObject, NSJSONReadingOptions readingOptions) {
    if ([JSONObject isKindOfClass:[NSArray class]]) {
        NSMutableArray *mutableArray = [NSMutableArray arrayWithCapacity:[(NSArray *)JSONObject count]];
        for (id value in (NSArray *)JSONObject) {
            [mutableArray addObject:AFJSONObjectByRemovingKeysWithNullValues(value, readingOptions)];
        }
        
        return (readingOptions & NSJSONReadingMutableContainers) ? mutableArray : [NSArray arrayWithArray:mutableArray];
    } else if ([JSONObject isKindOfClass:[NSDictionary class]]) {
        NSMutableDictionary *mutableDictionary = [NSMutableDictionary dictionaryWithDictionary:JSONObject];
        for (id <NSCopying> key in [(NSDictionary *)JSONObject allKeys]) {
            id value = (NSDictionary *)JSONObject[key];
            if (!value || [value isEqual:[NSNull null]]) {
                [mutableDictionary removeObjectForKey:key];
            } else if ([value isKindOfClass:[NSArray class]] || [value isKindOfClass:[NSDictionary class]]) {
                mutableDictionary[key] = AFJSONObjectByRemovingKeysWithNullValues(value, readingOptions);
            }
        }
        
        return (readingOptions & NSJSONReadingMutableContainers) ? mutableDictionary : [NSDictionary dictionaryWithDictionary:mutableDictionary];
    }
    
    return JSONObject;
}

@end

