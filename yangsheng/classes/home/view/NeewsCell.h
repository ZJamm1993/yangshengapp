//
//  NeewsCell.h
//  yangsheng
//
//  Created by Macx on 17/7/10.
//  Copyright © 2017年 jam. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NeewsCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *neeImg;
@property (weak, nonatomic) IBOutlet UILabel *neeTitle;
@property (weak, nonatomic) IBOutlet UILabel *neeCount;
@property (weak, nonatomic) IBOutlet UILabel *neeDate;

@end
