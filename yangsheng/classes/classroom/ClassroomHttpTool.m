//
//  ClassroomHttpTool.m
//  yangsheng
//
//  Created by Macx on 17/7/14.
//  Copyright © 2017年 jam. All rights reserved.
//

#import "ClassroomHttpTool.h"

@implementation ClassroomHttpTool

+(void)getClassroomListType:(NSInteger)type page:(NSInteger)page size:(NSInteger)size success:(void (^)(NSArray *))success isCache:(BOOL)isCache
{
    NSString* str=[ZZUrlTool fullUrlWithTail:@"/Course/Post/index"];
    NSMutableDictionary* pa=[self pageParamsWithPage:page size:size];
    [pa setValue:[NSNumber numberWithInteger:type] forKey:@"tid"];
    [self get:str params:pa usingCache:isCache success:^(NSDictionary *responseObject) {
        NSDictionary* data=[responseObject valueForKey:@"data"];
        NSArray* list=[data valueForKey:@"list"];
        NSMutableArray* datasource=[NSMutableArray array];
        for (NSDictionary* cl in list) {
            BaseModel* class=[[BaseModel alloc]initWithDictionary:cl];
            [datasource addObject:class];
        }
        if (datasource.count>0) {
            if (success) {
                success(datasource);
            }
        }
    } failure:^(NSError *error) {
        
    }];
}

+(void)getClassroomCollectionListPage:(NSInteger)page size:(NSInteger)size token:(NSString*)token success:(void (^)(NSArray *))success isCache:(BOOL)isCache
{
    NSString* str=[ZZUrlTool fullUrlWithTail:@"/User/Favorite/index"];
    NSMutableDictionary* pa=[self pageParamsWithPage:page size:size];
    [pa setValue:token forKey:@"access_token"];
    [self get:str params:pa usingCache:isCache success:^(NSDictionary *responseObject) {
        NSDictionary* data=[responseObject valueForKey:@"data"];
        NSArray* list=[data valueForKey:@"list"];
        NSMutableArray* datasource=[NSMutableArray array];
        for (NSDictionary* cl in list) {
            BaseModel* class=[[BaseModel alloc]initWithDictionary:cl];
            [datasource addObject:class];
        }
        if (datasource.count>0) {
            if (success) {
                success(datasource);
            }
        }
    } failure:^(NSError *error) {
        
    }];
}

+(void)cancelCollectionId:(NSString *)idd token:(NSString *)token success:(void (^)(BOOL, NSString *))success
{
    NSMutableDictionary* di=[NSMutableDictionary dictionary];
    [di setValue:idd forKey:@"post_id"];
    [di setValue:token forKey:@"access_token"];
    
    NSString* str=[ZZUrlTool fullUrlWithTail:@"/User/Favorite/delete_favorite"];
    
    [self post:str params:di success:^(NSDictionary *responseObject) {
        BOOL ok=responseObject.code==0;
        NSString* msg=[responseObject valueForKey:@"message"];
        if (success) {
            success(ok,msg);
        }
    } failure:^(NSError *error) {
        if (success) {
            success(NO,@"请求失败");
        }
    }];
}

@end
