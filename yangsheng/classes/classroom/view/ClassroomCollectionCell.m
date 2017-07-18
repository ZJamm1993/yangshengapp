//
//  ClassroomCollectionCell.m
//  yangsheng
//
//  Created by Macx on 17/7/18.
//  Copyright © 2017年 jam. All rights reserved.
//

#import "ClassroomCollectionCell.h"

@implementation ClassroomCollectionCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (IBAction)cancelCollection:(id)sender {
    if (self.delegate) {
        if ([self.delegate respondsToSelector:@selector(collectionCell:didCancelAtIndex:)]) {
            [self.delegate collectionCell:self didCancelAtIndex:self.index];
        }
    }
}

@end
