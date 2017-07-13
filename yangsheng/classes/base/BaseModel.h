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

@property (nonatomic,strong) NSString* cid;
@property (nonatomic,strong) NSString* name;
@property (nonatomic,strong) NSString* thumb;

@property (nonatomic,strong) NSString* idd;
@property (nonatomic,strong) NSString* post_title;
@property (nonatomic,strong) NSString* post_excerpt;
@property (nonatomic,assign) NSInteger post_hits;

@property (nonatomic,strong) NSString* post_content;
@property (nonatomic,strong) NSString* mp4_path;

@property (nonatomic,strong) NSString* post_modified;

@property (nonatomic,strong) NSString* ios_content;

@property (nonatomic,strong) NSString* post_subtitle;

@property (nonatomic,strong) NSString* ddescription;

@property (nonatomic,strong) NSString* post_author;
@property (nonatomic,strong) NSString* post_label;

@end
