//
//  UserModel.m
//  yangsheng
//
//  Created by Macx on 17/7/12.
//  Copyright © 2017年 jam. All rights reserved.
//

#import "UserModel.h"

#define UserKey @"CW5QPB0hXYfXt3zY8QKLI8ahj95yMPdF"
#define UserPasswordKey @"CW5QPB0hXYfXt3zY8QK99I8ahj95yMPdF"

@implementation UserModel

-(instancetype)initWithDictionary:(NSDictionary *)dictionary
{
    self=[super init];
    
    if ([dictionary isKindOfClass:[NSDictionary class]]) {
        _access_token=[dictionary valueForKey:@"access_token"];
        _user_nicename=[dictionary valueForKey:@"user_nicename"];
        _avatar=[dictionary valueForKey:@"avatar"];
        _mobile=[dictionary valueForKey:@"mobile"];
        _idd=[dictionary valueForKey:@"id"];
    }
    
    if (_access_token.length==0) {
        return nil;
    }
    
    return self;
}

+(void)saveUser:(UserModel *)user
{
    if (user.access_token.length==0) {
        return;
    }
    NSMutableDictionary* d=[NSMutableDictionary dictionary];
    
    [d setValue:user.access_token forKey:@"access_token"];
    [d setValue:user.user_nicename forKey:@"user_nicename"];
    [d setValue:user.avatar forKey:@"avatar"];
    [d setValue:user.mobile forKey:@"mobile"];
    [d setValue:user.idd forKey:@"id"];
    
    NSData* data=[NSJSONSerialization dataWithJSONObject:d options:NSJSONWritingPrettyPrinted error:nil];
    
    [[NSUserDefaults standardUserDefaults]setValue:data forKey:UserKey];
}

+(instancetype)getUser
{
    NSData * data=[[NSUserDefaults standardUserDefaults]valueForKey:UserKey];
    if (![data isKindOfClass:[NSData class]]) {
        [self deleteUser];
        return nil;
    }
    if (data.length==0) {
        return nil;
    }
    NSDictionary* d=[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
    UserModel* user=[[UserModel alloc]initWithDictionary:d];
    NSLog(@"%@",d);
    return user;
}

+(void)deleteUser
{
    [[NSUserDefaults standardUserDefaults]removeObjectForKey:UserKey];
}

+(NSString*)getPassword
{
    NSData* data=[[NSUserDefaults standardUserDefaults]valueForKey:UserPasswordKey];
    if (![data isKindOfClass:[NSData class]]) {
        [self deletePassword];
        return nil;
    }
    if (data.length==0) {
        return nil;
    }
    NSString *str = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
    return str;
}

+(void)savePassword:(NSString *)password
{
    if (password.length==0) {
        return;
    }
    NSData* data=[password dataUsingEncoding:NSUTF8StringEncoding];
    [[NSUserDefaults standardUserDefaults]setValue:data forKey:UserPasswordKey];
}

+(void)deletePassword
{
    [[NSUserDefaults standardUserDefaults]removeObjectForKey:UserPasswordKey];
}

@end
