//
//  StoreLargeCell.m
//  yangsheng
//
//  Created by bangju on 2017/11/27.
//  Copyright © 2017年 jam. All rights reserved.
//

#import "StoreLargeCell.h"

@implementation StoreLargeCell

- (void)awakeFromNib {
    // Initialization code
    
    self.appointmentBg.layer.cornerRadius=self.appointmentBg.frame.size.height/2;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)likeButtonClick:(id)sender {
    self.likeButton.selected=!self.likeButton.selected;
}

-(void)setShowAppointment:(BOOL)showAppointment
{
    _showAppointment=showAppointment;
    self.appointmentBg.hidden=!showAppointment;
    
}

@end
