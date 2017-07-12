//
//  MBProgressHUD+ZZCustom.h
//  yangsheng
//
//  Created by Macx on 17/7/12.
//  Copyright © 2017年 jam. All rights reserved.
//

#import "MBProgressHUD.h"

@interface MBProgressHUD (ZZCustom)

+(void)hide;

+(void)showSuccessMessage:(NSString*)msg;

+(void)showErrorMessage:(NSString*)msg;

+(void)showProgressMessage:(NSString*)msg;

@end
