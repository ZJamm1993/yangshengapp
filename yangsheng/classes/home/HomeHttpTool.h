//
//  HomeHttpTool.h
//  yangsheng
//
//  Created by Macx on 17/7/7.
//  Copyright © 2017年 jam. All rights reserved.
//

#import "ZZHttpTool.h"
#import "BaseModel.h"

//#import "ModelProductClass.h"
//#import "ModelQA.h"
//#import "ModelFounder.h"
//#import "ModelAdvs.h"
//#import "ModelEnterpriseAdv.h"
//#import "ModelMonthStar.h"
//#import "ModelTeamExpand.h"

@interface HomeHttpTool : ZZHttpTool

+(void)getProductClassSuccess:(void(^) (NSArray* datasource))success isCache:(BOOL)isCache;

+(void)getQuesAnsRandomSuccess:(void(^) (NSArray* datasource))success isCache:(BOOL)isCache;

+(void)getFoundersSuccess:(void(^) (NSArray* datasource))success isCache:(BOOL)isCache;

+(void)getAdversType:(NSInteger)type success:(void(^) (NSArray* datasource))success isCache:(BOOL)isCache;

+(void)getEnterAdvSuccess:(void(^) (NSArray* datasource))success isCache:(BOOL)isCache;

+(void)getMonthStarPage:(NSInteger)page size:(NSInteger)size success:(void(^) (NSArray* datasource))success isCache:(BOOL)isCache;

+(void)getTeamsPage:(NSInteger)page size:(NSInteger)size success:(void(^) (NSArray* datasource))success isCache:(BOOL)isCache;

+(void)getExpandPage:(NSInteger)page size:(NSInteger)size success:(void(^) (NSArray* datasource))success isCache:(BOOL)isCache;

+(void)getProductListType:(NSInteger)type page:(NSInteger)page success:(void(^) (NSArray* datasource))success isCache:(BOOL)isCache;

+(void)searchProductName:(NSString*)name page:(NSInteger)page success:(void(^) (NSArray* datasource))success isCache:(BOOL)isCache;

+(void)getQAListPage:(NSInteger)page success:(void(^) (NSArray* datasource))success isCache:(BOOL)isCache;

+(void)getFeedbackAllListSize:(NSInteger)size success:(void(^) (NSArray* sections,NSArray* rows))success isCache:(BOOL)isCache;

+(void)getFeedbackListType:(NSInteger)type page:(NSInteger)page success:(void(^) (NSArray* datasource))success isCache:(BOOL)isCache;

+(void)getBrandEventPage:(NSInteger)page size:(NSInteger)size success:(void(^) (NSArray* datasource))success isCache:(BOOL)isCache;

+(void)getLatestEventPage:(NSInteger)page size:(NSInteger)size success:(void(^) (NSArray* datasource))success isCache:(BOOL)isCache;

+(void)getNeewsListPage:(NSInteger)page success:(void(^) (NSArray* datasource))success isCache:(BOOL)isCache;

+(void)getSysMsgListPage:(NSInteger)page success:(void(^) (NSArray* datasource))success isCache:(BOOL)isCache;

+(void)getProductCodeWithQRCode:(NSString*)qrcode success:(void(^) (NSDictionary* data))success isCache:(BOOL)isCache;

+(void)getProductCheckWithNum:(NSString*)num success:(void(^) (NSDictionary* data))success isCache:(BOOL)isCache;


@end
