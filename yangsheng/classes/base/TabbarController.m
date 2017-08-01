//
//  TabbarController.m
//  yangsheng
//
//  Created by jam on 17/7/6.
//  Copyright © 2017年 jam. All rights reserved.
//

#import "TabbarController.h"

@interface TabbarController ()

@end

@implementation TabbarController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.tabBar.translucent=NO;
    
    self.tabBar.tintColor=pinkColor;
    
    NSArray* childs=self.childViewControllers;
    
    for (UIViewController* vc in childs) {
        UITabBarItem* item = vc.tabBarItem;
        UIImage* img_n=item.image;
        UIImage* img_s=item.selectedImage;
        
        item.image=[img_n imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        item.selectedImage=[img_s imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    }
    
    self.tabBar.shadowImage=[UIImage imageWithColor:[UIColor groupTableViewBackgroundColor] size:CGSizeMake(self.tabBar.bounds.size.width, 0.5)];
    
    [self.tabBar setBackgroundImage:[UIImage imageWithColor:[UIColor whiteColor] size:self.tabBar.bounds.size]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(UIInterfaceOrientationMask)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskPortrait;
}

@end
