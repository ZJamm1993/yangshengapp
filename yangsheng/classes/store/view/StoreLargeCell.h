//
//  StoreLargeCell.h
//  yangsheng
//
//  Created by bangju on 2017/11/27.
//  Copyright © 2017年 jam. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "StoreModel.h"

@interface StoreLargeCell : LinedTableViewCell

@property (nonatomic,strong) StoreModel* store;

@property (weak, nonatomic) IBOutlet UIImageView *image;
@property (weak, nonatomic) IBOutlet UILabel *title;
@property (weak, nonatomic) IBOutlet UILabel *distance;
@property (weak, nonatomic) IBOutlet UIButton *likeButton;
@property (weak, nonatomic) IBOutlet UILabel *likeCount;
@property (weak, nonatomic) IBOutlet UIView *appointmentBg;

@property (nonatomic,assign) BOOL showAppointment;

@end
