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
#import "CollectionViewTableViewCell.h"
#import "FounderCollectionViewCell.h"

#import "HomeHttpTool.h"

#import "ProductListViewController.h"
#import "QAListViewController.h"
#import "NeewsListViewController.h"
#import "CodeScanerViewController.h"

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

@interface HomeStoryViewController ()<ButtonsCellDelegate,CollectionViewTableViewCellDelegate>
{
    NSMutableArray* advsArray;
    NSMutableArray* productClassArray;
    NSMutableArray* qaArray;
    NSMutableArray* founderArray;
    NSMutableArray* enterArray;
    
    UICollectionViewFlowLayout* flow;
}
@end

@implementation HomeStoryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    flow=[[UICollectionViewFlowLayout alloc]init];
    CGFloat sw=[[UIScreen mainScreen]bounds].size.width;
    CGFloat m=10;
    CGFloat w=(sw-5*m)/2;
    CGFloat h=w+40;
    
    flow.itemSize=CGSizeMake(w, h);
    flow.minimumLineSpacing=0;
    flow.minimumInteritemSpacing=m;
    flow.sectionInset=UIEdgeInsetsMake(0,2*m,0,2*m);
    
//    [self.tableView registerNib:[UINib nibWithNibName:@"HomeHeaderCell" bundle:nil] forCellReuseIdentifier:@"HomeHeaderCell"];
    [self.tableView registerClass:[ButtonsCell class] forCellReuseIdentifier:@"TopButtonsCell"];
    [self.tableView registerNib:[UINib nibWithNibName:@"CollectionViewTableViewCell" bundle:nil] forCellReuseIdentifier:@"founderCollectionCell"];

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
        [self tableViewReloadData];
    } isCache:isCache];
    
    //
    [HomeHttpTool getQuesAnsRandomSuccess:^(NSArray *datasource) {
        qaArray=[NSMutableArray arrayWithArray:datasource];
        [self tableViewReloadData];
    } isCache:isCache];
    
    //
    [HomeHttpTool getFoundersSuccess:^(NSArray *datasource) {
        founderArray=[NSMutableArray arrayWithArray:datasource];
        [self tableViewReloadData];
    } isCache:isCache];
    
    //
    [HomeHttpTool getEnterAdvSuccess:^(NSArray *datasource) {
        enterArray=[NSMutableArray arrayWithArray:datasource];
        [self tableViewReloadData];
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
//        NSInteger rs=founderArray.count/2;
//        if (founderArray.count%2>0) {
//            rs=rs+1;
//        }
//        return rs+1;
        return 2;
    }
    else if(section==HomeStorySectionEnterprise)
    {
//#warning testing
        return enterArray.count+1;
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
    else if(sec==HomeStorySectionFounder)
    {
        if (indexPath.row==1) {
            NSInteger rows=founderArray.count/2;
            if (founderArray.count%2>0) {
                rows++;
            }
            return rows*flow.itemSize.height;
        }
    }
    return UITableViewAutomaticDimension;
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
//            HomeFounderCell* c=[tableView dequeueReusableCellWithIdentifier:@"HomeFounderCell" forIndexPath:indexPath];
//            
//            NSInteger tr=row-1;
//            NSInteger leftIndex=tr*2;
//            NSInteger rightIndex=leftIndex+1;
//            
//            NSMutableArray* fous=[NSMutableArray array];
//            if (leftIndex<founderArray.count) {
//                [fous addObject:[founderArray objectAtIndex:leftIndex]];
//            }
//            if (rightIndex<founderArray.count) {
//                [fous addObject:[founderArray objectAtIndex:rightIndex]];
//            }
//            
//            c.founders=fous;
//            
//            return c;
            
            CollectionViewTableViewCell* cell=[tableView dequeueReusableCellWithIdentifier:@"founderCollectionCell" forIndexPath:indexPath];
            [cell registerNib:[UINib nibWithNibName:@"FounderCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"foun"];
            cell.delegate=self;
            cell.flowLayout=flow;
            cell.collectionView.backgroundColor=[UIColor whiteColor];
            return cell;
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
//            [c.pubImageView sd_setImageWithURL:[en.thumb urlWithMainUrl]];
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

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath) {
        NSInteger sec=indexPath.section;
        NSInteger row=indexPath.row;
        
        if (sec==HomeStorySectionFounder) {
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
                BaseModel* m=[qaArray objectAtIndex:indexPath.row-1];
                BaseWebViewController* we=[[BaseWebViewController alloc]initWithUrl:[html_QA_detail urlWithMainUrl]];
                we.idd=m.idd.integerValue;
                we.title=@"问答详情";
                [self.navigationController pushViewController:we animated:YES];
            }
        }
        else if(sec==HomeStorySectionEnterprise)
        {
            if (row>0) {
                BaseModel* b=[enterArray objectAtIndex:row-1];
                if (b.mp4_path.length==0) {
                    return;
                }
                UIAlertController* alert=[UIAlertController alertControllerWithTitle:@"是否观看企业视频?" message:@"可能会产生额外流量费用" preferredStyle:UIAlertControllerStyleAlert];
                [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil]];
                [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                    
                    NSURL* mp4url=[b.mp4_path urlWithMainUrl];
                    PlayerController* player=[[PlayerController alloc]init];
                    player.url=mp4url;
                    [self presentMoviePlayerViewControllerAnimated:player];
                }]];
                [self presentViewController:alert animated:YES completion:nil];
            }
        }
    }
}

#pragma mark --collectiontablecell delegate

-(NSInteger)numberOfItemsForCollectionViewTableViewCell:(CollectionViewTableViewCell *)cell
{
    return founderArray.count;
}

-(void)collectionViewTableViewCell:(CollectionViewTableViewCell *)tableViewcell willShowCollectionViewCell:(UICollectionViewCell *)collectionViewCell atIndexPath:(NSIndexPath *)indexPath
{
    if ([collectionViewCell isKindOfClass:[FounderCollectionViewCell class]]) {
        BaseModel* m=[founderArray objectAtIndex:indexPath.row];
        FounderCollectionViewCell* c=(FounderCollectionViewCell*)collectionViewCell;
        c.title.text=m.post_title;
        [c.image sd_setImageWithURL:[m.thumb urlWithMainUrl]];
    }
}

-(void)collectionViewTableViewCell:(CollectionViewTableViewCell *)cell didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    BaseWebViewController* we=[[BaseWebViewController alloc]initWithUrl:[html_founder_detail urlWithMainUrl]];
    BaseModel* m=[founderArray objectAtIndex:indexPath.row];
    we.idd=m.idd.integerValue;
    we.title=@"创始人";
    [self.navigationController pushViewController:we animated:YES];

}

#pragma mark --buttonsCellDelegate

-(void)buttonsCell:(ButtonsCell *)cell didClickedIndex:(NSInteger)index
{
    if (index==0) {
        BaseWebViewController* we=[[BaseWebViewController alloc]initWithUrl:[html_brandStory urlWithMainUrl]];
        we.title=@"品牌故事";
        [self.navigationController pushViewController:we animated:YES];
    }
    else if (index==1) {
        NeewsListViewController* nl=[[UIStoryboard storyboardWithName:@"Home" bundle:nil]instantiateViewControllerWithIdentifier:@"NeewsListViewController"];
        [self.navigationController pushViewController:nl animated:YES];
    }
    else if(index==2)
    {
        UIAlertController* alert=[UIAlertController alertControllerWithTitle:@"是否打开QQ联系客服" message:nil preferredStyle:UIAlertControllerStyleAlert];
        [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil]];
        [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
            NSURL* url=QQURL;
            if ([[UIApplication sharedApplication]canOpenURL:url]) {
                [[UIApplication sharedApplication]openURL:url];
            }
            else
            {
                [MBProgressHUD showErrorMessage:@"联系客服发生错误"];
            }
        }]];
        [self presentViewController:alert animated:YES completion:nil];
    }
    else if(index==3)
    {
        CodeScanerViewController* scaner=[[CodeScanerViewController alloc]init];
        [self.navigationController pushViewController:scaner animated:YES];
    }
}

@end
