//
//  ClassroomVideoShareCollectionCell.m
//  yangsheng
//
//  Created by Macx on 17/7/13.
//  Copyright © 2017年 jam. All rights reserved.
//

#import "ClassroomVideoShareCollectionCell.h"

@implementation ClassroomVideoShareCollectionCell

- (void)awakeFromNib {
    // Initialization code
    self.imageView.clipsToBounds=YES;
    self.imageView.layer.cornerRadius=4;
}

@end