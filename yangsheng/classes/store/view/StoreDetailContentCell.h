//
//  StoreDetailContentCell.h
//  yangsheng
//
//  Created by jam on 17/7/27.
//  Copyright © 2017年 jam. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <WebKit/WebKit.h>

@interface StoreDetailContentCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UITextView *htmlLabe;
@property (weak, nonatomic) IBOutlet UIWebView *webView;

@end
