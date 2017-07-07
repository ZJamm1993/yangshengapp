//
//  ModelQA.h
//  yangsheng
//
//  Created by Macx on 17/7/7.
//  Copyright © 2017年 jam. All rights reserved.
//

#import "BaseModel.h"

@interface ModelQA : BaseModel

@property (nonatomic,strong) NSString* idd;
@property (nonatomic,strong) NSString* post_title;
@property (nonatomic,strong) NSString* post_excerpt;
@property (nonatomic,assign) NSInteger post_hits;

@end
