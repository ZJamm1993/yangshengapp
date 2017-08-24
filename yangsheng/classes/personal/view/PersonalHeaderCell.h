//
//  PersonalHeaderCell.h
//  yangsheng
//
//  Created by Macx on 17/7/10.
//  Copyright © 2017年 jam. All rights reserved.
//

#import <UIKit/UIKit.h>

@class PersonalHeaderCell;

@protocol PersonalHeaderCellDelegate <NSObject>

-(void)personalHeaderCell:(PersonalHeaderCell*)cell didSelectedScanButton:(UIButton*)btn;

@end

@interface PersonalHeaderCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIView *unlogedView;
@property (weak, nonatomic) IBOutlet UIView *logedView;
@property (weak, nonatomic) IBOutlet UIImageView *headImage;
@property (weak, nonatomic) IBOutlet UIView *headImageBg;
@property (weak, nonatomic) IBOutlet UILabel *username;
@property (weak, nonatomic) IBOutlet UILabel *userid;
@property (weak, nonatomic) IBOutlet UIImageView *my_bgImage;

@property (weak,nonatomic) id<PersonalHeaderCellDelegate> delegate;

@property (nonatomic,assign) BOOL isLoged;

@end
