//
//  StoreSignUpViewController.m
//  yangsheng
//
//  Created by bangju on 2017/11/28.
//  Copyright © 2017年 jam. All rights reserved.
//

#import "StoreSignUpViewController.h"
#import "SignupButtonTableViewCell.h"

@interface StoreSignUpViewController ()<SignupButtonTableViewCellDelegate>

@end

@implementation StoreSignUpViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 2;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row==0) {
        SignupButtonTableViewCell* cell=[tableView dequeueReusableCellWithIdentifier:@"SignupButtonTableViewCell" forIndexPath:indexPath];
        cell.delegate=self;
        return cell;
    }
    return [[UITableViewCell alloc]init];
}

-(void)signupButtonTableViewCell:(SignupButtonTableViewCell *)cell didClickSign:(UIButton *)button
{
    [MBProgressHUD showErrorMessage:@"不给"];
}

@end
