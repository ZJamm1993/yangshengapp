//
//  ButtonsCell.h
//  yangsheng
//
//  Created by Macx on 17/7/9.
//  Copyright © 2017年 jam. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ButtonsCell;

@protocol ButtonsCellDelegate <NSObject>

-(void)buttonsCell:(ButtonsCell*)cell didClickedIndex:(NSInteger)index;

@end

@interface ButtonsCell : UITableViewCell

@property (nonatomic,weak) id<ButtonsCellDelegate> delegate;

@property (nonatomic,strong) NSArray* buttonsTitles;
@property (nonatomic,strong) NSArray* buttonsImageNames;

@property (nonatomic,assign) BOOL isHorizontalImageTitle;

@end
