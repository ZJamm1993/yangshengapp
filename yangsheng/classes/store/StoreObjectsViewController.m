//
//  StoreObjectsViewController.m
//  yangsheng
//
//  Created by jam on 17/7/13.
//  Copyright © 2017年 jam. All rights reserved.
//

#import "StoreObjectsViewController.h"
#import "ServiceObjectCell.h"

@interface StoreObjectsViewController ()<UICollectionViewDataSource,UICollectionViewDelegate>
{
    UICollectionView* coll;
    UICollectionViewFlowLayout* flow;
}

@end

@implementation StoreObjectsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"服务项目";
    // Do any additional setup after loading the view.
    
    flow=[[UICollectionViewFlowLayout alloc]init];
    
    CGFloat sw=[[UIScreen mainScreen]bounds].size.width;
    CGFloat m=2;
    CGFloat w=(sw-2*m)/3;
    CGFloat h=w;
    
    flow.itemSize=CGSizeMake(w, h);
    flow.minimumLineSpacing=m;
    flow.minimumInteritemSpacing=m;
    flow.sectionInset=UIEdgeInsetsMake(0,0,0,0);
    
    coll=[[UICollectionView alloc]initWithFrame:self.view.bounds collectionViewLayout:flow];
    [coll registerNib:[UINib nibWithNibName:@"ServiceObjectCell" bundle:nil] forCellWithReuseIdentifier:@"ServiceObjectCell"];
    coll.backgroundColor=[UIColor lightGrayColor];
    coll.delegate=self;
    coll.dataSource=self;
    [self.view addSubview:coll];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 100;
}

-(UICollectionViewCell*)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    ServiceObjectCell* c=[collectionView dequeueReusableCellWithReuseIdentifier:@"ServiceObjectCell" forIndexPath:indexPath];
//    c.backgroundColor=[UIColor redColor];
    return c;
}

@end
