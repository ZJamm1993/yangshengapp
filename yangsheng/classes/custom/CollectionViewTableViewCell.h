//
//  CollectionViewTableViewCell.h
//  yangsheng
//
//  Created by Macx on 17/7/14.
//  Copyright © 2017年 jam. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CollectionViewTableViewCell : UITableViewCell<UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,UICollectionViewDelegate>

@property (nonatomic,strong) NSMutableArray* dataSource;

@property (weak, nonatomic) IBOutlet UICollectionViewFlowLayout *flowLayout;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;



@end
