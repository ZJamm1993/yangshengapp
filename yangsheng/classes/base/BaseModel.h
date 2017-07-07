//
//  BaseModel.h
//  yangsheng
//
//  Created by Macx on 17/7/7.
//  Copyright © 2017年 jam. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BaseModel : NSObject

@property (nonatomic,strong) NSDictionary* rawDictionary;

-(instancetype)initWithDictionary:(NSDictionary*)dictionary;

@end
