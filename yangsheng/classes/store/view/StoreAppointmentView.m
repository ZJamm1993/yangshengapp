//
//  StoreAppointmentView.m
//  yangsheng
//
//  Created by Macx on 17/7/15.
//  Copyright © 2017年 jam. All rights reserved.
//

#import "StoreAppointmentView.h"

@implementation StoreAppointmentView

+(instancetype)defaultAppointmentViewWithTypes:(NSArray *)types
{
    StoreAppointmentView* v=[[StoreAppointmentView alloc]init];//[[[UINib nibWithNibName:@"StoreAppointmentView" bundle:nil]instantiateWithOwner:nil options:nil]firstObject];
    v.frame=CGRectMake(0, 0, [[UIScreen mainScreen]bounds].size.width, 49);
    
    if (types.count>0) {
        CGFloat w=v.frame.size.width/types.count;
        for (NSInteger i=0; i<types.count; i++) {
            AppointmentType typ=[[types objectAtIndex:i]integerValue];
            
            UIButton* phone=[[UIButton alloc]initWithFrame:CGRectMake(i*w, 0, w, v.frame.size.height)];
            phone.tag=typ;
            
            phone.backgroundColor=[UIColor whiteColor];
            [phone.titleLabel setFont:[UIFont systemFontOfSize:14]];
            [phone setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
            
            [phone addTarget:v action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
            [v addSubview:phone];
            
            if (typ==AppointmentTypePhone) {
                [phone setTitle:@"电话预约" forState:UIControlStateNormal];
                [phone setImage:[UIImage imageNamed:@"phone"] forState:UIControlStateNormal];
            }
            else if(typ==AppointmentTypeCheck)
            {
                [phone setTitle:@"查看预约" forState:UIControlStateNormal];
            }
            else if(typ==AppointmentTypeNormal)
            {
                phone.backgroundColor=pinkColor;
                [phone setTitle:@"立即预约" forState:UIControlStateNormal];
                [phone setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            }
        }
    }
    
    return v;
}

-(void)buttonClick:(UIButton*)button
{
    NSInteger tag=button.tag;
    [self selectType:tag];
}

-(void)selectType:(AppointmentType)type
{
    if (self.delegate) {
        if ([self.delegate respondsToSelector:@selector(storeAppointmentView:didSelectType:)]) {
            [self.delegate storeAppointmentView:self didSelectType:type];
        }
    }
}

@end
