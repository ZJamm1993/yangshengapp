//
//  PosterTool.h
//  yangsheng
//
//  Created by bangju on 2017/11/3.
//  Copyright © 2017年 jam. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LargePosterView.h"

@interface PosterTool : NSObject<LargePosterDelegate>

@property (nonatomic,assign) BOOL showed;

+(void)show1111ActivityIfNeed;

@end
