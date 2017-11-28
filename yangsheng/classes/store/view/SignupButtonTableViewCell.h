//
//  SignupButtonTableViewCell.h
//  yangsheng
//
//  Created by bangju on 2017/11/28.
//  Copyright © 2017年 jam. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SignupButtonTableViewCell;

@protocol SignupButtonTableViewCellDelegate <NSObject>

@optional
-(void)signupButtonTableViewCell:(SignupButtonTableViewCell*)cell didClickSign:(UIButton*)button;

@end

@interface SignupButtonTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIButton *signButton;
@property (weak, nonatomic) IBOutlet UILabel *signDays;

@property (weak,nonatomic) id<SignupButtonTableViewCellDelegate> delegate;

@end
