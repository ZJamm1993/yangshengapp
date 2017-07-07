//
//  ModelAdvs.m
//  yangsheng
//
//  Created by Macx on 17/7/7.
//  Copyright © 2017年 jam. All rights reserved.
//

#import "ModelAdvs.h"

@implementation ModelAdvs

-(instancetype)initWithDictionary:(NSDictionary *)dictionary
{
    self=[super initWithDictionary:dictionary];
    
    _idd=[dictionary valueForKey:@"id"];
    _name=[dictionary valueForKey:@"name"];
    _thumb=[dictionary valueForKey:@"thumb"];
    
    return self;
}

@end
