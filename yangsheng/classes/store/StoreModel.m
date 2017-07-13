//
//  StoreModel.m
//  yangsheng
//
//  Created by Macx on 17/7/13.
//  Copyright © 2017年 jam. All rights reserved.
//

#import "StoreModel.h"

@implementation StoreModel

-(instancetype)initWithDictionary:(NSDictionary *)dictionary
{
    self=[super init];
    if ([dictionary isKindOfClass:[NSDictionary class]]) {
        _rawDictionary=dictionary;
        
        _idd=[dictionary valueForKey:@"id"];
        _store_title=[dictionary valueForKey:@"store_title"];
        _store_author=[dictionary valueForKey:@"store_author"];
        _store_tel=[dictionary valueForKey:@"store_tel"];
        _store_address=[dictionary valueForKey:@"store_address"];
        _thumb=[dictionary valueForKey:@"thumb"];
        _lng=[dictionary valueForKey:@"lng"];
        _lat=[dictionary valueForKey:@"lat"];
        _distance=[dictionary valueForKey:@"distance"];
    }
    return self;
}

@end
