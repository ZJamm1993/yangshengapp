//
//  BaseModel.m
//  yangsheng
//
//  Created by Macx on 17/7/7.
//  Copyright © 2017年 jam. All rights reserved.
//

#import "BaseModel.h"

@implementation BaseModel

-(instancetype)initWithDictionary:(NSDictionary *)dictionary
{
    self=[super init];
    
    if ([dictionary isKindOfClass:[NSDictionary class]]) {
        self.rawDictionary=dictionary;
        
        _cid=[dictionary valueForKey:@"cid"];
        _name=[dictionary valueForKey:@"name"];
        _thumb=[dictionary valueForKey:@"thumb"];
        
        _idd=[dictionary valueForKey:@"id"];
        _post_title=[dictionary valueForKey:@"post_title"];
        _post_excerpt=[dictionary valueForKey:@"post_excerpt"];
        _post_hits=[[dictionary valueForKey:@"post_hits"]integerValue];
        
        _post_content=[dictionary valueForKey:@"post_content"];
        _ios_content=[dictionary valueForKey:@"ios_content"];
        _mp4_path=[dictionary valueForKey:@"mp4_path"];
        
        _post_modified=[dictionary valueForKey:@"post_modified"];
        
        _post_subtitle=[dictionary valueForKey:@"post_subtitle"];
        
        _ddescription=[dictionary valueForKey:@"description"];
        
        _post_author=[dictionary valueForKey:@"post_author"];
        _post_label=[dictionary valueForKey:@"post_label"];
    }
    
    return self;
}

@end
