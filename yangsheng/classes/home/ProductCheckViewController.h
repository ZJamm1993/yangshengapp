//
//  ProductCheckViewController.h
//  yangsheng
//
//  Created by Macx on 17/7/13.
//  Copyright © 2017年 jam. All rights reserved.
//

#import "BaseViewController.h"

typedef NS_ENUM(NSInteger,ProductCheckResultType)
{
    ProductCheckResultTypeUnknown=2,
    ProductCheckResultTypeSuspicious=1,
    ProductCheckResultTypeCorrect=0,
};

@interface ProductCheckViewController : BaseViewController
@property (weak, nonatomic) IBOutlet UIImageView *goodImage;
@property (weak, nonatomic) IBOutlet UILabel *goodLabel;
@property (weak, nonatomic) IBOutlet UILabel *goodDescription;
@property (weak, nonatomic) IBOutlet UILabel *checkedTimeLabel;
@property (weak, nonatomic) IBOutlet UIButton *goBackButton;
@property (weak, nonatomic) IBOutlet UIView *bgView;

@property (nonatomic,strong) NSString* resultTitle;
@property (nonatomic,strong) NSString* resultDetail;
@property (nonatomic,assign) ProductCheckResultType resultType;

@end
