//
//  NothingWarningView.h
//  yangsheng
//
//  Created by Macx on 17/7/20.
//  Copyright © 2017年 jam. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NothingWarningView : UIView

+(instancetype)nothingViewWithWarning:(NSString*)str;

@property (weak, nonatomic) IBOutlet UILabel *label;

@end
