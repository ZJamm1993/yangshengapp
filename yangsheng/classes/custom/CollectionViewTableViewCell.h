//
//  CollectionViewTableViewCell.h
//  yangsheng
//
//  Created by Macx on 17/7/14.
//  Copyright © 2017年 jam. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CollectionViewTableViewCell;

@protocol CollectionViewTableViewCellDelegate <NSObject>

-(void)collectionViewTableViewCell:(CollectionViewTableViewCell*)cell didSelectItemAtIndexPath:(NSIndexPath*)indexPath;
-(void)collectionViewTableViewCell:(CollectionViewTableViewCell *)tableViewcell willShowCollectionViewCell:(UICollectionViewCell*)collectionViewCell atIndexPath:(NSIndexPath *)indexPath;
-(NSInteger)numberOfItemsForCollectionViewTableViewCell:(CollectionViewTableViewCell*)cell;

@end

@interface CollectionViewTableViewCell : UITableViewCell

@property (nonatomic,weak) id<CollectionViewTableViewCellDelegate>delegate;

//require to implement
@property (weak, nonatomic) IBOutlet UICollectionViewFlowLayout *flowLayout;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

- (void)registerClass:(Class)cellClass forCellWithReuseIdentifier:(NSString *)identifier;
- (void)registerNib:(UINib *)nib forCellWithReuseIdentifier:(NSString *)identifier;

@end
