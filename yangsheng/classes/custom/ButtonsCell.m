//
//  ButtonsCell.m
//  yangsheng
//
//  Created by Macx on 17/7/9.
//  Copyright © 2017年 jam. All rights reserved.
//

#import "ButtonsCell.h"

@implementation ButtonsCell
{
    NSMutableArray* btns;
    NSMutableArray* labs;
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setButtonsImageNames:(NSArray *)buttonsImageNames
{
    _buttonsImageNames=buttonsImageNames;
    if (_buttonsImageNames.count==_buttonsTitles.count) {
        [self addButtons];
    }
}

-(void)setButtonsTitles:(NSArray *)buttonsTitles
{
    _buttonsTitles=buttonsTitles;
    if (_buttonsTitles.count==_buttonsImageNames.count) {
        [self addButtons];
    }
}

-(void)addButtons
{
    [self.contentView removeAllSubviews];
    
    if (!btns) {
        btns=[NSMutableArray array];
    }
    if (!labs) {
        labs=[NSMutableArray array];
    }
    
    [btns removeAllObjects];
    [labs removeAllObjects];
    
    for (int i=0; i<_buttonsTitles.count; i++) {
        UIButton* btn=[[UIButton alloc]init];
//        btn.backgroundColor=[UIColor blueColor];
        btn.frame=CGRectMake(0, 0, 50, 50);
        btn.tag=i;
        [btn setImage:[UIImage imageNamed:[_buttonsImageNames objectAtIndex:i]] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:btn];
        [btns addObject:btn];
        
        UILabel* la=[[UILabel alloc]init];
//        la.backgroundColor=[UIColor redColor];
        la.frame=CGRectMake(0, 0, 100, 20);
        la.font=[UIFont systemFontOfSize:13];
        la.textColor=[UIColor lightGrayColor];
        la.textAlignment=NSTextAlignmentCenter;
        la.text=[_buttonsTitles objectAtIndex:i];
        [self.contentView addSubview:la];
        [labs addObject:la];
    }
}

-(void)btnClick:(UIButton*)btn
{
    if (self.delegate) {
        if ([self.delegate respondsToSelector:@selector(buttonsCell:didClickedIndex:)]) {
            [self.delegate buttonsCell:self didClickedIndex:btn.tag];
        }
    }
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    CGFloat w=self.contentView.frame.size.width;
    CGFloat h=self.contentView.frame.size.height;
    NSInteger count=self.buttonsTitles.count;
    CGFloat avw=w/count;
    CGFloat a2w=avw/2;
    
    CGFloat bcy=h*0.40;
    CGFloat lcy=h*0.8;
    for (int i=0; i<count; i++) {
        UIView* b=[btns objectAtIndex:i];
        UIView* l=[labs objectAtIndex:i];
        
        b.center=CGPointMake(avw*i+a2w, bcy);
        l.center=CGPointMake(avw*i+a2w, lcy);
    }
}

@end
