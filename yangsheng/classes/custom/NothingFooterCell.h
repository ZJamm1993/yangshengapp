//
//  NothingFooterCell.h
//  yangsheng
//
//  Created by Macx on 17/7/9.
//  Copyright © 2017年 jam. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NothingFooterCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *nothingLabel;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;
+(instancetype)defaultFooterCell;

@end
