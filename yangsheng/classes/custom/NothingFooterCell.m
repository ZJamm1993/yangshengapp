//
//  NothingFooterCell.m
//  yangsheng
//
//  Created by Macx on 17/7/9.
//  Copyright © 2017年 jam. All rights reserved.
//

#import "NothingFooterCell.h"

@implementation NothingFooterCell

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

+(instancetype)defaultFooterCell
{
    NothingFooterCell* f=[[[UINib nibWithNibName:@"NothingFooterCell" bundle:nil]instantiateWithOwner:nil options:nil]firstObject];
    f.backgroundColor=[UIColor clearColor];
    f.contentView.backgroundColor=[UIColor clearColor];
    return f;
}

@end
