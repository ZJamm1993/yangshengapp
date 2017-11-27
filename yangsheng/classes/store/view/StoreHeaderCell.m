//
//  StoreHeaderCell.m
//  yangsheng
//
//  Created by bangju on 2017/11/27.
//  Copyright © 2017年 jam. All rights reserved.
//

#import "StoreHeaderCell.h"

@implementation StoreHeaderCell

- (void)awakeFromNib {
    // Initialization code
    self.selectionStyle=UITableViewCellSelectionStyleNone;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (IBAction)button1Click:(UIButton*)sender {
    sender.selected=YES;
    self.button2.selected=NO;
    [self selectedType:0];
}
- (IBAction)button2Click:(UIButton*)sender {
    sender.selected=YES;
    self.button1.selected=NO;
    [self selectedType:1];
}

-(void)selectedType:(NSInteger)type
{
    if ([self.delegate respondsToSelector:@selector(storeHeaderCellDidSelectedType:)]) {
        [self.delegate storeHeaderCellDidSelectedType:type];
    }
}

-(void)setType:(NSInteger)type
{
    _type=type;
    
    self.button1.selected=type==0;
    self.button2.selected=type==1;
}

@end
