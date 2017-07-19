//
//  ZZSearchBar.m
//  yangsheng
//
//  Created by Macx on 17/7/19.
//  Copyright © 2017年 jam. All rights reserved.
//

#import "ZZSearchBar.h"

@implementation ZZSearchBar

+(instancetype)defaultBar
{
    ZZSearchBar* bar=[[ZZSearchBar alloc]initWithFrame:CGRectMake(0, 0, [[UIScreen mainScreen]bounds].size.width, 30)];
    bar.layer.cornerRadius=bar.frame.size.height/2;
    bar.backgroundColor=gray(240);
    bar.textColor=pinkColor;
    bar.font=[UIFont systemFontOfSize:13];
    
    UIImageView* icon=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"icon_search"]];
    icon.contentMode=UIViewContentModeCenter;
    icon.frame=CGRectMake(0, 0, bar.frame.size.height, bar.frame.size.height);
    bar.leftView=icon;
    bar.leftViewMode=UITextFieldViewModeAlways;
    
    UIButton* cle=[[UIButton alloc]initWithFrame:CGRectMake(0, 0, bar.frame.size.height, bar.frame.size.height)];
    [cle setImage:[UIImage imageNamed:@"clear"] forState:UIControlStateNormal];
    [cle addTarget:bar action:@selector(clearText) forControlEvents:UIControlEventTouchUpInside];
    bar.rightView=cle;
    bar.rightViewMode=UITextFieldViewModeAlways;
    
    return bar;
}

-(void)clearText
{
    self.text=@"";
    [self becomeFirstResponder];
}

@end
