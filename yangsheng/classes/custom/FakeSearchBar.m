//
//  FakeSearchBar.m
//  yangsheng
//
//  Created by Macx on 17/7/13.
//  Copyright © 2017年 jam. All rights reserved.
//

#import "FakeSearchBar.h"

@implementation FakeSearchBar

+(instancetype)fakeSearchBarWithFrame:(CGRect)frame title:(NSString *)title
{
    if (title.length==0) {
        title=@"瘦身减肥";
    }
    FakeSearchBar* bar=[[FakeSearchBar alloc]initWithFrame:frame];
    bar.layer.cornerRadius=frame.size.height/2;
    bar.backgroundColor=gray(240);
    
    UIImageView* icon=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"icon_search"]];
    icon.contentMode=UIViewContentModeCenter;
    icon.frame=CGRectMake(5, 0, frame.size.height, frame.size.height);
    [bar addSubview:icon];
    
    UILabel* text=[[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(icon.frame), 0, frame.size.width, frame.size.height)];
    text.textColor=gray(130);
    text.text=title;
    text.font=[UIFont systemFontOfSize:13];
    [bar addSubview:text];
    
    return bar;
}

+(instancetype)defaultSearchBarWithTitle:(NSString*)title
{
    CGRect fr=CGRectMake(0, 0, [[UIScreen mainScreen]bounds].size.width, 30);
    FakeSearchBar* bar=[self fakeSearchBarWithFrame:fr title:title];
    return bar;
}

@end
