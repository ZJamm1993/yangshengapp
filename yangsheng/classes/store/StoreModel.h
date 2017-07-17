//
//  StoreModel.h
//  yangsheng
//
//  Created by Macx on 17/7/13.
//  Copyright © 2017年 jam. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface StoreModel : NSObject

-(instancetype)initWithDictionary:(NSDictionary*)dictionary;

@property (nonatomic,strong) NSDictionary* rawDictionary;

@property (nonatomic,strong) NSString* idd;
@property (nonatomic,strong) NSString* store_title;
@property (nonatomic,strong) NSString* store_author;
@property (nonatomic,strong) NSString* store_tel;
@property (nonatomic,strong) NSString* store_address;
@property (nonatomic,strong) NSString* thumb;
@property (nonatomic,strong) NSString* lng;
@property (nonatomic,strong) NSString* lat;
@property (nonatomic,strong) NSString* distance;

@property (nonatomic,strong) NSString* store_content;
@property (nonatomic,strong) NSArray* smetas;
@property (nonatomic,strong) NSArray* items;

@end

@interface StoreItem : NSObject

@property (nonatomic,strong) NSString* item_id;
@property (nonatomic,strong) NSString* name;
@property (nonatomic,strong) NSString* code;
@property (nonatomic,strong) NSString* thumb;

-(instancetype)initWithDictionary:(NSDictionary*)dictionary;

@end

////

@interface StoreApplyModel : NSObject

-(instancetype)initWithDictionary:(NSDictionary*)dictionary;

@property (nonatomic,strong) NSDictionary* rawDictionary;

@property (nonatomic,strong) NSString* name;
@property (nonatomic,strong) NSString* tel;
@property (nonatomic,strong) NSString* idcard;
@property (nonatomic,strong) NSString* area;
@property (nonatomic,strong) NSString* address;
@property (nonatomic,strong) NSString* lng;
@property (nonatomic,strong) NSString* lat;
@property (nonatomic,assign) NSInteger status;
@property (nonatomic,strong) NSString* info;
@property (nonatomic,strong) NSString* positive;
@property (nonatomic,strong) NSString* negative;

@end