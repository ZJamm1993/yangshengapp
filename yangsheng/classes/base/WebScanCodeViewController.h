//
//  WebScanCodeViewController.h
//  yangsheng
//
//  Created by bangju on 2017/11/2.
//  Copyright © 2017年 jam. All rights reserved.
//

#import "CodeScanerViewController.h"

@protocol CodeScanerViewControllerDelegate <NSObject>

-(void)codeScanerOnResult:(NSString*)result;

@end

@interface WebScanCodeViewController : CodeScanerViewController

@property (nonatomic,weak) id<CodeScanerViewControllerDelegate> delegate;

@end
