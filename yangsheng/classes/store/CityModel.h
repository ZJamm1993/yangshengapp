//
//  CityModel.h
//  yangsheng
//
//  Created by Macx on 17/7/15.
//  Copyright © 2017年 jam. All rights reserved.
//

#import <Foundation/Foundation.h>

#define CityCacheKey @"adofioij203202r2r"

#define CityLevelProvince @"province"
#define CityLevelCity @"city"

@interface CityModel : NSObject

-(instancetype)initWithDictionary:(NSDictionary*)dictionary;

@property (nonatomic,strong) NSDictionary* rawDictionary;

@property (nonatomic,strong) NSString* citycode;
@property (nonatomic,strong) NSString* name;
@property (nonatomic,strong) NSString* adcode;
@property (nonatomic,strong) NSString* level;

+(CityModel*)getCity;
+(void)saveCity:(CityModel*)city;

@end
