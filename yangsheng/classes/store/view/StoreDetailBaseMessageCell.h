//
//  StoreDetailBaseMessageCell.h
//  yangsheng
//
//  Created by Macx on 17/7/15.
//  Copyright © 2017年 jam. All rights reserved.
//

#import <UIKit/UIKit.h>

@class StoreDetailBaseMessageCell;

@protocol StoreDetailBaseMessageCellDelegate <NSObject>

-(void)storeMessageCell:(StoreDetailBaseMessageCell*)cell didClickNavigation:(UIButton*)button;

@end

@interface StoreDetailBaseMessageCell : UITableViewCell

@property (weak,nonatomic) id<StoreDetailBaseMessageCellDelegate>delegate;

@property (weak, nonatomic) IBOutlet UILabel *storeName;
@property (weak, nonatomic) IBOutlet UILabel *storeContact;
@property (weak, nonatomic) IBOutlet UILabel *storeAddress;

@end
