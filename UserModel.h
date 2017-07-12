//
//  UserModel.h
//  yangsheng
//
//  Created by Macx on 17/7/12.
//  Copyright © 2017年 jam. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserModel : NSObject

+(void)saveUser:(UserModel*)user;
+(instancetype)getUser;
+(void)deleteUser;

-(instancetype)initWithDictionary:(NSDictionary*)dictionary;

@property (nonatomic,strong) NSString* mobile;
@property (nonatomic,strong) NSString* user_nicename;
@property (nonatomic,strong) NSString* access_token;
@property (nonatomic,strong) NSString* avatar;

@end
