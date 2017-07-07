//
//  HomeHttpTool.m
//  yangsheng
//
//  Created by Macx on 17/7/7.
//  Copyright © 2017年 jam. All rights reserved.
//

#import "HomeHttpTool.h"

@implementation HomeHttpTool

+(void)getProductClassSuccess:(void (^)(NSArray *))success
{
    NSString* str=[ZZUrlTool fullUrlWithTail:@"/Content/Goods/classification"];
    [self get:str params:nil success:^(NSDictionary *responseObject) {
        NSArray* data=[responseObject valueForKey:@"data"];
        NSMutableArray* datasource=[NSMutableArray array];
        for (NSDictionary* cl in data) {
            ModelProductClass* class=[[ModelProductClass alloc]initWithDictionary:cl];
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

+(void)getQuesAnsRandomSuccess:(void (^)(NSArray *))success
{
    NSString* str=[ZZUrlTool fullUrlWithTail:@"/Content/Qa/index"];
    NSDictionary* para=@{@"page":@"1",@"pagesize":@"3"};
    [self get:str params:para success:^(NSDictionary *responseObject) {
        NSDictionary* data=[responseObject valueForKey:@"data"];
        NSArray* list=[data valueForKey:@"list"];
        NSMutableArray* datasource=[NSMutableArray array];
        for (NSDictionary* cl in list) {
            ModelQA* class=[[ModelQA alloc]initWithDictionary:cl];
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

+(void)getFoundersSuccess:(void (^)(NSArray *))success
{
    NSString* str=[ZZUrlTool fullUrlWithTail:@"/Content/Founder/index"];
    [self get:str params:nil success:^(NSDictionary *responseObject) {
        NSDictionary* data=[responseObject valueForKey:@"data"];
        NSArray* list=[data valueForKey:@"list"];
        NSMutableArray* datasource=[NSMutableArray array];
        for (NSDictionary* cl in list) {
            ModelFounder* class=[[ModelFounder alloc]initWithDictionary:cl];
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

+(void)getAdversSuccess:(void (^)(NSArray *))success
{
    
    NSString* str=[ZZUrlTool fullUrlWithTail:@"/Content/Slide/index?cid=1"];
    [self get:str params:nil success:^(NSDictionary *responseObject) {
        NSDictionary* data=[responseObject valueForKey:@"data"];
        NSArray* list=[data valueForKey:@"list"];
        NSMutableArray* datasource=[NSMutableArray array];
        for (NSDictionary* cl in list) {
            ModelAdvs* class=[[ModelAdvs alloc]initWithDictionary:cl];
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

@end
