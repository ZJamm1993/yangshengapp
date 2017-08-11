//
//  CustomerServiceViewController.m
//  yangsheng
//
//  Created by Macx on 17/7/24.
//  Copyright © 2017年 jam. All rights reserved.
//

#import "CustomerServiceViewController.h"
#import "WaiterCollectionCell.h"
//#import "UniversalModel.h"
//#import "WXApi.h"

#import "UniversalHttpTool.h"

@interface CustomerServiceViewController ()
//@property (weak, nonatomic) IBOutlet UIButton *savebtn;
//@property (weak, nonatomic) IBOutlet UIButton *openbtn;

@end

@implementation CustomerServiceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title=@"联系客服";
//
//    NSString* imgUrl=[[UniversalModel getUniversal]wx_path];
//    
//    [self.qrCodeImage sd_setImageWithURL:[imgUrl urlWithMainUrl]];
//    
//    self.savebtn.layer.cornerRadius=self.savebtn.bounds.size.height/2;
//    self.savebtn.layer.borderColor=[UIColor colorWithWhite:0.7 alpha:1].CGColor;
//    self.savebtn.layer.borderWidth=0.5;
//    
//    self.openbtn.layer.cornerRadius=self.openbtn.bounds.size.height/2;
//    self.openbtn.layer.borderColor=[UIColor colorWithWhite:0.7 alpha:1].CGColor;
//    self.openbtn.layer.borderWidth=0.5;
//    
//    // Do any additional setup after loading the view.
    
    self.collectionView.collectionViewLayout=self.collectionViewLayout;
    [self firstLoad];
}

-(void)firstLoad
{
    UniversalModel* currentModel=[UniversalModel getUniversal];
    if (currentModel.photos.count>0) {
        self.dataSource=[NSMutableArray arrayWithArray:currentModel.photos];
        //        [self.collectionView reloadData];
        [self.collectionView reloadSections:[NSIndexSet indexSetWithIndexesInRange:NSMakeRange(0, self.collectionView.numberOfSections)]];
    }
    else
    {
        [self refresh];
    }
}

-(void)refresh
{
    [self stopRefreshAfterSeconds];
    [UniversalHttpTool getUniversalProfileSuccess:^(UniversalModel *univaer) {
        if (univaer) {
            [UniversalModel saveUniversal:univaer];
            if (univaer.photos.count>0) {
                self.dataSource=[NSMutableArray arrayWithArray:univaer.photos];
                //                [self.collectionView reloadData];
                [self.collectionView reloadSections:[NSIndexSet indexSetWithIndexesInRange:NSMakeRange(0, self.collectionView.numberOfSections)]];
            }
        }
    } isCache:NO];
}

-(UICollectionViewLayout*)collectionViewLayout
{
    UICollectionViewFlowLayout* flow=[[UICollectionViewFlowLayout alloc]init];
    
    CGFloat sw=[[UIScreen mainScreen]bounds].size.width;
    CGFloat m=10;
    CGFloat w=sw/2-3*m;
    CGFloat h=w+90;
    
    flow.itemSize=CGSizeMake(w, h);
    flow.minimumLineSpacing=2*m;
    flow.minimumInteritemSpacing=0;
    flow.sectionInset=UIEdgeInsetsMake(2*m,2*m,m,2*m);
    
    return flow;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.dataSource.count;
}

-(UICollectionViewCell*)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    WaiterCollectionCell* wai=[collectionView dequeueReusableCellWithReuseIdentifier:@"WaiterCollectionCell" forIndexPath:indexPath];
    WaiterModel* m=[self.dataSource objectAtIndex:indexPath.row];
    [wai.imageView sd_setImageWithURL:[m.url urlWithMainUrl]];
    [wai.textLabe setText:m.alt];
    return wai;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    [collectionView deselectItemAtIndexPath:indexPath animated:YES];
    WaiterModel* m=[self.dataSource objectAtIndex:indexPath.row];
    NSData* imgdata=[NSData dataWithContentsOfURL:[[m url]urlWithMainUrl]];
    UIImageWriteToSavedPhotosAlbum([UIImage imageWithData:imgdata], self, @selector(image:didFinishSavingWithError:contextInfo:), NULL);
}

//- (void)didReceiveMemoryWarning {
//    [super didReceiveMemoryWarning];
//    // Dispose of any resources that can be recreated.
//}
//
///*
//#pragma mark - Navigation
//
//// In a storyboard-based application, you will often want to do a little preparation before navigation
//- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
//    // Get the new view controller using [segue destinationViewController].
//    // Pass the selected object to the new view controller.
//}
//*/
//
- (IBAction)saveImage:(id)sender {
    NSData* imgdata=[NSData dataWithContentsOfURL:[[[UniversalModel getUniversal]wx_path]urlWithMainUrl]];
    UIImageWriteToSavedPhotosAlbum([UIImage imageWithData:imgdata], self, @selector(image:didFinishSavingWithError:contextInfo:), NULL);
}

- (void)image: (UIImage *) image didFinishSavingWithError: (NSError *) error contextInfo: (void *) contextInfo
{
    NSString *msg = nil ;
    if(error != NULL){
        msg = @"保存图片失败" ;
        [MBProgressHUD showErrorMessage:msg];
    }else{
        msg = @"保存图片成功" ;
        [MBProgressHUD showSuccessMessage:msg];
    }

}
//
//- (IBAction)openWechat:(id)sender {
//
//    [WXApi openWXApp];
//    
//    return;
//    return;
//    CIDetector*detector = [CIDetector detectorOfType:CIDetectorTypeQRCode context:nil options:@{ CIDetectorAccuracy : CIDetectorAccuracyHigh }];
//    //2. 扫描获取的特征组
//    NSArray *features = [detector featuresInImage:[CIImage imageWithCGImage:self.qrCodeImage.image.CGImage]];
//    //3. 获取扫描结果
//    CIQRCodeFeature *feature = [features objectAtIndex:0];
//    NSString *scannedResult = feature.messageString;
    
    /*
    
    
//    1.创建多媒体消息结构体
    WXMediaMessage *mediaMsg = [WXMediaMessage message];
//    2.创建多媒体消息中包含的图片数据对象
    WXImageObject *imgObj = [WXImageObject object];
//    图片真实数据
    imgObj.imageData = [NSData dataWithContentsOfURL:[[[UniversalModel getUniversal]wx_path]urlWithMainUrl]];
//    多媒体数据对象
    mediaMsg.mediaObject = imgObj;
    
//    WXWebpageObject* we=[WXWebpageObject object];
//    we.webpageUrl=scannedResult;
//    mediaMsg.mediaObject=we;
    
    //3.创建发送消息至微信终端程序的消息结构体
    SendMessageToWXReq *req = [[SendMessageToWXReq alloc] init];
    //多媒体消息的内容
    req.message = mediaMsg;
    //指定为发送多媒体消息（不能同时发送文本和多媒体消息，两者只能选其一）
    req.bText = NO;
    //指定发送到会话(聊天界面)
    req.scene = WXSceneSession;
    //发送请求到微信,等待微信返回onResp
    [WXApi sendReq:req];
    
//    JumpToBizProfileReq *req = [[JumpToBizProfileReq alloc]init];
//    req.profileType = WXBizProfileType_Normal;
//    req.username = @"gh_6b31b722a1e8";
//    [WXApi sendReq:req];
    
//    [[UIApplication sharedApplication]openURL:[NSURL URLWithString:@"weixin://dl/scan"]];
     
     
     */
//}

@end
