//
//  StoreCitySelectionViewController.h
//  yangsheng
//
//  Created by Macx on 17/7/15.
//  Copyright © 2017年 jam. All rights reserved.
//

#import "BaseTableViewController.h"
#import "CityModel.h"

@interface StoreCitySelectionViewController : BaseTableViewController

@property (nonatomic,strong) NSString* level;
@property (nonatomic,strong) NSString* keywords;

@property (nonatomic,strong) NSArray* lastLevelCities;

@property (nonatomic,assign) BOOL isStoreLocation;

@end
