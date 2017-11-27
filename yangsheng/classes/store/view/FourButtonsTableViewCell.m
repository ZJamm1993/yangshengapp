//
//  FourButtonsTableViewCell.m
//  zhanmao
//
//  Created by bangju on 2017/11/17.
//  Copyright © 2017年 bangju. All rights reserved.
//

#import "FourButtonsTableViewCell.h"

@implementation FourButtonsTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.selectionStyle=UITableViewCellSelectionStyleNone;
    self.separatorInset=UIEdgeInsetsZero;
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setButtons:(NSArray<SimpleButtonModel *> *)buttons
{
    self.buttonsCell.buttons=buttons;
    CGFloat he=[SimpleButtonsTableViewCell heightWithButtonsCount:buttons.count];
    self.heightConstraint.constant=he;
}

-(void)setDelegate:(id<SimpleButtonsTableViewCellDelegate>)delegate
{
    self.buttonsCell.delegate=delegate;
}


@end
