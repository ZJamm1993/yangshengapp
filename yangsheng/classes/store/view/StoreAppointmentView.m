//
//  StoreAppointmentView.m
//  yangsheng
//
//  Created by Macx on 17/7/15.
//  Copyright © 2017年 jam. All rights reserved.
//

#import "StoreAppointmentView.h"

@implementation StoreAppointmentView

+(instancetype)defaultAppointmentView
{
    StoreAppointmentView* v=[[StoreAppointmentView alloc]init];//[[[UINib nibWithNibName:@"StoreAppointmentView" bundle:nil]instantiateWithOwner:nil options:nil]firstObject];
    v.frame=CGRectMake(0, 0, [[UIScreen mainScreen]bounds].size.width, 49);
    
    UIButton* phone=[[UIButton alloc]initWithFrame:CGRectMake(0, 0, v.frame.size.width/2, v.frame.size.height)];
    phone.backgroundColor=[UIColor whiteColor];
    [phone setTitle:@"电话预约" forState:UIControlStateNormal];
    [phone setImage:[UIImage imageNamed:@"phone"] forState:UIControlStateNormal];
    [phone.titleLabel setFont:[UIFont systemFontOfSize:14]];
    [phone setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [phone addTarget:v action:@selector(phoneAppointment:) forControlEvents:UIControlEventTouchUpInside];
    [v addSubview:phone];
    
    UIButton* rig=[[UIButton alloc]initWithFrame:CGRectMake(v.frame.size.width/2, 0, v.frame.size.width/2, v.frame.size.height)];
    rig.backgroundColor=pinkColor;
    [rig setTitle:@"立即预约" forState:UIControlStateNormal];
    [rig.titleLabel setFont:[UIFont systemFontOfSize:14]];
    [rig setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [rig addTarget:v action:@selector(rightnowAppointment:) forControlEvents:UIControlEventTouchUpInside];
    [v addSubview:rig];
    
    return v;
}

- (IBAction)phoneAppointment:(id)sender {
    [self selectType:AppointmentTypePhone];
}
- (IBAction)rightnowAppointment:(id)sender {
    [self selectType:AppointmentTypeNormal];
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
