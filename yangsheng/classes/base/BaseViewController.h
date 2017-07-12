//
//  BaseViewController.h
//  yangsheng
//
//  Created by jam on 17/7/6.
//  Copyright © 2017年 jam. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseViewController : UIViewController

-(void)startCountDownSeconds:(NSInteger)second;
-(void)countingDownSeconds:(NSInteger)second;
-(void)endingCountDown;

@end
