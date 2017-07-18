//
//  ClassroomHttpTool.h
//  yangsheng
//
//  Created by Macx on 17/7/14.
//  Copyright © 2017年 jam. All rights reserved.
//

#import "ZZHttpTool.h"
#import "BaseModel.h"

@interface ClassroomHttpTool : ZZHttpTool

+(void)getClassroomListType:(NSInteger)type page:(NSInteger)page size:(NSInteger)size success:(void(^) (NSArray* datasource))success isCache:(BOOL)isCache;

+(void)getClassroomCollectionListPage:(NSInteger)page size:(NSInteger)size token:(NSString*)token success:(void(^) (NSArray* datasource))success isCache:(BOOL)isCache;

+(void)cancelCollectionId:(NSString *)idd token:(NSString *)token success:(void (^)(BOOL, NSString *))success;

@end
