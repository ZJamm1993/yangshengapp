//
//  UniversalHttpTool.h
//  yangsheng
//
//  Created by Macx on 17/7/21.
//  Copyright © 2017年 jam. All rights reserved.
//

#import "ZZHttpTool.h"
#import "UniversalModel.h"

@interface UniversalHttpTool : ZZHttpTool

+(void)getUniversalProfileSuccess:(void(^) (UniversalModel* univaer))success isCache:(BOOL)isCache;

@end
