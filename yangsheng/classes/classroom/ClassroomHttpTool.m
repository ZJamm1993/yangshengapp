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

@end
