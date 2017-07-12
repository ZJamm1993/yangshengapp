//
//  SystemMessageListViewController.m
//  yangsheng
//
//  Created by Macx on 17/7/12.
//  Copyright © 2017年 jam. All rights reserved.
//

#import "SystemMessageListViewController.h"
#import "SystemMsgCell.h"

@interface SystemMessageListViewController ()

@end

@implementation SystemMessageListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"系统消息";
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 100;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SystemMsgCell* c=[tableView dequeueReusableCellWithIdentifier:@"SystemMsgCell" forIndexPath:indexPath];
    int r=indexPath.row%3;
    
    BOOL hasImage=r!=2;
    BOOL hasContent=r!=0;
    
    NSString* imgName=hasImage?nil:@"my_bg";
    NSString* content=hasContent?@"":@"计算机阿佛啊就是佛i额外加我i 哦我 鸡窝科技佛 i 忘记否决我烦我i 家哦 i 文件我家哦 i 围巾哦是旅行，每次恤女裤口袋就离开肌肤上地理课肌肤 ";
    c.msgContent.text=content;
    c.msgImage.image=[UIImage imageNamed:imgName];
//    c.msgImageRadio.multiplier=hasImage?2:100000000;
    
    return c;
}

@end
