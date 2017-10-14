//
//  WaiterCollectionCell.m
//  yangsheng
//
//  Created by Macx on 2017/8/10.
//  Copyright © 2017年 jam. All rights reserved.
//

#import "WaiterCollectionCell.h"

@implementation WaiterCollectionCell

-(void)awakeFromNib
{
    [super awakeFromNib];
    self.imageView.layer.borderColor=[UIColor lightGrayColor].CGColor;
    self.imageView.layer.borderWidth=0.5;
}

@end
