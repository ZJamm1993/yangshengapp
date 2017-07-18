//
//  StoreAppointmentHeaderCell.m
//  yangsheng
//
//  Created by Macx on 17/7/18.
//  Copyright © 2017年 jam. All rights reserved.
//

#import "StoreAppointmentHeaderCell.h"

@implementation StoreAppointmentHeaderCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (IBAction)cancelAppointment:(id)sender {
    
    if (self.delegate) {
        if ([self.delegate respondsToSelector:@selector(appointmentHeaderCell:didCancelAtIndex:)]) {
            [self.delegate appointmentHeaderCell:self didCancelAtIndex:self.index];
        }
    }
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    
    self.appointCancelButton.hidden=self.finished;
    
    self.appointCancelButton.layer.borderColor=[UIColor lightGrayColor].CGColor;
    self.appointCancelButton.layer.borderWidth=0.5;
    self.appointCancelButton.layer.cornerRadius=2;
}

@end
