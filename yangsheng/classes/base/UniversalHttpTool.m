//
//  UniversalHttpTool.m
//  yangsheng
//
//  Created by Macx on 17/7/21.
//  Copyright © 2017年 jam. All rights reserved.
//

#import "UniversalHttpTool.h"

@implementation UniversalHttpTool

+(void)getUniversalProfileSuccess:(void (^)(UniversalModel *))success isCache:(BOOL)isCache
{
    NSString* sta=[ZZUrlTool fullUrlWithTail:@"/Portal/Index/config"];
    
    [self get:sta params:nil usingCache:isCache success:^(NSDictionary *res) {
        NSDictionary* data=[res valueForKey:@"data"];
        if (data) {
            UniversalModel* uni=[[UniversalModel alloc]initWithDictionary:data];
            [UniversalModel saveUniversal:uni];
            if (success) {
                success(uni);
            }
        }
    } failure:nil];
}

@end
