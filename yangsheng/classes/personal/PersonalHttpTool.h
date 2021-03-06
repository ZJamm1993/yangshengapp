//
//  PersonalHttpTool.h
//  yangsheng
//
//  Created by Macx on 17/7/12.
//  Copyright © 2017年 jam. All rights reserved.
//

#import "ZZHttpTool.h"
#import "UserModel.h"

@interface PersonalHttpTool : ZZHttpTool

+(void)getCodeWithMobile:(NSString*)mobile success:(void(^)(BOOL sent,NSString* msg))success;

+(void)registerUserWithMobile:(NSString*)mobile password:(NSString*)password code:(NSString*)code invite:(NSString*)invite success:(void(^) (UserModel* user,NSString* msg))success;

+(void)loginUserWithMobile:(NSString*)mobile password:(NSString*)password success:(void(^) (UserModel* user))success;
+(void)loginUserWithWechatCode:(NSString*)code success:(void(^)(UserModel* user))success;

+(void)uploadAvatar:(UIImage*)avatar token:(NSString*)token success:(void(^)(NSString* imageUrl))success;

+(void)changePasswordWithMobile:(NSString*)mobile password:(NSString*)password code:(NSString*)code success:(void(^) (BOOL changed,NSString* msg))success;

+(void)changePasswordWithOldPassword:(NSString*)old newPassword:(NSString*)neew token:(NSString*)token success:(void(^)(BOOL changed,NSString* msg))success;

+(void)changeUserNickName:(NSString*)nick token:(NSString*)token success:(void(^)(BOOL changed))success;

+(void)changeUserMobile:(NSString*)mobile code:(NSString*)code token:(NSString*)token success:(void(^)(BOOL changed,NSString* msg))success;

+(void)logOutUserToken:(NSString*)token;

+(void)getUserInfoWithToken:(NSString*)token success:(void(^)(UserModel* user))success;
@end
