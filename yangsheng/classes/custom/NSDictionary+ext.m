//
//  NSDictionary+ext.m
//  yangsheng
//
//  Created by Macx on 17/7/12.
//  Copyright © 2017年 jam. All rights reserved.
//

#import "NSDictionary+ext.h"

@implementation NSDictionary (ext)

-(void)setCode:(NSInteger)code
{
    
}

-(NSInteger)code
{
    return [[self valueForKey:@"code"]integerValue];
}

@end
