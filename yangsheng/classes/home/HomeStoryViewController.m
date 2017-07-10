//
//  HomeStoryViewController.m
//  yangsheng
//
//  Created by jam on 17/7/6.
//  Copyright © 2017年 jam. All rights reserved.
//

#import "HomeStoryViewController.h"

#import "HomeProductClassCell.h"
#import "HomeProductHeaderCell.h"

#import "HomeQACell.h"

#import "HomeFounderCell.h"

#import "HomeEnterprisePublicityCell.h"

#import "ButtonsCell.h"

#import "HomeHttpTool.h"

#import "ProductListViewController.h"
#import "QAListViewController.h"
#import "NeewsListViewController.h"

#import "PlayerController.h"

typedef NS_ENUM(NSInteger,HomeStorySection)
{
    HomeStorySectionHeader,
    HomeStorySectionProduct,
    HomeStorySectionQuestion,
    HomeStorySectionFounder,
    HomeStorySectionEnterprise,
    HomeStorySectionNumbers
};

@interface HomeStoryViewController ()<ButtonsCellDelegate>
{
    NSMutableArray* advsArray;
    NSMutableArray* productClassArray;
    NSMutableArray* qaArray;
    NSMutableArray* founderArray;
    NSMutableArray* enterArray;
    
    UITapGestureRecognizer* tapGesture;
}
@end

@implementation HomeStoryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    [self.tableView registerNib:[UINib nibWithNibName:@"HomeHeaderCell" bundle:nil] forCellReuseIdentifier:@"HomeHeaderCell"];
    [self.tableView registerClass:[ButtonsCell class] forCellReuseIdentifier:@"TopButtonsCell"];
    
    tapGesture=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapGestureDidTap:)];
    [self.tableView addGestureRecognizer:tapGesture];
    
    
    [self firstLoad];
    // Do any additional setup after loading the view.
}

-(void)firstLoad
{
    [super firstLoad];
    [self getDataUsingCache:YES];
}

-(void)refresh
{
    [super refresh];
    [self getDataUsingCache:NO];
    [self stopRefreshAfterSeconds];
}

-(void)getDataUsingCache:(BOOL)isCache
{
    //
    [HomeHttpTool getAdversType:1 success:^(NSArray *datasource) {
        advsArray=[NSMutableArray arrayWithArray:datasource];
        NSMutableArray* pics=[NSMutableArray array];
        for (BaseModel* ad in advsArray) {
            NSString* th=ad.thumb;
            NSString* fu=[ZZUrlTool fullUrlWithTail:th];
            [pics addObject:fu];
        }
        [self setAdvertiseHeaderViewWithPicturesUrls:pics];
    } isCache:isCache];
    
    //
    [HomeHttpTool getProductClassSuccess:^(NSArray *datasource) {
        productClassArray=[NSMutableArray arrayWithArray:datasource];
        [self.tableView reloadData];
    } isCache:isCache];
    
    //
    [HomeHttpTool getQuesAnsRandomSuccess:^(NSArray *datasource) {
        qaArray=[NSMutableArray arrayWithArray:datasource];
        [self.tableView reloadData];
    } isCache:isCache];
    
    //
    [HomeHttpTool getFoundersSuccess:^(NSArray *datasource) {
        founderArray=[NSMutableArray arrayWithArray:datasource];
        [self.tableView reloadData];
    } isCache:isCache];
    
    //
    [HomeHttpTool getEnterAdvSuccess:^(NSArray *datasource) {
        enterArray=[NSMutableArray arrayWithArray:datasource];
        [self.tableView reloadData];
    } isCache:isCache];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return HomeStorySectionNumbers;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 4;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section==0) {
        return 0.0001;
    }
    return 4;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section==HomeStorySectionHeader) {
        return 1;
    }
    else if(section==HomeStorySectionProduct)
    {
        return productClassArray.count+1;
    }
    else if(section==HomeStorySectionQuestion)
    {
        return qaArray.count+1;
    }
    else if(section==HomeStorySectionFounder)
    {
        NSInteger rs=founderArray.count/2;
        if (founderArray.count%2>0) {
            rs=rs+1;
        }
        return rs+1;
    }
    else if(section==HomeStorySectionEnterprise)
    {
//#warning testing
        return 2;
    }
    return 0;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger sec=indexPath.section;
//    NSInteger row=indexPath.row;
    if (sec==HomeStorySectionHeader) {
        return 100;
    }
    else
    {
        return UITableViewAutomaticDimension;
    }
//    else if(sec==HomeStorySectionProduct)
//    {
//        if (row==0) {
//            return 60;
//        }
//        else
//        {
//            return 200;
//        }
//    }
//    else if(sec==HomeStorySectionQuestion)
//    {
//        if (row==0) {
//            return 100;
//        }
//        else
//        {
//            return UITableViewAutomaticDimension;
//        }
//    }
//    else if(sec==HomeStorySectionFounder)
//    {
//        if (row==0) {
//            return 90;
//        }
//        else
//        {
//            return UITableViewAutomaticDimension;//[[UIScreen mainScreen]bounds].size.width/2-25+35;
//        }
//    }
//    else if(sec==HomeStorySectionEnterprise)
//    {
//        if (row==0) {
//            return 90;
//        }
//        else
//        {
//            return UITableViewAutomaticDimension;
//        }
//    }
    return 0.0001;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger sec=indexPath.section;
    NSInteger row=indexPath.row;
    if (sec==HomeStorySectionHeader) {
        ButtonsCell* c=[tableView dequeueReusableCellWithIdentifier:@"TopButtonsCell" forIndexPath:indexPath];
        c.delegate=self;
        c.buttonsTitles=[NSArray arrayWithObjects:@"品牌故事",@"新闻中心",@"在线咨询",@"防伪查询", nil];
        c.buttonsImageNames=[NSArray arrayWithObjects:@"home_page",@"home_news",@"home_Consultation",@"home_Security", nil];
        return c;
    }
    else if(sec==HomeStorySectionProduct)
    {
        if (row==0) {
            HomeProductHeaderCell* c=[tableView dequeueReusableCellWithIdentifier:@"HomeProductHeaderCell" forIndexPath:indexPath];
            NSMutableArray* arr=[NSMutableArray array];
            for (BaseModel* pro in productClassArray) {
                NSString* name=pro.name;
                if (name) {
                    [arr addObject:name];
                }
            }
            NSString* subtitle=[arr componentsJoinedByString:@"&"];
            c.productHeaderSubtitleLabel.text=subtitle;
            return c;
        }
        else
        {
            HomeProductClassCell* c=[tableView dequeueReusableCellWithIdentifier:@"HomeProductClassCell" forIndexPath:indexPath];
            BaseModel* pro=[productClassArray objectAtIndex:row-1];
            c.productName.text=pro.name;
            [c.productThumb sd_setImageWithURL:[pro.thumb urlWithMainUrl]];
            return c;
        }
    }
    else if(sec==HomeStorySectionQuestion)
    {
        if (row==0) {
            UITableViewCell* c=[tableView dequeueReusableCellWithIdentifier:@"HomeQAHeaderCell" forIndexPath:indexPath];
            return c;
        }
        else
        {
            HomeQACell* c=[tableView dequeueReusableCellWithIdentifier:@"HomeQACell" forIndexPath:indexPath];
            BaseModel* qa=[qaArray objectAtIndex:row-1];
            c.qaTitleLabel.text=[NSString stringWithFormat:@"# %@",qa.post_title];
            c.qaContentLabel.text=qa.post_excerpt;
            c.qaReadLabel.text=[NSString stringWithFormat:@"%ld阅览",(long)qa.post_hits];
            return c;
        }
    }
    else if(sec==HomeStorySectionFounder)
    {
        if (row==0) {
            UITableViewCell* c=[tableView dequeueReusableCellWithIdentifier:@"HomeFounderHeaderCell" forIndexPath:indexPath];
            return c;
        }
        else
        {
            HomeFounderCell* c=[tableView dequeueReusableCellWithIdentifier:@"HomeFounderCell" forIndexPath:indexPath];
            
            NSInteger tr=row-1;
            NSInteger leftIndex=tr*2;
            NSInteger rightIndex=leftIndex+1;
            
            NSMutableArray* fous=[NSMutableArray array];
            if (leftIndex<founderArray.count) {
                [fous addObject:[founderArray objectAtIndex:leftIndex]];
            }
            if (rightIndex<founderArray.count) {
                [fous addObject:[founderArray objectAtIndex:rightIndex]];
            }
            
            c.founders=fous;
            
            return c;
        }
    }
    else if(sec==HomeStorySectionEnterprise)
    {
        if (row==0) {
            UITableViewCell* c=[tableView dequeueReusableCellWithIdentifier:@"HomePublicityHeaderCell" forIndexPath:indexPath];
            return c;
        }
        else
        {
            HomeEnterprisePublicityCell* c=[tableView dequeueReusableCellWithIdentifier:@"HomeEnterprisePublicityCell" forIndexPath:indexPath];
            BaseModel* en=[enterArray objectAtIndex:row-1];
            c.pubContentLabel.text=en.ios_content;
            c.pubTitleLabel.text=en.post_title;
            [c.pubImageView sd_setImageWithURL:[en.thumb urlWithMainUrl]];
//            [c.webView loadHTMLString:en.post_content baseURL:nil];
//            c.webView.delegate=self;
            return c;
        }
    }
    else
    {
        return nil;
    }
}

-(void)tapGestureDidTap:(UITapGestureRecognizer*)ta
{
    CGPoint point = [ta locationInView:self.tableView];
    NSIndexPath * indexPath = [self.tableView indexPathForRowAtPoint:point];
    if (indexPath) {
        NSInteger sec=indexPath.section;
        NSInteger row=indexPath.row;
        
        if (sec==HomeStorySectionFounder) {
            if (row>0) {
                NSInteger tr=row-1;
                NSInteger leftIndex=tr*2;
                NSInteger rightIndex=leftIndex+1;
                BOOL left=point.x<[[UIScreen mainScreen]bounds].size.width/2;
                
                BaseModel* unknownFounder=nil;
                
                if (left) {
                    if (leftIndex<founderArray.count) {
                        unknownFounder=[founderArray objectAtIndex:leftIndex];
                    }
                }
                else
                {
                    if (rightIndex<founderArray.count) {
                        unknownFounder=[founderArray objectAtIndex:rightIndex];
                    }
                }
                NSLog(@"founder %@",unknownFounder.description);
            }
        }
        else if(sec==HomeStorySectionProduct)
        {
            if (row==0) {
                return;
            }
            NSInteger tr=row-1;
            BaseModel* pro=[productClassArray objectAtIndex:tr];
            NSString* cid=pro.cid;
            NSString* title=pro.name;
            
            ProductListViewController* list=[[UIStoryboard storyboardWithName:@"Home" bundle:nil]instantiateViewControllerWithIdentifier:@"ProductListViewController"];
            list.title=title;
            list.idd=cid;
            [self.navigationController pushViewController:list animated:YES];
        }
        else if(sec==HomeStorySectionQuestion)
        {
            if (row==0) {
                QAListViewController* qa=[[UIStoryboard storyboardWithName:@"Home" bundle:nil]instantiateViewControllerWithIdentifier:@"QAListViewController"];
                [self.navigationController pushViewController:qa animated:YES];
            }
            else
            {
                ////
            }
        }
        else if(sec==HomeStorySectionEnterprise)
        {
            if (row>0) {
                BaseModel* b=[enterArray objectAtIndex:row-1];
                NSURL* mp4url=[b.mp4_path urlWithMainUrl];
                PlayerController* player=[[PlayerController alloc]init];
                player.url=mp4url;
                [self presentMoviePlayerViewControllerAnimated:player];
            }
        }
    }
}

-(void)buttonsCell:(ButtonsCell *)cell didClickedIndex:(NSInteger)index
{
    if (index==0) {
        BaseWebViewController* we=[[BaseWebViewController alloc]init];
        [we loadWithCustomUrl:[@"/Content/Page/show_brand" urlWithMainUrl] complete:^{
            
        }];
        [self.navigationController pushViewController:we animated:YES];
    }
    else if (index==1) {
        NeewsListViewController* nl=[[UIStoryboard storyboardWithName:@"Home" bundle:nil]instantiateViewControllerWithIdentifier:@"NeewsListViewController"];
        [self.navigationController pushViewController:nl animated:YES];
    }
}

@end
