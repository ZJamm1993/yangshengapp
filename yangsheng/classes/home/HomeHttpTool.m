//
//  HomeHttpTool.m
//  yangsheng
//
//  Created by Macx on 17/7/7.
//  Copyright © 2017年 jam. All rights reserved.
//

#import "HomeHttpTool.h"

@implementation HomeHttpTool

+(void)getProductClassSuccess:(void (^)(NSArray *))success isCache:(BOOL)isCache
{
    NSString* str=[ZZUrlTool fullUrlWithTail:@"/Content/Goods/classification"];
    [self get:str params:nil usingCache:isCache success:^(NSDictionary *responseObject) {
        NSArray* data=[responseObject valueForKey:@"data"];
        NSMutableArray* datasource=[NSMutableArray array];
        for (NSDictionary* cl in data) {
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

+(void)getQuesAnsRandomSuccess:(void (^)(NSArray *))success isCache:(BOOL)isCache
{
    NSString* str=[ZZUrlTool fullUrlWithTail:@"/Content/Qa/index"];
    NSDictionary* para=@{@"page":@"1",@"pagesize":@"3"};
    [self get:str params:para usingCache:isCache success:^(NSDictionary *responseObject) {
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

+(void)getFoundersSuccess:(void (^)(NSArray *))success isCache:(BOOL)isCache
{
    NSString* str=[ZZUrlTool fullUrlWithTail:@"/Content/Founder/index"];
    [self get:str params:nil usingCache:isCache success:^(NSDictionary *responseObject) {
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

+(void)getAdversType:(NSInteger)type success:(void (^)(NSArray *))success isCache:(BOOL)isCache
{
    NSString* str=[ZZUrlTool fullUrlWithTail:[NSString stringWithFormat:@"/Content/Slide/index?cid=%d",(int)type]];
    [self get:str params:nil usingCache:isCache success:^(NSDictionary *responseObject) {
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

+(void)getEnterAdvSuccess:(void (^)(NSArray *))success isCache:(BOOL)isCache
{
    NSString* str=[ZZUrlTool fullUrlWithTail:@"/Content/Page/show_corporate"];
    [self get:str params:nil usingCache:isCache success:^(NSDictionary *responseObject) {
        NSDictionary* data=[responseObject valueForKey:@"data"];
//        NSArray* list=[data valueForKey:@"list"];
        if (data.count==0) {
            return;
        }
        BaseModel* en=[[BaseModel alloc] initWithDictionary:data];
        NSArray* sour=[NSArray arrayWithObject:en];
        if (sour.count>0) {
            if (success) {
                success(sour);
            }
        }
    } failure:^(NSError *error) {
        
    }];
}

+(void)getMonthStarPage:(NSInteger)page size:(NSInteger)size success:(void (^)(NSArray *))success isCache:(BOOL)isCache
{
    NSString* str=[ZZUrlTool fullUrlWithTail:@"/Content/monthstar/index"];
    
    [self get:str params:[self pageParamsWithPage:page size:size] usingCache:isCache success:^(NSDictionary *responseObject) {
        NSDictionary* data=[responseObject valueForKey:@"data"];
        NSArray* list=[data valueForKey:@"list"];
        NSMutableArray* arr=[NSMutableArray array];
        for (NSDictionary* d in list) {
            BaseModel* en=[[BaseModel alloc] initWithDictionary:d];
            [arr  addObject:en];
        }
//        if (sour.count>0) {
            if (success) {
                success(arr);
            }
//        }
    } failure:^(NSError *error) {
        
    }];
}

+(void)getTeamsPage:(NSInteger)page size:(NSInteger)size success:(void (^)(NSArray *))success isCache:(BOOL)isCache
{
    NSString* str=[ZZUrlTool fullUrlWithTail:@"/Content/Team/index"];
    
    [self get:str params:[self pageParamsWithPage:page size:size] usingCache:isCache success:^(NSDictionary *responseObject) {
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

+(void)getExpandPage:(NSInteger)page size:(NSInteger)size success:(void (^)(NSArray *))success isCache:(BOOL)isCache
{
    NSString* str=[ZZUrlTool fullUrlWithTail:@"/Content/Expand/index"];
    [self get:str params:[self pageParamsWithPage:page size:size] usingCache:isCache success:^(NSDictionary *responseObject) {
        NSDictionary* data=[responseObject valueForKey:@"data"];
        NSArray* list=[data valueForKey:@"list"];
        NSMutableArray* datasource=[NSMutableArray array];
        for (NSDictionary* cl in list) {
            BaseModel * class=[[BaseModel alloc]initWithDictionary:cl];
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

+(void)getProductListType:(NSInteger)type page:(NSInteger)page success:(void (^)(NSArray *))success isCache:(BOOL)isCache
{
    NSMutableDictionary* d=[self pageParams];
    [d setValue:[NSNumber numberWithInteger:page] forKey:@"page"];
    [d setValue:[NSNumber numberWithInteger:type] forKey:@"cid"];
    NSString* str=[ZZUrlTool fullUrlWithTail:@"/Content/Goods/index"];
    [self get:str params:d usingCache:isCache success:^(NSDictionary *resp) {
        NSDictionary* data=[resp valueForKey:@"data"];
        NSArray* list=[data valueForKey:@"list"];
        NSMutableArray* sou=[NSMutableArray array];
        for (NSDictionary* cl in list) {
            BaseModel* m=[[BaseModel alloc]initWithDictionary:cl];
            [sou addObject:m];
        }
        if (sou.count>0) {
            if (success) {
                success(sou);
            }
        }
    } failure:^(NSError *err) {
        
    }];
}

+(void)searchProductName:(NSString *)name page:(NSInteger)page success:(void (^)(NSArray *))success isCache:(BOOL)isCache
{
    NSMutableDictionary* d=[self pageParams];
    [d setValue:[NSNumber numberWithInteger:page] forKey:@"page"];
    [d setValue:name forKey:@"keywords"];
    NSString* str=[ZZUrlTool fullUrlWithTail:@"/Content/Goods/search"];
    [self get:str params:d usingCache:isCache success:^(NSDictionary *resp) {
        NSDictionary* data=[resp valueForKey:@"data"];
        NSArray* list=[data valueForKey:@"list"];
        NSMutableArray* sou=[NSMutableArray array];
        for (NSDictionary* cl in list) {
            BaseModel* m=[[BaseModel alloc]initWithDictionary:cl];
            [sou addObject:m];
        }
        if (sou.count>0) {
            if (success) {
                success(sou);
            }
        }
    } failure:^(NSError *err) {
        
    }];
}

+(void)getQAListPage:(NSInteger)page success:(void (^)(NSArray *))success isCache:(BOOL)isCache
{
    NSMutableDictionary* d=[self pageParams];
    [d setValue:[NSNumber numberWithInteger:page] forKey:@"page"];
    NSString* str=[ZZUrlTool fullUrlWithTail:@"/Content/Qa/index"];
    [self get:str params:d usingCache:isCache success:^(NSDictionary *resp) {
        NSDictionary* data=[resp valueForKey:@"data"];
        NSArray* list=[data valueForKey:@"list"];
        NSMutableArray* sou=[NSMutableArray array];
        for (NSDictionary* cl in list) {
            BaseModel* m=[[BaseModel alloc]initWithDictionary:cl];
            [sou addObject:m];
        }
        if (sou.count>0) {
            if (success) {
                success(sou);
            }
        }
    } failure:^(NSError *err) {
        
    }];
}

+(void)getFeedbackAllListSize:(NSInteger)size success:(void (^)(NSArray *,NSArray*))success isCache:(BOOL)isCache
{
    NSString* str=[ZZUrlTool fullUrlWithTail:@"/Content/Case/complex"];
    [self get:str params:@{@"pagesize":[NSNumber numberWithInteger:size]} usingCache:isCache success:^(NSDictionary *resp) {
        NSArray* data=[resp valueForKey:@"data"];
        NSMutableArray* secs=[NSMutableArray array];
        NSMutableArray* rows=[NSMutableArray array];
        for (NSDictionary* cc in data) {
            BaseModel* s=[[BaseModel alloc]initWithDictionary:cc];
            [secs addObject:s];
            NSMutableArray* rar=[NSMutableArray array];
            NSArray* list=[cc valueForKey:@"list"];
            for (NSDictionary* ll in list) {
                BaseModel* r=[[BaseModel alloc]initWithDictionary:ll];
                [rar addObject:r];
            }
            [rows addObject:rar];
        }
        if (success) {
            success(secs,rows);
        }
    } failure:^(NSError *err) {
        
    }];
}

+(void)getFeedbackListType:(NSInteger)type page:(NSInteger)page success:(void (^)(NSArray *))success isCache:(BOOL)isCache
{
    NSMutableDictionary* d=[self pageParams];
    [d setValue:[NSNumber numberWithInteger:page] forKey:@"page"];
    [d setValue:[NSNumber numberWithInteger:type] forKey:@"cid"];
    NSString* str=[ZZUrlTool fullUrlWithTail:@"/Content/Case/index"];
    [self get:str params:d usingCache:isCache success:^(NSDictionary *resp) {
        NSDictionary* data=[resp valueForKey:@"data"];
        NSArray* list=[data valueForKey:@"list"];
        NSMutableArray* sou=[NSMutableArray array];
        for (NSDictionary* cl in list) {
            BaseModel* m=[[BaseModel alloc]initWithDictionary:cl];
            [sou addObject:m];
        }
        if (sou.count>0) {
            if (success) {
                success(sou);
            }
        }
    } failure:^(NSError *err) {
        
    }];
}

+(void)getBrandEventPage:(NSInteger)page size:(NSInteger)size success:(void (^)(NSArray *))success isCache:(BOOL)isCache
{
    NSString* str=[ZZUrlTool fullUrlWithTail:@"/Content/Event/brand_event"];
    
    [self get:str params:[self pageParamsWithPage:page size:size] usingCache:isCache success:^(NSDictionary *responseObject) {
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


+(void)getLatestEventPage:(NSInteger)page size:(NSInteger)size success:(void(^) (NSArray* datasource))success isCache:(BOOL)isCache
{
    NSString* str=[ZZUrlTool fullUrlWithTail:@"/Content/Event/latest_event"];
    
    NSMutableDictionary* d=[self pageParams];
    [d setValue:[NSNumber numberWithInteger:page] forKey:@"page"];
    [d setValue:[NSNumber numberWithInteger:size] forKey:@"pagesize"];
    [self get:str params:d usingCache:isCache success:^(NSDictionary *responseObject) {
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

+(void)getNeewsListPage:(NSInteger)page success:(void (^)(NSArray *))success isCache:(BOOL)isCache
{
    NSMutableDictionary* d=[self pageParams];
    [d setValue:[NSNumber numberWithInteger:page] forKey:@"page"];
    NSString* str=[ZZUrlTool fullUrlWithTail:@"/Content/News/index"];
    [self get:str params:d usingCache:isCache success:^(NSDictionary *resp) {
        NSDictionary* data=[resp valueForKey:@"data"];
        NSArray* list=[data valueForKey:@"list"];
        NSMutableArray* sou=[NSMutableArray array];
        for (NSDictionary* cl in list) {
            BaseModel* m=[[BaseModel alloc]initWithDictionary:cl];
            [sou addObject:m];
        }
        if (sou.count>0) {
            if (success) {
                success(sou);
            }
        }
    } failure:^(NSError *err) {
        
    }];
}

+(void)getSysMsgListPage:(NSInteger)page success:(void (^)(NSArray *))success isCache:(BOOL)isCache
{
    NSMutableDictionary* d=[self pageParams];
    [d setValue:[NSNumber numberWithInteger:page] forKey:@"page"];
    NSString* str=[ZZUrlTool fullUrlWithTail:@"/Content/Sysmsg/index"];
    [self get:str params:d usingCache:isCache success:^(NSDictionary *resp) {
        NSDictionary* data=[resp valueForKey:@"data"];
        NSArray* list=[data valueForKey:@"list"];
        NSMutableArray* sou=[NSMutableArray array];
        for (NSDictionary* cl in list) {
            BaseModel* m=[[BaseModel alloc]initWithDictionary:cl];
            [sou addObject:m];
        }
        if (sou.count>0) {
            if (success) {
                success(sou);
            }
        }
    } failure:^(NSError *err) {
        
    }];
}

@end
