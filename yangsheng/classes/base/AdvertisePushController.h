//
//  AdvertisePushController.h
//  yangsheng
//
//  Created by bangju on 2017/11/1.
//  Copyright © 2017年 jam. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseWebViewController.h"
#import "BaseModel.h"
#import "UserModel.h"

@interface AdvertisePushController : NSObject

+(void)handleController:(UIViewController*)viewController withObject:(BaseModel*)object;

@end
