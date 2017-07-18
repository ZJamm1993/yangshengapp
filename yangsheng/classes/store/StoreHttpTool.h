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

+(void)getAllStoreListPage:(NSInteger)page success:(void (^)(NSArray *))success isCache:(BOOL)isCache;

+(void)getAllStoreMapListSuccess:(void(^)(NSArray*))success isCache:(BOOL)isCache;

+(void)searchStoreWithKeyword:(NSString*)keyword page:(NSInteger)page success:(void(^) (NSArray* datasource))success isCache:(BOOL)isCache;

+(void)getStoreItemsSuccess:(void(^) (NSArray* datasource))success isCache:(BOOL)isCache;

+(void)getStoreDetailWithId:(NSString*)idd success:(void(^) (NSArray* datasource))success isCache:(BOOL)isCache;

+(void)getCitysWithLevel:(NSString*)level keywords:(NSString*)keywords success:(void(^) (NSArray* datasource))success isCache:(BOOL)isCache;

+(void)getApplyResultWithToken:(NSString*)token success:(void(^) (StoreApplyModel* applyModel))success;

+(void)uploadIDCard:(UIImage *)idcard token:(NSString *)token success:(void (^)(NSString *))success;

+(void)applyStoreSubmitName:(NSString*)name tel:(NSString*)tel idcard:(NSString*)idcard area:(NSString*)area address:(NSString*)address positive:(NSString*)positive negative:(NSString*)negative token:(NSString*)token success:(void(^)(BOOL applied,NSString* msg))success;

+(void)appointStoreWithStoreId:(NSString*)storeid date:(NSString*)date tel:(NSString*)tel itemName:(NSString*)itemName token:(NSString*)token success:(void(^)(BOOL appointed,NSString* msg))success;

+(void)getAllAppointmentListPage:(NSInteger)page token:(NSString *)token success:(void (^)(NSArray *))success isCache:(BOOL)isCache;

+(void)cancelAppointmentId:(NSString*)idd token:(NSString*)token success:(void(^)(BOOL applied,NSString* msg))success;

@end
