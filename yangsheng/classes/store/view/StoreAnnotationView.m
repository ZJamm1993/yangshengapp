//
//  StoreAnnotationView.m
//  yangsheng
//
//  Created by Macx on 17/7/18.
//  Copyright © 2017年 jam. All rights reserved.
//

#import "StoreAnnotationView.h"

@implementation StoreAnnotationView

- (instancetype)initWithAnnotation:(id)annotation reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithAnnotation:annotation reuseIdentifier:reuseIdentifier];
    if ( self )
    {
        self.canShowCallout = YES;
        self.image=[UIImage imageNamed:@"map_mark"];
        self.zIndex=-1;
        
        UIButton* button=[UIButton buttonWithType:UIButtonTypeSystem];
        [button setTitle:@"去这里" forState:UIControlStateNormal];
        button.frame=CGRectMake(0, 0, 60, 30);
        [button addTarget:self action:@selector(goToNavi:) forControlEvents:UIControlEventTouchUpInside];
        self.rightCalloutAccessoryView=button;
    }
    return self;
}

-(void)goToNavi:(UIButton*)btn
{
    if (self.delegate) {
        if ([self.delegate respondsToSelector:@selector(storeAnnotationView:didClickNaviButton:)]) {
            [self.delegate storeAnnotationView:self didClickNaviButton:btn];
        }
    }
}

@end
