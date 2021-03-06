//
//  UniversalModel.m
//  yangsheng
//
//  Created by Macx on 17/7/21.
//  Copyright © 2017年 jam. All rights reserved.
//

#import "UniversalModel.h"

#define UniversalKey @"f92uv9m3utfj34fj83934d"

@implementation UniversalModel

-(instancetype)initWithDictionary:(NSDictionary *)dictionary
{
    self=[super init];
    
    if ([dictionary isKindOfClass:[NSDictionary class]]) {
        _dictionary=dictionary;
        _qq_number=[dictionary valueForKey:@"qq_number"];
        _wx_path=[dictionary valueForKey:@"wx_path"];
        
        NSArray* phps=[dictionary valueForKey:@"photo"];
        NSMutableArray* phpsMoa=[NSMutableArray array];
        for (NSDictionary* d in phps) {
            WaiterModel* ser=[[WaiterModel alloc]initWithDictionary:d];
            [phpsMoa addObject:ser];
        }
        _photos=phpsMoa;
    }
    return self;
}

+(void)saveUniversal:(UniversalModel *)universal
{
//    NSMutableDictionary* d=[NSMutableDictionary dictionary];
//    
//    [d setValue:universal.qq_number forKey:@"qq_number"];
//    [d setValue:universal.wx_path forKey:@"wx_path"];
    
    NSData* data=[NSJSONSerialization dataWithJSONObject:universal.dictionary options:NSJSONWritingPrettyPrinted error:nil];
    
    [[NSUserDefaults standardUserDefaults]setValue:data forKey:UniversalKey];
}

+(instancetype)getUniversal
{
    NSData * data=[[NSUserDefaults standardUserDefaults]valueForKey:UniversalKey];
    if (![data isKindOfClass:[NSData class]]) {
        [[NSUserDefaults standardUserDefaults]removeObjectForKey:UniversalKey];
        return nil;
    }
    if (data.length==0) {
        return nil;
    }
    NSDictionary* d=[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
    UniversalModel* u=[[UniversalModel alloc]initWithDictionary:d];
    return u;
}

@end

@implementation WaiterModel

-(instancetype)initWithDictionary:(NSDictionary *)dictionary
{
    self=[super init];
    
    if ([dictionary isKindOfClass:[NSDictionary class]]) {
        _alt=[dictionary valueForKey:@"alt"];
        _url=[dictionary valueForKey:@"url"];
    }
    return self;
}

@end
