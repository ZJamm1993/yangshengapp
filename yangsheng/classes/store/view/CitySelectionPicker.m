//
//  CitySelectionPicker.m
//  yangsheng
//
//  Created by Macx on 2017/8/3.
//  Copyright © 2017年 jam. All rights reserved.
//

#import "CitySelectionPicker.h"

@interface CitySelectionPicker()<UIPickerViewDataSource,UIPickerViewDelegate>

@property (nonatomic,strong) NSMutableArray* proArr;
@property (nonatomic,strong) NSMutableArray* citArr;
@property (nonatomic,strong) NSMutableArray* disArr;

@property (nonatomic,assign) NSInteger sections;

@end

@implementation CitySelectionPicker

+(instancetype)defaultCityPickerWithSections:(NSInteger)sections
{
    CitySelectionPicker* picker=[[CitySelectionPicker alloc]initWithFrame:CGRectMake(0, 0, [[UIScreen mainScreen]bounds].size.width, 200)];
    picker.backgroundColor=[UIColor whiteColor];
    picker.sections=sections;
    picker.delegate=picker;
    picker.dataSource=picker;
    [picker loadCityWithLevel:CityLevelProvince keywords:@""];
    return picker;
}

-(NSMutableArray*)proArr
{
    if (_proArr==nil) {
        _proArr=[NSMutableArray array];
    }
    return _proArr;
}

-(NSMutableArray*)citArr
{
    if (_citArr==nil) {
        _citArr=[NSMutableArray array];
    }
    return _citArr;
}

-(NSMutableArray*)disArr
{
    if (_disArr==nil) {
        _disArr=[NSMutableArray array];
    }
    return _disArr;
}

-(void)setSections:(NSInteger)sections
{
    if (sections>3) {
        sections=3;
    }
    else if(sections<0)
    {
        sections=0;
    }
    _sections=sections;
}

-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return self.sections;
}

-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    if (component==0) {
        return self.proArr.count;
    }
    else if(component==1)
    {
        return self.citArr.count;
    }
    else if(component==2)
    {
        return self.disArr.count;
    }
    return 0;
}

-(NSString*)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    NSArray* arr=nil;
    NSString* str=nil;
    
    if (component==0) {
        arr=self.proArr;
    }
    else if(component==1)
    {
        arr=self.citArr;
    }
    else if(component==2)
    {
        arr=self.disArr;
    }
    
    if (row<arr.count) {
        CityModel* city=[arr objectAtIndex:row];
        str=city.name;
    }
    
    return str;
}

-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    NSArray* arr=nil;
    
    if (component==0) {
        arr=self.proArr;
    }
    else if(component==1)
    {
        arr=self.citArr;
    }
    else if(component==2)
    {
        arr=self.disArr;
    }
    
    if (row<arr.count) {
        CityModel* city=[arr objectAtIndex:row];
        NSString* keyword=city.adcode;
        NSString* level=city.level;
        if ([city.level isEqualToString:CityLevelProvince]) {
            level=CityLevelCity;
        }
        else if([city.level isEqualToString:CityLevelCity])
        {
            level=CityLevelDistrict;
        }
        else
        {
            return;
        }
        [self loadCityWithLevel:level keywords:keyword];
    }
}

-(void)loadCityWithLevel:(NSString*)level keywords:(NSString*)keywords
{
    NSLog(@"%@",level);
    NSMutableArray* arr;
    
    NSInteger secs=[self numberOfComponents];
    
    if ([level isEqualToString:CityLevelProvince]) {
        arr=self.proArr;
        if (secs<1) {
            return;
        }
    }
    else if ([level isEqualToString:CityLevelCity])
    {
        arr=self.citArr;
        if (secs<2) {
            return;
        }
    }
    else if ([level isEqualToString:CityLevelDistrict])
    {
        arr=self.disArr;
        if (secs<3) {
            return;
        }
    }
    
    [StoreHttpTool getCitysWithLevel:level keywords:keywords success:^(NSArray *datasource) {
        [arr removeAllObjects];
        [arr addObjectsFromArray:datasource];
        [self reloadAllComponents];
        
        if ([level isEqualToString:CityLevelProvince]) {
            [self selectRow:0 inComponent:0 animated:NO];
            [self pickerView:self didSelectRow:0 inComponent:0];
        }
        else if([level isEqualToString:CityLevelCity])
        {
            [self selectRow:0 inComponent:1 animated:NO];
            [self pickerView:self didSelectRow:0 inComponent:1];
        }
        else if([level isEqualToString:CityLevelDistrict])
        {
            [self selectRow:0 inComponent:2 animated:NO];
            [self pickerView:self didSelectRow:0 inComponent:2];
        }
        [self layoutIfNeeded];
    } isCache:YES];
}

-(NSArray*)selectedCitys
{
    NSMutableArray* arrs=[NSMutableArray array];
    for (int i=0; i<[self numberOfComponents]; i++) {
        NSArray* arr=nil;
        
        if (i==0) {
            arr=self.proArr;
        }
        else if(i==1)
        {
            arr=self.citArr;
        }
        else if(i==2)
        {
            arr=self.disArr;
        }
        
        NSInteger row=[self selectedRowInComponent:i];
        if (row<arr.count) {
            CityModel* city=[arr objectAtIndex:row];
            if (city) {
                [arrs addObject:city];
            }
        }
    }
    return arrs;
}

@end
