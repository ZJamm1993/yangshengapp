//
//  StoreHeaderCell.h
//  yangsheng
//
//  Created by bangju on 2017/11/27.
//  Copyright © 2017年 jam. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol StoreHeaderCellDelegate <NSObject>

@optional
-(void)storeHeaderCellDidSelectedType:(NSInteger)type;

@end

@interface StoreHeaderCell : LinedTableViewCell

@property (nonatomic,weak) id<StoreHeaderCellDelegate>delegate;

@property (weak, nonatomic) IBOutlet UIButton *button1;
@property (weak, nonatomic) IBOutlet UIButton *button2;

@property (nonatomic,assign) NSInteger type;

@end
