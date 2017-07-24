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

@property (nonatomic,strong) NSString* qq_number;
@property (nonatomic,strong) NSString* wx_path;

@end
