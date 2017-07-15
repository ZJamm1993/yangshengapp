//
//  StoreHttpTool.h
//  yangsheng
//
//  Created by Macx on 17/7/13.
//  Copyright © 2017年 jam. All rights reserved.
//

#import "ZZHttpTool.h"
#import "StoreModel.h"
#import "CityModel.h"

@interface StoreHttpTool : ZZHttpTool

+(void)getNeighbourStoreListPage:(NSInteger)page lng:(NSString*)lng lat:(NSString*)lat mult:(NSInteger)mult cityCode:(NSString*)cityCode success:(void(^) (NSArray* datasource))success isCache:(BOOL)isCache;

+(void)searchStoreWithKeyword:(NSString*)keyword page:(NSInteger)page success:(void(^) (NSArray* datasource))success isCache:(BOOL)isCache;

+(void)getStoreItemsSuccess:(void(^) (NSArray* datasource))success isCache:(BOOL)isCache;

+(void)getStoreDetailWithId:(NSString*)idd success:(void(^) (NSArray* datasource))success isCache:(BOOL)isCache;

+(void)getCitysWithLevel:(NSString*)level keywords:(NSString*)keywords success:(void(^) (NSArray* datasource))success isCache:(BOOL)isCache;

@end
