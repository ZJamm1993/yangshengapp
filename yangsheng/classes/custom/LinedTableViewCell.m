//
//  BaseTableViewCell.m
//  zhanmao
//
//  Created by bangju on 2017/10/16.
//  Copyright © 2017年 bangju. All rights reserved.
//

#import "LinedTableViewCell.h"

@implementation LinedTableViewCell
{
    
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(UIView*)bottomSeperateLine
{
    if(_bottomSeperateLine==nil)
    {
        _bottomSeperateLine=[[UIView alloc]initWithFrame:CGRectZero];
        _bottomSeperateLine.backgroundColor=gray_8;
        [self addSubview:_bottomSeperateLine];
    }
    return _bottomSeperateLine;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    
    CGFloat he=1/[[UIScreen mainScreen]scale];
    self.bottomSeperateLine.frame=CGRectMake(0, self.bounds.size.height-he, self.bounds.size.width, he);
}

@end
