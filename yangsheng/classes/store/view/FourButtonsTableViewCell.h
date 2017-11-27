//
//  FourButtonsTableViewCell.h
//  zhanmao
//
//  Created by bangju on 2017/11/17.
//  Copyright © 2017年 bangju. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SimpleButtonsTableViewCell.h"

@interface FourButtonsTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet SimpleButtonsTableViewCell *buttonsCell;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *heightConstraint;

-(void)setButtons:(NSArray<SimpleButtonModel*>*)buttons;
-(void)setDelegate:(id<SimpleButtonsTableViewCellDelegate>)delegate;

@end
