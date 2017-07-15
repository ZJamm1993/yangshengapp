//
//  StoreHttpTool.m
//  yangsheng
//
//  Created by Macx on 17/7/13.
//  Copyright © 2017年 jam. All rights reserved.
//

#import "StoreHttpTool.h"

@implementation StoreHttpTool

+(void)getNeighbourStoreListPage:(NSInteger)page lng:(NSString *)lng lat:(NSString *)lat mult:(NSInteger)mult cityCode:(NSString*)cityCode success:(void (^)(NSArray *))success isCache:(BOOL)isCache
{
    NSString* str=[ZZUrlTool fullUrlWithTail:@"/Entity/Store/list"];
    if (lng.length==0) {
        lng=@"113.389563";
    }
    if (lat.length==0) {
        lat=@"23.115948";
    }
    NSMutableDictionary* par=[self pageParams];
    [par setValue:[NSNumber numberWithInteger:page] forKey:@"page"];
    [par setValue:lng forKey:@"lng"];
    [par setValue:lat forKey:@"lat"];
    [par setValue:[NSNumber numberWithInteger:mult] forKey:@"mult"];
    [par setValue:cityCode forKey:@"citycode"];
    
    [self get:str params:par usingCache:isCache success:^(NSDictionary *resp) {
        NSDictionary* data=[resp valueForKey:@"data"];
        NSArray* list=[data valueForKey:@"list"];
        NSMutableArray* arr=[NSMutableArray array];
        for (NSDictionary* st in list) {
            StoreModel* store=[[StoreModel alloc]initWithDictionary:st];
            [arr addObject:store];
        }
        if (success) {
            success(arr);
        }
    } failure:^(NSError *f) {
        
    }];
}

+(void)searchStoreWithKeyword:(NSString *)keyword page:(NSInteger)page success:(void (^)(NSArray *))success isCache:(BOOL)isCache
{
    if (keyword.length==0) {
        return;
    }
    NSString* ur=[ZZUrlTool fullUrlWithTail:@"/Entity/Store/search"];
    NSMutableDictionary* par=[self pageParams];
    [par setValue:[NSNumber numberWithInteger:page] forKey:@"page"];
    [par setValue:keyword forKey:@"keyword"];
    
    [self post:ur params:par success:^(NSDictionary *resp) {
        NSDictionary* data=[resp valueForKey:@"data"];
        NSArray* list=[data valueForKey:@"list"];
        NSMutableArray* arr=[NSMutableArray array];
        for (NSDictionary* st in list) {
            StoreModel* store=[[StoreModel alloc]initWithDictionary:st];
            [arr addObject:store];
        }
        if (success) {
            success(arr);
        }
    } failure:^(NSError *f) {
        NSLog(@"%@",f);
    }];
}

+(void)getStoreItemsSuccess:(void (^)(NSArray *))success isCache:(BOOL)isCache
{
    NSString* ur=[ZZUrlTool fullUrlWithTail:@"/Entity/Item/list"];
    
    [self get:ur params:nil usingCache:isCache success:^(NSDictionary *responseObject) {
        NSArray* data=[responseObject valueForKey:@"data"];
        NSMutableArray* result=[NSMutableArray array];
        for (NSDictionary* d in data) {
            StoreItem* item=[[StoreItem alloc]initWithDictionary:d];
            [result addObject:item];
        }
        if (success) {
            success(result);
        }
    } failure:^(NSError *err) {
        
    }];
}

+(void)getStoreDetailWithId:(NSString *)idd success:(void (^)(NSArray *))success isCache:(BOOL)isCache
{
    NSString* str=[ZZUrlTool fullUrlWithTail:@"/Entity/Store/show"];
    
    NSMutableDictionary* p=[NSMutableDictionary dictionary];
    [p setValue:idd forKey:@"id"];
    [self get:str params:p usingCache:isCache success:^(NSDictionary *re) {
        NSDictionary* data=[re valueForKey:@"data"];
        NSDictionary* store=[data valueForKey:@"store"];
        NSMutableArray* arr=[NSMutableArray array];
        StoreModel* sm=[[StoreModel alloc]initWithDictionary:store];
        [arr addObject:sm];
        if (success) {
            success(arr);
        }
    } failure:^(NSError *err) {
        
    }];
}

+(void)getCitysWithLevel:(NSString *)level keywords:(NSString *)keywords success:(void (^)(NSArray *))success isCache:(BOOL)isCache
{
    NSString* ur=[ZZUrlTool fullUrlWithTail:@"/Api/map/getdistrict"];
    
    NSMutableDictionary* p=[NSMutableDictionary dictionary];
    [p setValue:level forKey:@"level"];
    [p setValue:keywords forKey:@"keywords"];
    
    [self get:ur params:p usingCache:isCache success:^(NSDictionary *responseObject) {
        NSArray* data=[responseObject valueForKey:@"data"];
        NSMutableArray* result=[NSMutableArray array];
        for (NSDictionary* d in data) {
            CityModel* item=[[CityModel alloc]initWithDictionary:d];
            [result addObject:item];
        }
        if (success) {
            success(result);
        }
    } failure:^(NSError *err) {
        
    }];
}

@end