//
//  StoreDetailBaseMessageCell.m
//  yangsheng
//
//  Created by Macx on 17/7/15.
//  Copyright © 2017年 jam. All rights reserved.
//

#import "StoreDetailBaseMessageCell.h"

@implementation StoreDetailBaseMessageCell

- (void)awakeFromNib {
    // Initialization code
    
    self.storeNaviButton.layer.cornerRadius=2;
    self.storeNaviButton.layer.borderColor=[UIColor lightGrayColor].CGColor;
    self.storeNaviButton.layer.borderWidth=0.5;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)goToNavi:(id)sender {
    if (self.delegate) {
        if ([self.delegate respondsToSelector:@selector(storeMessageCell:didClickNavigation:)]) {
            [self.delegate storeMessageCell:self didClickNavigation:sender];
        }
    }
}
@end
