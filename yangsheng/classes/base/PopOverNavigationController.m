//
//  PopOverNavigationController.m
//  SmallViewController
//
//  Created by jam on 17/3/20.
//  Copyright © 2017年 jam. All rights reserved.
//

#import "PopOverNavigationController.h"

#define defaultRect CGRectMake(0, 0, 240, 360)

@interface PopOverNavigationController ()<UIPopoverPresentationControllerDelegate>

@end

@implementation PopOverNavigationController

-(instancetype)initWithRootViewController:(UIViewController *)rootViewController sourceView:(UIView *)sourceView
{
    self=[super initWithRootViewController:rootViewController];
    if (self) {
        self.modalPresentationStyle=UIModalPresentationPopover;
        self.preferredContentSize=defaultRect.size;

//        sourceView=nil;
        
        if (sourceView==nil) {
            sourceView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 0, 0)];
        }
        
        if (sourceView) {
            UIPopoverPresentationController* popOver=self.popoverPresentationController;
            popOver.delegate=self;
            popOver.sourceView=sourceView;
//            popOver.sourceRect=sourceView.bounds;
            popOver.backgroundColor=[UIColor clearColor];
        }
    }
    return self;
}

-(instancetype)initWithRootViewController:(UIViewController *)rootViewController
{
    return [self initWithRootViewController:rootViewController sourceView:nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];
}


- (UIModalPresentationStyle)adaptivePresentationStyleForPresentationController:(UIPresentationController *)controller
{
    return UIModalPresentationNone;
}

@end
