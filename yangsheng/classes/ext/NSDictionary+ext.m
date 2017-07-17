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
    if([[self allKeys]containsObject:@"code"])
    {
        return [[self valueForKey:@"code"]integerValue];
    }
    return -1;
}

-(void)setLength:(NSUInteger)length
{
    
}

-(NSUInteger)length
{
    return self.count;
}

@end
