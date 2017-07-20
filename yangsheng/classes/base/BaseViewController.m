//
//  BaseViewController.m
//  yangsheng
//
//  Created by jam on 17/7/6.
//  Copyright © 2017年 jam. All rights reserved.
//

#import "BaseViewController.h"

@interface BaseViewController ()
{
    NSTimer* timer;
    NSInteger seconds;
}
@end

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self.view endEditing:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(UIInterfaceOrientationMask)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskPortrait;
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}

-(void)startCountDownSeconds:(NSInteger)second
{
    if(timer==nil)
    {
        timer=[NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(countingDown) userInfo:nil repeats:YES];
        [timer setFireDate:[NSDate date]];
    }
    seconds=second;
}

-(void)countingDown
{
    if (seconds<=0) {
        [self endingCountDown];
    }
    else
    {
        seconds=seconds-1;
        [self countingDownSeconds:seconds];
    }
}

-(void)countingDownSeconds:(NSInteger)second
{
    
}

-(void)endingCountDown
{
    
}

-(void)dealloc
{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
    [timer invalidate];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
