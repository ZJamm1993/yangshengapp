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

+(void)getProductClassSuccess:(void(^) (NSArray* datasource))success;

+(void)getQuesAnsRandomSuccess:(void(^) (NSArray* datasource))success;

+(void)getFoundersSuccess:(void(^) (NSArray* datasource))success;

+(void)getAdversSuccess:(void(^) (NSArray* datasource))success;

@end
