//
//  WBWebProgressBar.h
//  WBWebProgressBar
//
//  Created by Jamm on 16/1/20.
//  Copyright © 2016年 Jamm. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WBWebProgressBar : UIView

@property (nonatomic)UIColor* progressTintColor;

-(void)WBWebProgressPreparing;
-(void)WBWebProgressStartLoading;
-(void)WBWebProgressCompleted;

@end
