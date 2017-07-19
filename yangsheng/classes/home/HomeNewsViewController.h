//
//  HomeNewsViewController.h
//  yangsheng
//
//  Created by Macx on 17/7/7.
//  Copyright © 2017年 jam. All rights reserved.
//

#import "BaseTableViewController.h"

typedef NS_ENUM(NSInteger,HomeNewsControllerType)
{
    HomeNewsControllerTypeDefault,
    HomeNewsControllerTypeBrandOnly,
    HomeNewsControllerTypeLatestOnly
};

@interface HomeNewsViewController : BaseTableViewController

@property (nonatomic,assign) HomeNewsControllerType type;

@end
