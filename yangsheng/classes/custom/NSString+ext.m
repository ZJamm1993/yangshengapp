//
//  NSString+ext.m
//  yangsheng
//
//  Created by Macx on 17/7/12.
//  Copyright © 2017年 jam. All rights reserved.
//

#import "NSString+ext.h"

@implementation NSString (ext)

-(NSURL*)urlWithMainUrl
{
    return [NSURL URLWithString:[ZZUrlTool fullUrlWithTail:self]];
}

-(void)setPasswordLength:(BOOL)passwordLength
{
    
}

-(BOOL)passwordLength
{
    return self.length>=5&&self.length<=20;
}

@end
