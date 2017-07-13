//
//  SystemMessageListViewController.m
//  yangsheng
//
//  Created by Macx on 17/7/12.
//  Copyright © 2017年 jam. All rights reserved.
//

#import "SystemMessageListViewController.h"
#import "SystemMsgCell.h"
#import "HomeHttpTool.h"

@interface SystemMessageListViewController ()
{
    NSArray* data;
}
@end

@implementation SystemMessageListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"系统消息";

    
    [self loadMore];
    // Do any additional setup after loading the view.
}

-(void)refresh
{
    [HomeHttpTool getSysMsgListPage:1 success:^(NSArray *datasource) {
        data=datasource;
        [self.tableView reloadData];
        [self stopRefreshAfterSeconds];
        if (data.count>0) {
            self.currentPage=1;
        }
    } isCache:NO];
}

-(void)loadMore
{
    
    [HomeHttpTool getSysMsgListPage:1+self.currentPage success:^(NSArray *datasource) {
        NSMutableArray* arr=[NSMutableArray array];
        [arr addObjectsFromArray:data?:[NSArray array]];
        [arr addObjectsFromArray:datasource];
        data=arr;
        [self.tableView reloadData];
        if (datasource.count>0) {
            self.currentPage++;
        }
        self.shouldLoadMore=datasource.count>=20;
        
    } isCache:YES];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return data.count;
}


-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    BaseModel* m=[data objectAtIndex:indexPath.row];
    
    BOOL hasImage=m.thumb.length>0;
    BOOL hasContent=m.post_excerpt.length>0;
    
    NSString* idd=@"SystemMsgCellImageAndContent";
    if (hasImage&&!hasContent) {
        idd=@"SystemMsgCellImageOnly";
    }
    else if(!hasImage&&hasContent)
    {
        idd=@"SystemMsgCellContentOnly";
    }
    SystemMsgCell* c=[tableView dequeueReusableCellWithIdentifier:idd forIndexPath:indexPath];
    c.msgContent.text=m.post_excerpt;
    [c.msgImage sd_setImageWithURL:[m.thumb urlWithMainUrl]];
    c.msgTitle.text=m.post_title;
    c.msgDate.text=m.post_modified;
//    c.msgImageRadio.multiplier=hasImage?2:100000000;
    
    return c;
}

@end
