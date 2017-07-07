//
//  HomeHeaderCell.m
//  yangsheng
//
//  Created by Macx on 17/7/7.
//  Copyright © 2017年 jam. All rights reserved.
//

#import "HomeHeaderCell.h"

@implementation HomeHeaderCell

- (void)awakeFromNib {
    // Initialization code
    
    CGFloat screenW=[[UIScreen mainScreen]bounds].size.width;
    
    CGFloat w4=screenW/4;
    CGFloat w8=w4/2;
    
    self.v1Center.constant=-w4-w8;
    self.v2Center.constant=-w8;
    self.v3Center.constant=w8;
    self.v4Center.constant=w4+w8;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
