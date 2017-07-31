//
//  CustomerServiceViewController.m
//  yangsheng
//
//  Created by Macx on 17/7/24.
//  Copyright © 2017年 jam. All rights reserved.
//

#import "CustomerServiceViewController.h"
#import "UniversalModel.h"
#import "WXApi.h"

@interface CustomerServiceViewController ()
@property (weak, nonatomic) IBOutlet UIButton *savebtn;
@property (weak, nonatomic) IBOutlet UIButton *openbtn;

@end

@implementation CustomerServiceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title=@"联系客服";
    
    NSString* imgUrl=[[UniversalModel getUniversal]wx_path];
    
    [self.qrCodeImage sd_setImageWithURL:[imgUrl urlWithMainUrl]];
    
    self.savebtn.layer.cornerRadius=self.savebtn.bounds.size.height/2;
    self.savebtn.layer.borderColor=[UIColor colorWithWhite:0.7 alpha:1].CGColor;
    self.savebtn.layer.borderWidth=0.5;
    
    self.openbtn.layer.cornerRadius=self.openbtn.bounds.size.height/2;
    self.openbtn.layer.borderColor=[UIColor colorWithWhite:0.7 alpha:1].CGColor;
    self.openbtn.layer.borderWidth=0.5;
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

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

- (IBAction)openWechat:(id)sender {

    [WXApi openWXApp];
    
    return;
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
}

@end
