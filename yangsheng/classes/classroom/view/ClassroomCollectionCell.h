//
//  ClassroomCollectionCell.h
//  yangsheng
//
//  Created by Macx on 17/7/18.
//  Copyright © 2017年 jam. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ClassroomCollectionCell;

@protocol ClassroomCollectionCellDelegate <NSObject>

-(void)collectionCell:(ClassroomCollectionCell*)cell didCancelAtIndex:(NSInteger)index;

@end

@interface ClassroomCollectionCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *image;
@property (weak, nonatomic) IBOutlet UILabel *title;
@property (weak, nonatomic) IBOutlet UILabel *date;

@property (nonatomic,assign) NSInteger index;
@property (nonatomic,weak) id<ClassroomCollectionCellDelegate> delegate;

@end
