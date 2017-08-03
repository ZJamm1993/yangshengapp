//
//  CitySelectionPicker.h
//  yangsheng
//
//  Created by Macx on 2017/8/3.
//  Copyright © 2017年 jam. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CityModel.h"
#import "StoreHttpTool.h"

@interface CitySelectionPicker : UIPickerView

+(instancetype)defaultCityPickerWithSections:(NSInteger)sections;

@property (nonatomic,strong,readonly) NSArray* selectedCitys;

@end
