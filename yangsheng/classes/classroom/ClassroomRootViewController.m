//
//  ClassroomRootViewController.m
//  yangsheng
//
//  Created by jam on 17/7/8.
//  Copyright © 2017年 jam. All rights reserved.
//

#import "ClassroomRootViewController.h"
#import "BaseWebViewController.h"

@interface ClassroomRootViewController ()<ZZPagerControllerDataSource>

@end

@implementation ClassroomRootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"课堂";
    self.dataSource=self;
    // Do any additional setup after loading the view.
}

-(NSInteger)numbersOfChildControllersInPagerController:(ZZPagerController *)pager
{
    return 4;
}

-(UIViewController*)pagerController:(ZZPagerController *)pager viewControllerAtIndex:(NSInteger)index
{
    if (index==0) {
//        return [[BaseWebViewController alloc]initWithUrl:[@"themes/ys_ios/course/course_1.html" urlWithMainUrl]];
        return [[UIStoryboard storyboardWithName:@"Classroom" bundle:nil]instantiateViewControllerWithIdentifier:@"ClassroomKnowledgeListViewController"];
    }
    else if (index==1) {
//        return [[BaseWebViewController alloc]initWithUrl:[@"themes/ys_ios/course/course_2.html" urlWithMainUrl]];
        return [[UIStoryboard storyboardWithName:@"Classroom" bundle:nil]instantiateViewControllerWithIdentifier:@"ClassroomAnalystListViewController"];
    }
    else if (index==2) {
//        return [[BaseWebViewController alloc]initWithUrl:[@"themes/ys_ios/course/course_3.html" urlWithMainUrl]];
        return [[UIStoryboard storyboardWithName:@"Classroom" bundle:nil]instantiateViewControllerWithIdentifier:@"ClassroomVideoShareListViewController"];
    }
    else if(index==3)
    {
        return [[UIStoryboard storyboardWithName:@"Home" bundle:nil]instantiateViewControllerWithIdentifier:@"QAListViewController"];
    }
    return nil;
}

-(NSString*)pagerController:(ZZPagerController *)pager titleAtIndex:(NSInteger)index
{
    if (index==0) {
        return @"养森知识";
    }
    else if (index==1) {
        return @"专家分析";
    }
    else if (index==2) {
        return @"视频分享";
    }
    else if (index==3)
    {
        return @"常见问题";
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
