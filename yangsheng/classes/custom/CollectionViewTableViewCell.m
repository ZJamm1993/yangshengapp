//
//  CollectionViewTableViewCell.m
//  yangsheng
//
//  Created by Macx on 17/7/14.
//  Copyright © 2017年 jam. All rights reserved.
//

#import "CollectionViewTableViewCell.h"

@interface CollectionViewTableViewCell()<UICollectionViewDataSource,UICollectionViewDelegate>

@end

@implementation CollectionViewTableViewCell
{
    NSString* registeredCollectionViewCellId;
}

- (void)awakeFromNib {
    // Initialization code
    
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setFlowLayout:(UICollectionViewFlowLayout *)flowLayout
{
    _flowLayout=flowLayout;
    self.collectionView.collectionViewLayout=_flowLayout;
    //    [self.collectionView reloadData];
    [self.collectionView reloadSections:[NSIndexSet indexSetWithIndexesInRange:NSMakeRange(0, self.collectionView.numberOfSections)]];
}

-(void)registerClass:(Class)cellClass forCellWithReuseIdentifier:(NSString *)identifier
{
    [self.collectionView registerClass:cellClass forCellWithReuseIdentifier:identifier];
    registeredCollectionViewCellId=identifier;
}

-(void)registerNib:(UINib *)nib forCellWithReuseIdentifier:(NSString *)identifier
{
    [self.collectionView registerNib:nib forCellWithReuseIdentifier:identifier];
    registeredCollectionViewCellId=identifier;
}

-(void)setDelegate:(id<CollectionViewTableViewCellDelegate>)delegate
{
    _delegate=delegate;
    //    [self.collectionView reloadData];
    [self.collectionView reloadSections:[NSIndexSet indexSetWithIndexesInRange:NSMakeRange(0, self.collectionView.numberOfSections)]];
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if (registeredCollectionViewCellId.length==0) {
        return 0;
    }
    else if (self.delegate) {
        if ([self.delegate respondsToSelector:@selector(numberOfItemsForCollectionViewTableViewCell:)]) {
            return [self.delegate numberOfItemsForCollectionViewTableViewCell:self];
        }
    }
    return 0;
}

-(UICollectionViewCell*)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell* cell=[collectionView dequeueReusableCellWithReuseIdentifier:registeredCollectionViewCellId forIndexPath:indexPath];
    if (self.delegate) {
        if ([self.delegate respondsToSelector:@selector(collectionViewTableViewCell:willShowCollectionViewCell:atIndexPath:)]) {
            [self.delegate collectionViewTableViewCell:self willShowCollectionViewCell:cell atIndexPath:indexPath];
        }
    }
    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    [collectionView deselectItemAtIndexPath:indexPath animated:YES];
    if (self.delegate) {
        if ([self.delegate respondsToSelector:@selector(collectionViewTableViewCell:didSelectItemAtIndexPath:)]) {
            [self.delegate collectionViewTableViewCell:self didSelectItemAtIndexPath:indexPath];
        }
    }
}

@end
