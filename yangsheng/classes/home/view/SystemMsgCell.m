//
//  SystemMsgCell.m
//  yangsheng
//
//  Created by Macx on 17/7/12.
//  Copyright © 2017年 jam. All rights reserved.
//

#import "SystemMsgCell.h"

@implementation SystemMsgCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.bgView.layer.borderColor=[UIColor colorWithWhite:0.86 alpha:1].CGColor;
    self.bgView.layer.borderWidth=0.5;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

//    self.bgView.backgroundColor=selected?[UIColor lightGrayColor]:[UIColor whiteColor];
    // Configure the view for the selected state
}

@end
