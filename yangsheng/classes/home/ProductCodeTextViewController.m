//
//  ProductCodeTextViewController.m
//  yangsheng
//
//  Created by Macx on 17/7/24.
//  Copyright © 2017年 jam. All rights reserved.
//

#import "ProductCodeTextViewController.h"
#import "ProductCheckViewController.h"
#import "HomeHttpTool.h"

@interface ProductCodeTextViewController ()<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *code12TextField;
@property (weak, nonatomic) IBOutlet UITextField *code4TextField;

@end

@implementation ProductCodeTextViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title=@"防伪查询";
    //ht tp://yangsen.hyxmt.cn/a?bid=1&f=999144591608
    
    if (self.preString.length>0) {
        self.code12TextField.text=self.preString;
        self.code4TextField.text=@"";
    }
    else
    {
        [self.navigationController popViewControllerAnimated:YES];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)checkItOut:(id)sender {
    NSString* te12=self.code12TextField.text;
    NSString* te4=self.code4TextField.text;
    if (te12.length>0&&te4.length>0) {
        
        [MBProgressHUD showProgressMessage:@"正在查询"];
        NSString* num=[NSString stringWithFormat:@"%@%@",te12,te4];
        [HomeHttpTool getProductCheckWithNum:num success:^(NSDictionary *data) {
            [MBProgressHUD hide];
            ProductCheckResultType type=[[data valueForKey:@"type"]integerValue];
            NSString* title=[data valueForKey:@"title"];
            NSString* detail=[data valueForKey:@"detail"];
            ProductCheckViewController* ch=[[UIStoryboard storyboardWithName:@"Home" bundle:nil]instantiateViewControllerWithIdentifier:@"ProductCheckViewController"];
            ch.resultType=type;
            ch.resultTitle=title;
            ch.resultDetail=detail;
            [self.navigationController pushViewController:ch animated:YES];
            
            NSArray* vcs=self.navigationController.viewControllers;
            NSMutableArray* mvc=[NSMutableArray arrayWithArray:vcs];
            for (UIViewController* cc in vcs) {
                if ([cc isKindOfClass:[self class]]) {
                    [mvc removeObject:cc];
                }
            }
            [self.navigationController setViewControllers:mvc animated:NO];
        } isCache:NO];
    }
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
//    if (textField==self.code12TextField) {
//        return NO;
//    }
    return YES;
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

@end
