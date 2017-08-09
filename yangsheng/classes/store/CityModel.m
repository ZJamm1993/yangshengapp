//
//  CityModel.m
//  yangsheng
//
//  Created by Macx on 17/7/15.
//  Copyright © 2017年 jam. All rights reserved.
//

#import "CityModel.h"

@implementation CityModel

-(instancetype)initWithDictionary:(NSDictionary *)dictionary
{
    self=[super init];
    if ([dictionary isKindOfClass:[NSDictionary class]]) {
        _rawDictionary=dictionary;
        
        _citycode=[dictionary valueForKey:@"citycode"];
        _name=[dictionary valueForKey:@"name"];
        _adcode=[dictionary valueForKey:@"adcode"];
        _level=[dictionary valueForKey:@"level"];
//        if (_citycode.length==0) {
//            return nil;
//        }
        if (_name.length==0) {
            _name=[dictionary valueForKey:@"city"];
        }
    }
    return self;
}

+(void)saveCity:(CityModel*)city
{
    NSMutableDictionary* c=[NSMutableDictionary dictionary];
    [c setValue:city.citycode forKey:@"citycode"];
    [c setValue:city.name forKey:@"name"];
    [c setValue:city.adcode forKey:@"adcode"];
    [c setValue:city.level forKey:@"level"];
    [[NSUserDefaults standardUserDefaults]setValue:c forKey:CityCacheKey];
}

+(CityModel*)getCity
{
    NSDictionary* c=[[NSUserDefaults standardUserDefaults]valueForKey:CityCacheKey];
    CityModel* m=[[CityModel alloc]initWithDictionary:c];
    return m;
}

@end
