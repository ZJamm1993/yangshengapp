//
//  HomeRootViewController.m
//  yangsheng
//
//  Created by jam on 17/7/6.
//  Copyright © 2017年 jam. All rights reserved.
//

#import "HomeRootViewController.h"
#import "HomeStoryViewController.h"
#import "HomeTeamViewController.h"

@interface HomeRootViewController ()<ZZPagerControllerDataSource>

@end

@implementation HomeRootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.dataSource=self;
    
//    UINavigationBar* naviBar=self.navigationController.navigationBar;
//    naviBar.shadowImage=[[UIImage alloc]init];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSInteger)numbersOfChildControllersInPagerController:(ZZPagerController *)pager
{
    return 4;
}

-(UIViewController*)pagerController:(ZZPagerController *)pager viewControllerAtIndex:(NSInteger)index
{
    if (index==0) {
        return [[UIStoryboard storyboardWithName:@"Home" bundle:nil]instantiateViewControllerWithIdentifier:@"HomeStory"];
    }
    else if (index==1) {
        return [[UIStoryboard storyboardWithName:@"Home" bundle:nil]instantiateViewControllerWithIdentifier:@"HomeTeam"];;
    }
    else if (index==2) {
        return [[UIStoryboard storyboardWithName:@"Home" bundle:nil]instantiateViewControllerWithIdentifier:@"HomeFeedback"];;
    }
    else if (index==3) {
        return [[UIStoryboard storyboardWithName:@"Home" bundle:nil]instantiateViewControllerWithIdentifier:@"HomeNews"];;
    }
    return nil;
}

-(NSString*)pagerController:(ZZPagerController *)pager titleAtIndex:(NSInteger)index
{
    if (index==0) {
        return @"品牌故事";
    }
    else if (index==1) {
        return @"服务团队";
    }
    else if (index==2) {
        return @"案例反馈";
    }
    else if (index==3) {
        return @"大事件";
    }
    return nil;
}

-(CGRect)pagerController:(ZZPagerController *)pager frameForMenuView:(ZZPagerMenu *)menu
{
    return CGRectMake(0, 0, self.view.frame.size.width, 40);
}

-(CGRect)pagerController:(ZZPagerController *)pager frameForContentView:(UIScrollView *)scrollView
{
    CGRect menuR=[self pagerController:pager frameForMenuView:nil];
    CGFloat menuMy=CGRectGetMaxY(menuR);
    return CGRectMake(0, menuMy, self.view.frame.size.width, self.view.frame.size.height-menuMy-49-64);
}

@end
