//
//  SignupButtonTableViewCell.m
//  yangsheng
//
//  Created by bangju on 2017/11/28.
//  Copyright © 2017年 jam. All rights reserved.
//

#import "SignupButtonTableViewCell.h"

@implementation SignupButtonTableViewCell

- (void)awakeFromNib {
    // Initialization code
    [self.signButton addTarget:self action:@selector(signClick) forControlEvents:UIControlEventTouchUpInside];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)signClick
{
    if ([self.delegate respondsToSelector:@selector(signupButtonTableViewCell:didClickSign:)]) {
        [self.delegate signupButtonTableViewCell:self didClickSign:self.signButton];
    }
}

@end
