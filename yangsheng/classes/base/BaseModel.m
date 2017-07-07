//
//  BaseModel.m
//  yangsheng
//
//  Created by Macx on 17/7/7.
//  Copyright © 2017年 jam. All rights reserved.
//

#import "BaseModel.h"

@implementation BaseModel

-(instancetype)initWithDictionary:(NSDictionary *)dictionary
{
    self=[super init];
    
    self.rawDictionary=dictionary;
    
    return self;
}

@end
