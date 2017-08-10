//
//  UniversalModel.h
//  yangsheng
//
//  Created by Macx on 17/7/21.
//  Copyright © 2017年 jam. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UniversalModel : NSObject

+(void)saveUniversal:(UniversalModel*)universal;
+(instancetype)getUniversal;
-(instancetype)initWithDictionary:(NSDictionary*)dictionary;

@property (nonatomic,strong) NSDictionary* dictionary;

@property (nonatomic,strong) NSString* qq_number;
@property (nonatomic,strong) NSString* wx_path;

@property (nonatomic,strong) NSArray* photos;

@end

@interface WaiterModel : NSObject
-(instancetype)initWithDictionary:(NSDictionary *)dictionary;

@property (nonatomic,strong) NSString* url;
@property (nonatomic,strong) NSString* alt;

@end
