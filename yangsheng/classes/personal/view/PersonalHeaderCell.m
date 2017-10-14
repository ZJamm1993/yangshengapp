//
//  PersonalHeaderCell.m
//  yangsheng
//
//  Created by Macx on 17/7/10.
//  Copyright © 2017年 jam. All rights reserved.
//

#import "PersonalHeaderCell.h"

@implementation PersonalHeaderCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.backgroundColor=[UIColor clearColor];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (IBAction)scanButtonClicked:(id)sender {
    if (self.delegate) {
        if ([self.delegate respondsToSelector:@selector(personalHeaderCell:didSelectedScanButton:)]) {
            [self.delegate personalHeaderCell:self didSelectedScanButton:sender];
        }
    }
}

-(void)setIsLoged:(BOOL)isLoged
{
    _isLoged=isLoged;
    
    self.logedView.hidden=!isLoged;
    self.unlogedView.hidden=isLoged;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    
//    self.headImage.layer.borderColor=[UIColor whiteColor].CGColor;
////    self.headImage.layer.borderWidth=-3;
    self.headImage.layer.cornerRadius=self.headImage.bounds.size.width/2;
    self.headImage.clipsToBounds=YES;
    
    self.headImageBg.layer.cornerRadius=self.self.headImageBg.bounds.size.width/2;
    self.headImageBg.clipsToBounds=YES;
    
}

@end
