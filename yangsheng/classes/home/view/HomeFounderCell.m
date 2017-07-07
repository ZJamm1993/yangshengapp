//
//  HomeFounderCell.m
//  yangsheng
//
//  Created by Macx on 17/7/7.
//  Copyright © 2017年 jam. All rights reserved.
//

#import "HomeFounderCell.h"

@implementation HomeFounderCell

- (void)awakeFromNib {
    // Initialization code
    
    CGFloat scrw=[[UIScreen mainScreen]bounds].size.width;
    
    CGFloat w2=scrw/2;
    CGFloat w=w2-25;
    
    self.leftWidth.constant=w;
    self.rightWidth.constant=w;
    
    self.leftCenter.constant=-w/2-5;
    self.rightCenter.constant=w/2+5;
}

-(void)setFounders:(NSArray *)founders
{
    self.leftView.hidden=YES;
    self.rightView.hidden=YES;
    if(founders.count>=1)
    {
        ModelFounder* f=[founders objectAtIndex:0];
        self.leftView.hidden=NO;
        [self.leftImage sd_setImageWithURL:[f.thumb urlWithMainUrl]];
        self.leftLebel.text=f.post_title;
        
    }
    if (founders.count>=2) {
        ModelFounder* f2=[founders objectAtIndex:1];
        self.rightView.hidden=NO;
        [self.rightImage sd_setImageWithURL:[f2.thumb urlWithMainUrl]];
        self.rightLabel.text=f2.post_title;
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
