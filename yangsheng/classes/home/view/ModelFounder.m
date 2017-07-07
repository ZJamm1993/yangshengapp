//
//  ModelFounder.m
//  yangsheng
//
//  Created by Macx on 17/7/7.
//  Copyright © 2017年 jam. All rights reserved.
//

#import "ModelFounder.h"

@implementation ModelFounder

-(instancetype)initWithDictionary:(NSDictionary *)dictionary
{
    self=[super initWithDictionary:dictionary];
    
    _idd=[dictionary valueForKey:@"id"];
    _post_title=[dictionary valueForKey:@"post_title"];
    _thumb=[dictionary valueForKey:@"thumb"];
    
    return self;
}

@end
