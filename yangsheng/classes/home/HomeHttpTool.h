//
//  HomeHttpTool.h
//  yangsheng
//
//  Created by Macx on 17/7/7.
//  Copyright © 2017年 jam. All rights reserved.
//

#import "ZZHttpTool.h"
#import "ModelProductClass.h"
#import "ModelQA.h"
#import "ModelFounder.h"
#import "ModelAdvs.h"

@interface HomeHttpTool : ZZHttpTool

+(void)getProductClassSuccess:(void(^) (NSArray* datasource))success isCache:(BOOL)isCache;

+(void)getQuesAnsRandomSuccess:(void(^) (NSArray* datasource))success isCache:(BOOL)isCache;

+(void)getFoundersSuccess:(void(^) (NSArray* datasource))success isCache:(BOOL)isCache;

+(void)getAdversSuccess:(void(^) (NSArray* datasource))success isCache:(BOOL)isCache;

@end
