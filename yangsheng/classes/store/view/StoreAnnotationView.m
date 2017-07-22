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
    }
    return self;
}

@end
