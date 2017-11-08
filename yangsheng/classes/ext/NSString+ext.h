//
//  NSString+ext.h
//  yangsheng
//
//  Created by Macx on 17/7/12.
//  Copyright © 2017年 jam. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (ext)

-(NSURL*)urlWithMainUrl;

-(BOOL)isMobileNumber;
-(BOOL)isIdNumber;

@property (nonatomic,assign) BOOL passwordLength;

@end
