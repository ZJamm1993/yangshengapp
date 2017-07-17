//
//  StoreApplyResultViewController.m
//  yangsheng
//
//  Created by jam on 17/7/16.
//  Copyright © 2017年 jam. All rights reserved.
//

#import "StoreApplyResultViewController.h"
#import "StoreHttpTool.h"
#import "UserModel.h"
#import "StoreApplySubmitViewController.h"

@interface StoreApplyResultViewController ()
@property (weak, nonatomic) IBOutlet UILabel *nameAndPhone;
@property (weak, nonatomic) IBOutlet UILabel *idcard;
@property (weak, nonatomic) IBOutlet UILabel *address;
@property (weak, nonatomic) IBOutlet UIImageView *resultImage;
@property (weak, nonatomic) IBOutlet UIImageView *positiveImage;
@property (weak, nonatomic) IBOutlet UIImageView *negativeImage;

@end

@implementation StoreApplyResultViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"申请结果";
    
    [self.refreshControl removeFromSuperview];
    
    if (self.applyResult==nil) {
        [StoreHttpTool getApplyResultWithToken:[[UserModel getUser]access_token] success:^(StoreApplyModel *applyModel) {
            self.applyResult=applyModel;
            [self loadInfo];
        }];
    }
    else
    {
        [self loadInfo];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)setApplyResult:(StoreApplyModel *)applyResult
{
    _applyResult=applyResult;
    [self loadInfo];
}

-(void)loadInfo
{
    self.nameAndPhone.text=[NSString stringWithFormat:@"%@/%@",self.applyResult.name,self.applyResult.tel];
    self.idcard.text=self.applyResult.idcard;
    self.address.text=[NSString stringWithFormat:@"%@%@",self.applyResult.area,self.applyResult.address];
    
    NSString* imgName=@"";
    NSInteger status=self.applyResult.status;
    if (status==0) {
        imgName=@"applyStoreProceeding";
    }
    else if(status==1)
    {
        imgName=@"applyStoreSuccess";
    }
    else if(status==2)
    {
        imgName=@"applyStoreFailure";
    }
    if (imgName.length>0) {
        self.resultImage.image=[UIImage imageNamed:imgName];
    }
    
    [self.positiveImage sd_setImageWithURL:[self.applyResult.positive urlWithMainUrl]];
    [self.negativeImage sd_setImageWithURL:[self.applyResult.negative urlWithMainUrl]];
    
    [self.tableView reloadData];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return UITableViewAutomaticDimension;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section==0) {
        return 40;
    }
    return 0.00001;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if (section==0) {
        return 10;
    }
    return 40;
}

-(NSString*)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section
{
    if (section==1) {
        return self.applyResult.status==0?@"预计7个工作日内完成审核，请耐心等待":@"";
    }
    return @"";
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (self.applyResult.status==2) {
        return 3;
    }
    return 2;
}

-(UIView*)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    if (section==1) {
        if (self.applyResult.status==2) {
            UILabel* lab=[[UILabel alloc]initWithFrame:CGRectMake(20, 0, self.view.bounds.size.width, 40)];
            lab.textColor=[UIColor redColor];
            lab.font=[UIFont systemFontOfSize:14];
            lab.text=[NSString stringWithFormat:@"    %@",self.applyResult.info];
            return lab;
        }
    }
    return nil;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==2) {
        StoreApplySubmitViewController* sub=[[UIStoryboard storyboardWithName:@"Store" bundle:nil]instantiateViewControllerWithIdentifier:@"StoreApplySubmitViewController"];
        sub.applyResult=self.applyResult;
        [self.navigationController pushViewController:sub animated:YES];
    }
}

@end
