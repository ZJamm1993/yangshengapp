//
//  StoreDetailViewController.m
//  yangsheng
//
//  Created by Macx on 17/7/14.
//  Copyright © 2017年 jam. All rights reserved.
//

#import "StoreDetailViewController.h"
#import "CollectionViewTableViewCell.h"
#import "WebViewTableViewCell.h"
#import "StoreDetailBaseMessageCell.h"
#import "ServiceObjectCell.h"
#import "StoreDetailContentCell.h"
#import "StoreAppointmentView.h"
#import "StoreAppointmentViewController.h"
#import "PersonalLoginViewController.h"
#import "StoreMapViewController.h"

#import "StoreHttpTool.h"

#import <CoreLocation/CoreLocation.h>

@interface StoreDetailViewController ()<CollectionViewTableViewCellDelegate,StoreAppointmentViewDelegate,StoreDetailBaseMessageCellDelegate>
{
    UICollectionViewFlowLayout* flow;
//    UIWebView* testWebView;
//    CGFloat webViewHeight;
    StoreAppointmentView* appointmentView;
    __weak UIWebView* testWebView;
    
    CGFloat tableViewLastY;
}
@end

@implementation StoreDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title=@"门店";
    
    flow=[[UICollectionViewFlowLayout alloc]init];
    
    CGFloat sw=[[UIScreen mainScreen]bounds].size.width;
    CGFloat m=0.5;
    CGFloat w=(sw-3*m)/3;
    CGFloat h=w;
    
    flow.itemSize=CGSizeMake(w, h);
    flow.minimumLineSpacing=m;
    flow.minimumInteritemSpacing=m;
    flow.sectionInset=UIEdgeInsetsMake(m,0,0,0);
    
    self.tableView.contentInset=UIEdgeInsetsMake(0, 0, 49, 0);
    
    appointmentView=[StoreAppointmentView defaultAppointmentView];
    appointmentView.delegate=self;
    
    [self.tableView registerNib:[UINib nibWithNibName:@"CollectionViewTableViewCell" bundle:nil] forCellReuseIdentifier:@"StoreItemCell"];
    [self.tableView registerNib:[UINib nibWithNibName:@"WebViewTableViewCell" bundle:nil] forCellReuseIdentifier:@"StoreIntroCell"];
    // Do any additional setup after loading the view.
    
//    webViewHeight=1;
//    
//    testWebView=[[UIWebView alloc]initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 1)];
//    testWebView.delegate=self;
    
    [self loadDetail];
    [self refresh];
}

-(void)dealloc
{
//    testWebView.delegate=nil;
}

-(void)refresh
{
    [self stopRefreshAfterSeconds];
    if (self.detailStoreModel.idd.length>0) {
        [StoreHttpTool getStoreDetailWithId:self.detailStoreModel.idd success:^(NSArray *datasource) {
            StoreModel* mo=[datasource firstObject];
            if (mo.idd.length>0) {
                self.detailStoreModel=mo;
                [self loadDetail];
            }
        } isCache:NO];
    }
}

-(void)loadDetail
{
    NSMutableArray* arr=[NSMutableArray array];
    for (NSString* t in self.detailStoreModel.smetas) {
        NSString* fuul=[ZZUrlTool fullUrlWithTail:t];
        [arr addObject:fuul];
    }
    [self setAdvertiseHeaderViewWithPicturesUrls:arr];
    
//    [testWebView loadHTMLString:self.detailStoreModel.store_content baseURL:nil];
    
    [self.tableView reloadData];
    
    [self scrollViewDidScroll:self.tableView];
}

//-(BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
//{
//    NSURL *url = [request URL];
//    if (navigationType == UIWebViewNavigationTypeOther) {
//        if ([[url scheme] isEqualToString:@"ready"]) {
//            float contentHeight = [[url host] floatValue];
////            webViewHeight=contentHeight;
//            [self.tableView reloadData];
//            return NO;
//        } 
//    }
//    return YES; 
//}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (scrollView==self.tableView) {
        CGFloat offy=scrollView.contentOffset.y;
        CGFloat h=scrollView.frame.size.height;
        CGFloat b=scrollView.contentInset.bottom;
        CGRect appf=appointmentView.frame;
        appf.origin.y=offy+h-b;
        appointmentView.frame=appf;
        
        [appointmentView removeFromSuperview];
        [self.tableView addSubview:appointmentView];
        
        if (tableViewLastY>scrollView.contentOffset.y) {
            [testWebView.scrollView setContentOffset:CGPointMake(0, 0) animated:YES];
        }
        tableViewLastY=scrollView.contentOffset.y;
        
//        [testWebView.scrollView resignFirstResponder];
//        testWebView.scrollView.scrollEnabled=scrollView.contentOffset.y==0;
    }
    else if(scrollView==testWebView.scrollView)
    {
//        self.tableView.scrollEnabled=scrollView.contentOffset.y>0;
        if (scrollView.contentOffset.y<0) {
            [scrollView setContentOffset:CGPointMake(0, 0) animated:NO];
            [self.tableView scrollRectToVisible:CGRectMake(0, 0, 100, 100) animated:YES];
        }
        else if(scrollView.contentOffset.y>0)
        {
            [self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:2] atScrollPosition:UITableViewScrollPositionTop animated:YES];
        }
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
//    if (section==0) {
//        return 0.00001;
//    }
//    return 8;
    return 0.00001;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 8;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row>=1) {
        if (indexPath.section==1) {
            //collection;
            NSInteger counts=self.detailStoreModel.items.count;
            
            NSInteger rs=counts/3;
            if (counts%3>0) {
                rs=rs+1;
            }
            return (flow.itemSize.height+flow.minimumLineSpacing)*rs;
        }
        else if(indexPath.section==2)
        {
            //web
//            return webViewHeight;
            return [[UIScreen mainScreen]bounds].size.height-64-49-44;
        }
    }
    return UITableViewAutomaticDimension;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section==0) {
        return 1;
    }
    else if(section==1)
    {
        return 2;
    }
    else if(section==2)
    {
        return 2;
    }
    return 0;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger sec=indexPath.section;
    NSInteger row=indexPath.row;
    if (sec==0) {
        StoreDetailBaseMessageCell* cell=[tableView dequeueReusableCellWithIdentifier:@"StoreDetailBaseMessageCell" forIndexPath:indexPath];
        cell.delegate=self;
        cell.storeName.text=self.detailStoreModel.store_title;
        cell.storeContact.text=[NSString stringWithFormat:@"%@/%@",self.detailStoreModel.store_author,self.detailStoreModel.store_tel];
        cell.storeAddress.text=self.detailStoreModel.store_address;
        cell.storeNaviButton.hidden=self.detailStoreModel.lat.length==0;
        return cell;
    }
    else if(sec==1)
    {
        if (row==0) {
            UITableViewCell* cell=[tableView dequeueReusableCellWithIdentifier:@"StoreItemHeader"  forIndexPath:indexPath];
            return cell;
        }
        else
        {
            CollectionViewTableViewCell* cell=[tableView dequeueReusableCellWithIdentifier:@"StoreItemCell" forIndexPath:indexPath];
            [cell registerNib:[UINib nibWithNibName:@"ServiceObjectCell" bundle:nil] forCellWithReuseIdentifier:@"ServiceObjectCell"];
            cell.delegate=self;
            cell.flowLayout=flow;
            return cell;
        }
    }
    else if(sec==2)
    {
        if (row==0) {
            UITableViewCell* cell=[tableView dequeueReusableCellWithIdentifier:@"StoreIntroHeader"  forIndexPath:indexPath];
            return cell;
        }
        else
        {
//            WebViewTableViewCell* cell=[tableView dequeueReusableCellWithIdentifier:@"StoreIntroCell" forIndexPath:indexPath];
//            [cell.webView loadHTMLString:self.detailStoreModel.store_content baseURL:[NSURL URLWithString:[ZZUrlTool main]]];
//            return cell;
            StoreDetailContentCell* cell=[tableView dequeueReusableCellWithIdentifier:@"StoreDetailContentCell" forIndexPath:indexPath];
            NSString* html=self.detailStoreModel.store_content;
//            cell.htmlLabe.font=[UIFont systemFontOfSize:20];
//            html=@"<a href=\"ht/tps://www.baidu.com\">百度</a>";
//            NSAttributedString* attr=[[NSAttributedString alloc]initWithData:[html dataUsingEncoding:NSUnicodeStringEncoding] options:[NSDictionary dictionaryWithObject:NSHTMLTextDocumentType forKey:NSDocumentTypeDocumentAttribute] documentAttributes:nil error:nil];
//            cell.htmlLabe.attributedText=attr;
            [cell.webView loadHTMLString:html baseURL:[NSURL URLWithString:[ZZUrlTool fullUrlWithTail:@"/Entity/Store/show"]]];
            testWebView=cell.webView;
            testWebView.scrollView.delegate=self;
            testWebView.scrollView.scrollsToTop=NO;
//            testWebView.scrollView.scrollEnabled=NO;
            return cell;
        }
    }
    else
    {
        return nil;
    }
}

#pragma mark -collectionviewtableviewcelldelegate

-(NSInteger)numberOfItemsForCollectionViewTableViewCell:(CollectionViewTableViewCell *)cell
{
    return self.detailStoreModel.items.count;
}

-(void)collectionViewTableViewCell:(CollectionViewTableViewCell *)cell didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    StoreItem* m=[self.detailStoreModel.items objectAtIndex:indexPath.row];
    BaseWebViewController* we=[[BaseWebViewController alloc]initWithUrl:[html_store_item_detail urlWithMainUrl]];
    we.idd=m.idd.integerValue;
    we.title=m.name;
    [self.navigationController pushViewController:we animated:YES];
}

-(void)collectionViewTableViewCell:(CollectionViewTableViewCell *)tableViewcell willShowCollectionViewCell:(UICollectionViewCell *)collectionViewCell atIndexPath:(NSIndexPath *)indexPath
{
    if ([collectionViewCell isKindOfClass:[ServiceObjectCell class]]) {
        ServiceObjectCell* obj=(ServiceObjectCell*)collectionViewCell;
        StoreItem* item=[self.detailStoreModel.items objectAtIndex:indexPath.row];
        [obj.img sd_setImageWithURL:[item.thumb urlWithMainUrl]];
        [obj.title setText:item.name];
    }
}

#pragma mark --navi

-(void)storeMessageCell:(StoreDetailBaseMessageCell *)cell didClickNavigation:(UIButton *)button
{
    StoreMapViewController* map=[[StoreMapViewController alloc]init];
    map.presetShops=[NSArray arrayWithObject:self.detailStoreModel];
    [self.navigationController pushViewController:map animated:YES];
}

#pragma mark --appointment

-(void)storeAppointmentView:(StoreAppointmentView *)view didSelectType:(AppointmentType)type
{
    if (type==AppointmentTypePhone) {
        NSString* str=[NSString stringWithFormat:@"tel://%@",self.detailStoreModel.store_tel];
        NSURL* phone=[NSURL URLWithString:str];
        if ([[UIApplication sharedApplication]canOpenURL:phone] ) {
            UIAlertController* alert=[UIAlertController alertControllerWithTitle:@"是否拨打以下预约电话" message:self.detailStoreModel.store_tel preferredStyle:UIAlertControllerStyleAlert];
            [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                
            }]];
            [alert addAction:[UIAlertAction actionWithTitle:@"拨打" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                
                [[UIApplication sharedApplication]openURL:phone];
            }]];
            [self presentViewController:alert animated:YES completion:^{
                
            }];
        }
        else{
            UIAlertController* alert=[UIAlertController alertControllerWithTitle:@"出现问题" message:@"设备不支持拨打电话" preferredStyle:UIAlertControllerStyleAlert];
            [alert addAction:[UIAlertAction actionWithTitle:@"好" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                
            }]];
            [self presentViewController:alert animated:YES completion:^{
                
            }];
        }
    }
    else if(type==AppointmentTypeNormal)
    {
        UserModel* currentUser=[UserModel getUser];
        if (currentUser.access_token.length==0) {
            // did not log in
            [MBProgressHUD showErrorMessage:@"请登录后再操作"];
            PersonalLoginViewController* lo=[[UIStoryboard storyboardWithName:@"Personal" bundle:nil]instantiateViewControllerWithIdentifier:@"PersonalLoginViewController"];
            [self.navigationController pushViewController:lo animated:YES];
        }
        else
        {
            StoreAppointmentViewController* app=[[UIStoryboard storyboardWithName:@"Store" bundle:nil]instantiateViewControllerWithIdentifier:@"StoreAppointmentViewController"];
            app.store=self.detailStoreModel;
            [self.navigationController pushViewController:app animated:YES];
        }
    }
}

@end
