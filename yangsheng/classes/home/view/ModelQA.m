//
//  ModelQA.m
//  yangsheng
//
//  Created by Macx on 17/7/7.
//  Copyright © 2017年 jam. All rights reserved.
//

#import "ModelQA.h"

@implementation ModelQA

-(instancetype)initWithDictionary:(NSDictionary *)dictionary
{
    self=[super initWithDictionary:dictionary];
    
    _idd=[dictionary valueForKey:@"id"];
    _post_title=[dictionary valueForKey:@"post_title"];
    _post_excerpt=[dictionary valueForKey:@"post_excerpt"];
    _post_hits=[[dictionary valueForKey:@"post_hits"]integerValue];
    
    return self;
}

@end
