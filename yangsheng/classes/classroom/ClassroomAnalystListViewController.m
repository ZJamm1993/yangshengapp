//
//  ClassroomAnalystListViewController.m
//  yangsheng
//
//  Created by jam on 17/7/16.
//  Copyright © 2017年 jam. All rights reserved.
//

#import "ClassroomAnalystListViewController.h"
#import "HomeTeamExtCell.h"
#import "ClassroomHttpTool.h"
#import "HomeHttpTool.h"

@interface ClassroomAnalystListViewController ()
{
    NSArray* advsArray;
}
@end

@implementation ClassroomAnalystListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self loadMore];
    // Do any additional setup after loading the view.
    
    //    [self setAdvertiseHeaderViewWithPicturesUrls:@[@"a",@"b"]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)refresh
{
    //
    
    [self stopRefreshAfterSeconds];
    [HomeHttpTool getAdversType:4 success:^(NSArray *datasource) {
        advsArray=[NSMutableArray arrayWithArray:datasource];
        NSMutableArray* pics=[NSMutableArray array];
        for (BaseModel* ad in advsArray) {
            NSString* th=ad.thumb;
            NSString* fu=[ZZUrlTool fullUrlWithTail:th];
            [pics addObject:fu];
        }
        [self setAdvertiseHeaderViewWithPicturesUrls:pics];
    } isCache:NO];
    
    [ClassroomHttpTool getClassroomListType:3 page:1 size:self.pageSize success:^(NSArray *datasource) {
        [self.dataSource removeAllObjects];
        [self.dataSource addObjectsFromArray:datasource];
        [self.tableView reloadData];
        if (datasource.count>0) {
            self.currentPage=1;
        }
        //        [self setAdvertiseHeaderViewWithPicturesUrls:@[@"",@""]];
    } isCache:NO];
}

-(void)loadMore
{
    //
    [HomeHttpTool getAdversType:4 success:^(NSArray *datasource) {
        advsArray=[NSMutableArray arrayWithArray:datasource];
        NSMutableArray* pics=[NSMutableArray array];
        for (BaseModel* ad in advsArray) {
            NSString* th=ad.thumb;
            NSString* fu=[ZZUrlTool fullUrlWithTail:th];
            [pics addObject:fu];
        }
        [self setAdvertiseHeaderViewWithPicturesUrls:pics];
    } isCache:YES];
    
    [ClassroomHttpTool getClassroomListType:3 page:1+self.currentPage size:self.pageSize success:^(NSArray *datasource) {
        [self.dataSource addObjectsFromArray:datasource];
        [self.tableView reloadData];
        if (datasource.count>0) {
            self.currentPage++;
        }
        self.shouldLoadMore=datasource.count>=self.pageSize;
        
    } isCache:YES];
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSource.count;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    HomeTeamExtCell* c=[tableView dequeueReusableCellWithIdentifier:@"HomeTeamExtCell" forIndexPath:indexPath];
    BaseModel* ext=[self.dataSource objectAtIndex:indexPath.row];
    [c.extBgImageView sd_setImageWithURL:[ext.thumb urlWithMainUrl]];
    c.extTitle.text=ext.post_title;
    c.extContent.text=ext.post_excerpt;
    c.extDateLabel.text=ext.post_modified;
    return c;
}

#pragma mark <UICollectionViewDelegate>

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    BaseModel* m=[self.dataSource objectAtIndex:indexPath.row];
    BaseWebViewController* we=[[BaseWebViewController alloc]initWithUrl:[html_course_detail urlWithMainUrl]];
    we.idd=m.idd.integerValue;
    we.type=@"c2";
    we.title=@"详情";
    [self.navigationController pushViewController:we animated:YES];
}


/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
