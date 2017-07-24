//
//  CodeScanerViewController.m
//  yangsheng
//
//  Created by Macx on 17/7/13.
//  Copyright © 2017年 jam. All rights reserved.
//

#import "CodeScanerViewController.h"
#import <AVFoundation/AVFoundation.h>
#import "ProductCheckViewController.h"

@interface CodeScanerViewController ()<AVCaptureMetadataOutputObjectsDelegate>

@property (strong,nonatomic)AVCaptureDevice * device;
@property (strong,nonatomic)AVCaptureDeviceInput * input;
@property (strong,nonatomic)AVCaptureMetadataOutput * output;
@property (strong,nonatomic)AVCaptureSession * session;
@property (strong,nonatomic)AVCaptureVideoPreviewLayer * preview;



@end

@implementation CodeScanerViewController
{
    CGRect scanRect;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title=@"扫一扫";
    
    CGRect fr=self.view.bounds;
    
    scanRect=CGRectMake(0, 0, 200, 200);
    scanRect.origin.y=fr.size.height/2-scanRect.size.height/2-64;
    scanRect.origin.x=fr.size.width/2-scanRect.size.width/2;
    
    UIColor* bgColor=[UIColor colorWithWhite:0 alpha:0.5];
    
    UIView* top=[[UIView alloc]initWithFrame:CGRectMake(0, 0, fr.size.width, scanRect.origin.y)];
    top.backgroundColor=bgColor;
    [self.view addSubview:top];
    
    UIView* lef=[[UIView alloc]initWithFrame:CGRectMake(0, scanRect.origin.y, scanRect.origin.x, scanRect.size.height)];
    lef.backgroundColor=bgColor;
    [self.view addSubview:lef];
    
    UIView* rig=[[UIView alloc]initWithFrame:CGRectMake(CGRectGetMaxX(scanRect), scanRect.origin.y, fr.size.width-CGRectGetMaxX(scanRect), scanRect.size.height)];
    rig.backgroundColor=bgColor;
    [self.view addSubview:rig];
    
    UIView* bot=[[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(scanRect), fr.size.width, fr.size.height-CGRectGetMaxY(scanRect))];
    bot.backgroundColor=bgColor;
    [self.view addSubview:bot];
    
    CGRect interestingRect=CGRectMake(scanRect.origin.y/fr.size.height,
                                                               scanRect.origin.x/fr.size.width,
                                                               scanRect.size.height/fr.size.height,
                                                               scanRect.size.width/fr.size.width);
    
    UIView* rectView=[[UIView alloc]initWithFrame:scanRect];
    rectView.layer.borderColor=[UIColor greenColor].CGColor;
    rectView.layer.borderWidth=1;
    [self.view addSubview:rectView];
    
    // Device
    _device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    
    // Input
    _input = [AVCaptureDeviceInput deviceInputWithDevice:self.device error:nil];
    
    // Output
    _output = [[AVCaptureMetadataOutput alloc]init];
    [_output setMetadataObjectsDelegate:self queue:dispatch_get_main_queue()];
    
    // Session
    _session = [[AVCaptureSession alloc]init];
    [_session setSessionPreset:AVCaptureSessionPresetHigh];
    
    
    if ([_session canAddInput:self.input])
    {
        [_session addInput:self.input];
    }
    
    if ([_session canAddOutput:self.output])
    {
        [_session addOutput:self.output];
    }
//    设置条码类型
    if ([_output.availableMetadataObjectTypes containsObject:AVMetadataObjectTypeQRCode]) {
         _output.metadataObjectTypes =@[AVMetadataObjectTypeQRCode];
        _output.rectOfInterest=interestingRect;
    }
   
//    添加扫描画面
    
    _preview =[AVCaptureVideoPreviewLayer layerWithSession:_session];
    _preview.videoGravity =AVLayerVideoGravityResizeAspectFill;
    _preview.frame =self.view.layer.bounds;
    [self.view.layer insertSublayer:_preview atIndex:0];
//    开始扫描
    
    [_session startRunning];
    
    
    // Do any additional setup after loading the view.
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [_session startRunning];
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [_session stopRunning];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)captureOutput:(AVCaptureOutput *)captureOutput didOutputMetadataObjects:(NSArray *)metadataObjects fromConnection:(AVCaptureConnection *)connection
{
    NSString *stringValue;
    [_session stopRunning];
    if ([metadataObjects count] >0){
        //停止扫描
//        [_session stopRunning];
        AVMetadataMachineReadableCodeObject * metadataObject = [metadataObjects objectAtIndex:0];
        stringValue = metadataObject.stringValue;
        NSLog(@"%@",stringValue);
        
        [self onResult:stringValue];
//        UIAlertView* al=[[UIAlertView alloc]initWithTitle:@"result" message:stringValue delegate:nil cancelButtonTitle:@"ok" otherButtonTitles: nil];
//        [al show];
//
//        [[UIApplication sharedApplication]openURL:[NSURL URLWithString:stringValue]];
        
//        ProductCheckViewController* pro=[[UIStoryboard storyboardWithName:@"Home" bundle:nil]instantiateViewControllerWithIdentifier:@"ProductCheckViewController"];
//        pro.productCode=stringValue;
//        [self.navigationController pushViewController:pro animated:YES];
    }
}

-(void)onResult:(NSString *)result
{
    
}

@end
