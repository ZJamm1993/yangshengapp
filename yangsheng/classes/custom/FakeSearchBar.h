//
//  FakeSearchBar.h
//  yangsheng
//
//  Created by Macx on 17/7/13.
//  Copyright © 2017年 jam. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FakeSearchBar : UIControl

+(instancetype)fakeSearchBarWithFrame:(CGRect)frame title:(NSString*)title;

+(instancetype)defaultSearchBarWithTitle:(NSString*)title;

@end
