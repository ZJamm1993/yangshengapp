//
//  LargePosterView.h
//  yangsheng
//
//  Created by bangju on 2017/11/2.
//  Copyright © 2017年 jam. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol LargePosterDelegate <NSObject>

@optional
-(void)largePosterDidTappedUrl:(NSString*)url;

@end

@interface LargePosterView : UIView

@property (nonatomic,weak) id<LargePosterDelegate>delegate;
@property (nonatomic,strong) NSString* imageName;
@property (nonatomic,strong) NSString* url;

+(instancetype)posterWithImageName:(NSString*)imageName url:(NSString*)url delegate:(id)delegate;

-(void)show;
-(void)hide;

@end
