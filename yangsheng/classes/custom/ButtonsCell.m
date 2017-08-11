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
    NSMutableArray* imgs;
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
    
    self.selectionStyle=UITableViewCellSelectionStyleNone;
    
    if (!btns) {
        btns=[NSMutableArray array];
    }
    if (!labs) {
        labs=[NSMutableArray array];
    }
    if(!imgs)
    {
        imgs=[NSMutableArray array];
    }
    
    [btns removeAllObjects];
    [labs removeAllObjects];
    [imgs removeAllObjects];
    
    for (int i=0; i<_buttonsTitles.count; i++) {
        UIButton* btn=[[UIButton alloc]init];
//        btn.backgroundColor=[UIColor blueColor];
//        btn.frame=CGRectMake(0, 0, 50, 50);
        btn.tag=i;
//        [btn setImage:[UIImage imageNamed:[_buttonsImageNames objectAtIndex:i]] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:btn];
        [btns addObject:btn];
        
        UIImageView* image=[[UIImageView alloc]initWithImage:[UIImage imageNamed:[_buttonsImageNames objectAtIndex:i]]];
        image.frame=CGRectMake(0, 0, 50, 50);
        [self.contentView addSubview:image];
        [imgs addObject:image];
        
        
        UILabel* la=[[UILabel alloc]init];
//        la.userInteractionEnabled=YES;
//        la.tag=i;
//        la.backgroundColor=[UIColor redColor];
        la.frame=CGRectMake(0, 0, 200, 60);
        la.font=[UIFont systemFontOfSize:13];
        la.textColor=[UIColor lightGrayColor];
        la.textAlignment=NSTextAlignmentCenter;
        la.text=[_buttonsTitles objectAtIndex:i];
//        la.adjustsFontSizeToFitWidth=YES;
//        la.minimumScaleFactor=0.4;
        la.numberOfLines=2;
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
        UIView* im=[imgs objectAtIndex:i];
        
        b.frame=CGRectMake(avw*i, 0, avw, h);
        
        if (self.isHorizontalImageTitle) {
            if([l isKindOfClass:[UILabel class]])
            {
                UILabel* lab=(UILabel*)l;
                lab.textAlignment=NSTextAlignmentLeft;
                lab.font=[UIFont systemFontOfSize:15];
            }
            [l sizeToFit];
//            [b sizeToFit];
            CGFloat totalw=im.bounds.size.width+l.bounds.size.width+10;
            
            im.center=CGPointMake(avw*i+a2w-totalw/2+im.bounds.size.width/2, h/2);
            l.center=CGPointMake(avw*i+a2w+totalw/2-l.bounds.size.width/2, h/2);
            
        }
        else
        {
            [l sizeToFit];
//            [b sizeToFit];
            im.center=CGPointMake(avw*i+a2w, bcy);
            l.center=CGPointMake(avw*i+a2w, lcy);
        }
    }
}

@end
