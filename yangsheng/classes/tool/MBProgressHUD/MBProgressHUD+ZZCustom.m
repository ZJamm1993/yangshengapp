//
//  MBProgressHUD+ZZCustom.m
//  yangsheng
//
//  Created by Macx on 17/7/12.
//  Copyright © 2017年 jam. All rights reserved.
//

#import "MBProgressHUD+ZZCustom.h"

static MBProgressHUD* lastShowingHUD;

@implementation MBProgressHUD (ZZCustom)

+(void)removeLastOne;
{
    if (lastShowingHUD) {
        [lastShowingHUD hideAnimated:NO];
        lastShowingHUD=nil;
    }
}

+(void)showSuccessMessage:(NSString *)msg
{
    [self removeLastOne];
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:[UIApplication sharedApplication].keyWindow animated:YES];
    
    // Set the custom view mode to show any view.
    hud.mode = MBProgressHUDModeCustomView;
    // Set an image view with a checkmark.
    UIImage *image = [[UIImage imageNamed:@"Checkmark"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    hud.customView = [[UIImageView alloc] initWithImage:image];
    // Looks a bit nicer if we make it square.
//    hud.square = YES;
    // Optional label text.
    hud.label.text = msg;
    
    [hud hideAnimated:YES afterDelay:1.f];
    
}

+(void)showErrorMessage:(NSString *)msg
{
    [self removeLastOne];
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:[UIApplication sharedApplication].keyWindow animated:YES];
    
    // Set the text mode to show only text.
    hud.mode = MBProgressHUDModeText;
    hud.label.text = msg;
    // Move to bottm center.
//    hud.offset = CGPointMake(0.f, MBProgressMaxOffset);
    
    [hud hideAnimated:YES afterDelay:1.2f];
}

+(void)showProgressMessage:(NSString *)msg
{
    [self removeLastOne];
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:[UIApplication sharedApplication].keyWindow animated:YES];
    
    // Set the determinate mode to show task progress.
    hud.mode = MBProgressHUDModeIndeterminate;
    hud.label.text = msg;
//    [hud hideAnimated:YES afterDelay:20];
    
    lastShowingHUD=hud;
    
}

+(void)hide
{
    if (lastShowingHUD) {
        [lastShowingHUD hideAnimated:YES];
    }
}

@end
