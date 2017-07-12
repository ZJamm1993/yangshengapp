//
//  UserModel.m
//  yangsheng
//
//  Created by Macx on 17/7/12.
//  Copyright © 2017年 jam. All rights reserved.
//

#import "UserModel.h"

#define UserKey @"CW5QPB0hXYfXt3zY8QKLI8ahj95yMPdF"

@implementation UserModel

-(instancetype)initWithDictionary:(NSDictionary *)dictionary
{
    self=[super init];
    
    if ([dictionary isKindOfClass:[NSDictionary class]]) {
        _access_token=[dictionary valueForKey:@"access_token"];
        _user_nicename=[dictionary valueForKey:@"user_nicename"];
        _avatar=[dictionary valueForKey:@"avatar"];
        _mobile=[dictionary valueForKey:@"mobile"];
    }
    
    if (_access_token.length==0) {
        return nil;
    }
    
    return self;
}

+(void)saveUser:(UserModel *)user
{
    NSMutableDictionary* d=[NSMutableDictionary dictionary];
    
    [d setValue:user.access_token forKey:@"access_token"];
    [d setValue:user.user_nicename forKey:@"user_nicename"];
    [d setValue:user.avatar forKey:@"avatar"];
    [d setValue:user.mobile forKey:@"mobile"];
    
    [[NSUserDefaults standardUserDefaults]setValue:d forKey:UserKey];
}

+(instancetype)getUser
{
    NSDictionary* d=[[NSUserDefaults standardUserDefaults]valueForKey:UserKey];
    
    UserModel* user=[[UserModel alloc]initWithDictionary:d];
    NSLog(@"%@",d);
    return user;
}

+(void)deleteUser
{
    [[NSUserDefaults standardUserDefaults]setValue:nil forKey:UserKey];
}

@end
