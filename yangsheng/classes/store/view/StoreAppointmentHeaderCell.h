//
//  StoreAppointmentHeaderCell.h
//  yangsheng
//
//  Created by Macx on 17/7/18.
//  Copyright © 2017年 jam. All rights reserved.
//

#import <UIKit/UIKit.h>

@class StoreAppointmentHeaderCell;

@protocol StoreAppointmentHeaderCellDelegate <NSObject>

-(void)appointmentHeaderCell:(StoreAppointmentHeaderCell*)cell didCancelAtIndex:(NSInteger)index;

@end

@interface StoreAppointmentHeaderCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *appointTimeLabel;
@property (weak, nonatomic) IBOutlet UIButton *appointCancelButton;

@property (nonatomic,assign) NSInteger index;
@property (nonatomic,assign) BOOL finished;

@property (nonatomic,weak) id<StoreAppointmentHeaderCellDelegate>delegate;

@end
