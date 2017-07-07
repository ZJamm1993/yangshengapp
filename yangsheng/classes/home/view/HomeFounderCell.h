//
//  HomeFounderCell.h
//  yangsheng
//
//  Created by Macx on 17/7/7.
//  Copyright © 2017年 jam. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "ModelFounder.h"

@interface HomeFounderCell : UITableViewCell

@property (nonatomic,strong) NSArray* founders;
@property (weak, nonatomic) IBOutlet UIView *leftView;
@property (weak, nonatomic) IBOutlet UIView *rightView;
@property (weak, nonatomic) IBOutlet UILabel *leftLebel;
@property (weak, nonatomic) IBOutlet UIImageView *leftImage;
@property (weak, nonatomic) IBOutlet UILabel *rightLabel;
@property (weak, nonatomic) IBOutlet UIImageView *rightImage;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *leftWidth;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *leftCenter;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *rightCenter;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *rightWidth;

@end
