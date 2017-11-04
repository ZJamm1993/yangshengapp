//
//  PersonalLoginViewController.h
//  yangsheng
//
//  Created by Macx on 17/7/10.
//  Copyright © 2017年 jam. All rights reserved.
//

#import "BaseViewController.h"

@protocol PersonalLoginViewControllerDelegate <NSObject>

@optional
-(void)personalLoginViewControllerDidLoginToken:(NSString*)token;

@end

@interface PersonalLoginViewController : BaseViewController

@property (nonatomic,weak) id<PersonalLoginViewControllerDelegate>delegate;

@end
