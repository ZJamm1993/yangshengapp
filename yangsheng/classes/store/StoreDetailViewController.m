//
//  StoreDetailViewController.m
//  yangsheng
//
//  Created by Macx on 17/7/14.
//  Copyright © 2017年 jam. All rights reserved.
//

#import "StoreDetailViewController.h"
#import "CollectionViewTableViewCell.h"

@interface StoreDetailViewController ()

@end

@implementation StoreDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"CollectionViewTableViewCell" bundle:nil] forCellReuseIdentifier:@"StoreItemCell"];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
