//
//  ProductCheckViewController.m
//  yangsheng
//
//  Created by Macx on 17/7/13.
//  Copyright © 2017年 jam. All rights reserved.
//

#import "ProductCheckViewController.h"

@interface ProductCheckViewController ()

@end

@implementation ProductCheckViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"防伪查询";
    self.bgView.hidden=YES;
    [self startChecking];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)startChecking
{
    [MBProgressHUD showProgressMessage:@"正在查询"];
    [self checkProductCode:self.productCode success:^(NSDictionary *d, NSURLResponse *r) {
        [MBProgressHUD hide];
        self.bgView.hidden=NO;
        
        BOOL isGet=d.count>0;
        if ([r isKindOfClass:[NSHTTPURLResponse class]]) {
            NSHTTPURLResponse* ht=(NSHTTPURLResponse*)r;
            if (ht.statusCode!=200) {
                isGet=NO;
            }
        }
        
        NSString* QcodePicUrl=[d valueForKey:@"QcodePicUrl"];
//        NSString* FwColorCode=[d valueForKey:@"FwColorCode"];
        NSInteger CheckTime=[[d valueForKey:@"CheckTime"]integerValue];
//        NSString* firTime=[d valueForKey:@"firTime"];
        
        NSString* la=@"!";
        NSString* t1;
        NSString* t2;
        NSString* t3;
        
        UIColor* color=rgb(229,60,80);
        
        if (isGet==NO) {
            //unknown
            t1=@"未能查询到相关信息";
        }
        else if (QcodePicUrl.length>0) {
            //true
            color=rgb(24, 193, 67);
            la=@"√";
            t1=@"您查询的防伪码未养森官方正品";
            t2=[NSString stringWithFormat:@"您所查询的防伪码已被查询过%d次",(int)CheckTime];
            t3=[NSString stringWithFormat:@"如%d次查询非您个人行为，请确认您的商品未正规渠道购买",(int)CheckTime];
        }
        else
        {
            //fake
            t1=@"您查询的防伪码是假冒";
        }
        
        self.goodLabel.text=la;
        self.goodLabel.backgroundColor=color;
        
        self.goBackButton.backgroundColor=color;
        self.goodDescription.text=t1;
        self.checkedTimeLabel.text=t2;
        self.warningLabel.text=t3;
        
    } failure:^(NSError *f) {
        [MBProgressHUD hide];
        [MBProgressHUD showErrorMessage:@"!"];
    }];
}

- (IBAction)goBack:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)checkProductCode:(NSString*)code success:(void (^)(NSDictionary *,NSURLResponse*))success failure:(void (^)(NSError *))failure
{
    NSString* url=@"http://qr.hyxmt.cn/ShowInfo.ashx?c=http://yangsen.hyxmt.cn/&f=";
    if (code.length==0) {
        code=@"123";
    }
    
    url=[NSString stringWithFormat:@"%@%@",url,code];
    url=[url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSURL* _ur=[NSURL URLWithString:url];
    
    NSMutableURLRequest* request=[NSMutableURLRequest requestWithURL:_ur];
    request.HTTPMethod=@"GET";
    
    NSURLSession* session=[NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    NSURLSessionDataTask* dataTast=[session dataTaskWithRequest:request completionHandler:^(NSData * data, NSURLResponse * response, NSError * error) {
    NSLog(@"data:\n%@",data);
    NSLog(@"resp:\n%@",response);
    NSLog(@"erro:\n%@",error);
        
        dispatch_async(dispatch_get_main_queue(), ^{
            if (data) {
                NSDictionary* result=[ZZHttpTool dictionaryWithResponseData:data];
                if (success) {
                    success(result,response);
                }
            }
            else if(error)
            {
                if (failure) {
                    failure(error);
                }
            }
        });
        
    }];
    [dataTast resume];
}

@end
