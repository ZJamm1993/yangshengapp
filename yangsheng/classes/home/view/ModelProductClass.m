//
//  ModelProductClass.m
//  yangsheng
//
//  Created by Macx on 17/7/7.
//  Copyright © 2017年 jam. All rights reserved.
//

#import "ModelProductClass.h"

@implementation ModelProductClass

-(instancetype)initWithDictionary:(NSDictionary *)dictionary
{
    self=[super initWithDictionary:dictionary];
    
    _cid=[dictionary valueForKey:@"cid"];
    _name=[dictionary valueForKey:@"name"];
    _thumb=[dictionary valueForKey:@"thumb"];
    
    return self;
}

@end
