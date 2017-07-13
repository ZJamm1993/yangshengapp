//
//  SystemMsgCell.h
//  yangsheng
//
//  Created by Macx on 17/7/12.
//  Copyright © 2017年 jam. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SystemMsgCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *msgTitle;
@property (weak, nonatomic) IBOutlet UIImageView *msgImage;
@property (weak, nonatomic) IBOutlet UILabel *msgContent;
@property (weak, nonatomic) IBOutlet UILabel *msgDate;
@property (weak, nonatomic) IBOutlet UIView *bgView;

@end
