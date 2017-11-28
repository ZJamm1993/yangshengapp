//
//  StoreAppointmentViewController.m
//  yangsheng
//
//  Created by Macx on 17/7/18.
//  Copyright © 2017年 jam. All rights reserved.
//

#import "StoreAppointmentViewController.h"
#import "PickerShadowContainer.h"
#import "StoreAppointmentView.h"
#import "StoreMapViewController.h"

@interface StoreAppointmentViewController ()<UITextFieldDelegate,UITextViewDelegate,UIPickerViewDelegate,UIPickerViewDataSource,StoreAppointmentViewDelegate>

@property (weak, nonatomic) IBOutlet UILabel *storeNameLabe;
@property (weak, nonatomic) IBOutlet UILabel *storeContact;
@property (weak, nonatomic) IBOutlet UILabel *storeAddress;

@property (weak, nonatomic) IBOutlet UITextField *appointmentTime;
@property (weak, nonatomic) IBOutlet UITextField *appointmentProject;
@property (weak, nonatomic) IBOutlet UITextField *appointmentProjectClass;
@property (weak, nonatomic) IBOutlet UITextField *phoneTextField;
@property (weak, nonatomic) IBOutlet UILabel *markPlaceHolder;
@property (weak, nonatomic) IBOutlet UITextView *markTextView;

@end

@implementation StoreAppointmentViewController
{
    UIDatePicker* datePickerView;
    UIPickerView* projectPickerView;
    StoreAppointmentView* appointmentView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title=@"在线预约";
    
    self.tableView.contentInset=UIEdgeInsetsMake(0, 0, 49, 0);
    
    self.storeNameLabe.text=self.store.store_title;
    self.storeContact.text=[NSString stringWithFormat:@"%@/%@",self.store.store_author,self.store.store_tel];
    self.storeAddress.text=self.store.store_address;
    
    self.appointmentTime.delegate=self;
    self.appointmentProject.delegate=self;
    self.appointmentProjectClass.delegate=self;
    self.phoneTextField.delegate=self;
    self.markTextView.delegate=self;
    
    [self.refreshControl removeFromSuperview];
    
    appointmentView=[StoreAppointmentView defaultAppointmentViewWithTypes:[NSArray arrayWithObjects:[NSNumber numberWithInteger:AppointmentTypeCheck],[NSNumber numberWithInteger:AppointmentTypeNormal],nil]];
    appointmentView.delegate=self;
    
    [self performSelector:@selector(scrollViewDidScroll:) withObject:self.tableView afterDelay:0.01];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)goToNavi:(id)sender {
    StoreMapViewController* map=[[StoreMapViewController alloc]init];
    map.presetShops=[NSArray arrayWithObject:self.store];
    [self.navigationController pushViewController:map animated:YES];
}
- (IBAction)goToAppointment:(id)sender {
    
#warning unfinish
    NSString* store_id=self.store.idd;
    NSString* date=self.appointmentTime.text;
    NSString* u_tel=self.phoneTextField.text;
    NSString* item_name=self.appointmentProject.text;
    if (date.length>0&&u_tel.length>0&&[u_tel isMobileNumber]) {
        [MBProgressHUD showProgressMessage:@"正在预约"];
        [StoreHttpTool appointStoreWithStoreId:store_id date:date tel:u_tel itemName:item_name token:[[UserModel getUser]access_token] success:^(BOOL appointed, NSString *msg) {
            if (appointed) {
                [MBProgressHUD showSuccessMessage:@"预约成功"];
                [self.navigationController popViewControllerAnimated:YES];
            }
            else
            {
                [MBProgressHUD showErrorMessage:msg];
            }
        }];
    }
    else if (![u_tel isMobileNumber])
    {
        [MBProgressHUD showErrorMessage:@"请填写正确的手机号码"];
    }
    else
    {
        [MBProgressHUD showErrorMessage:@"请填写完整"];
    }
}


-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    if (textField==self.appointmentProject) {
        [self selectAppointProject];
        [self.view endEditing:YES];
        return NO;
    }
    else if(textField==self.appointmentTime)
    {
        [self selectAppointTime];
        [self.view endEditing:YES];
        return NO;
    }
    [self hideAllPickers];
    return YES;
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
//    if (textField) {
//        statements
//    }
    return YES;
}

-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if ([text isEqualToString:@"\n"]) {
        [textView resignFirstResponder];
        return NO;
    }
    return YES;
}

-(void)selectAppointProject
{
    if (projectPickerView==nil) {
        CGFloat h=200;
        projectPickerView=[[UIPickerView alloc]initWithFrame:CGRectMake(0, self.view.frame.size.height-h, self.view.frame.size.width, h)];
        projectPickerView.backgroundColor=[UIColor whiteColor];
        projectPickerView.dataSource=self;
        projectPickerView.delegate=self;
        [self pickerView:projectPickerView didSelectRow:0 inComponent:0];
    }
    [self hideAllPickers];
//    [self.view addSubview:projectPickerView];
    [PickerShadowContainer showPickerContainerWithView:projectPickerView];
}

-(void)selectAppointTime
{
    if (datePickerView==nil) {
        CGFloat h=200;
        datePickerView=[[UIDatePicker alloc]initWithFrame:CGRectMake(0, self.view.frame.size.height-h, self.view.frame.size.width, h)];
        datePickerView.backgroundColor=[UIColor whiteColor];
        datePickerView.datePickerMode=UIDatePickerModeDateAndTime;
        datePickerView.minimumDate=[NSDate date];
        [datePickerView setDate:[NSDate date] animated:NO];
        [datePickerView addTarget:self action:@selector(datePickerValueChanged:) forControlEvents:UIControlEventValueChanged];
        [self datePickerValueChanged:datePickerView];
    }
    [self hideAllPickers];
//    [self.view addSubview:datePickerView];
    [PickerShadowContainer showPickerContainerWithView:datePickerView];
}



-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [self.tableView endEditing:YES];
    [self hideAllPickers];
}

-(void)hideAllPickers
{
    [projectPickerView removeFromSuperview];
    [datePickerView removeFromSuperview];
}

#pragma mark datepicker

-(void)datePickerValueChanged:(UIDatePicker*)pick
{
    if (pick==datePickerView) {
        NSDate* date=pick.date;
        NSLog(@"%@",date);
        
        NSDateFormatter* format=[[NSDateFormatter alloc]init];
        format.dateFormat=@"yyyy-MM-dd HH:mm:ss";
        NSString* dateString=[format stringFromDate:date];
        self.appointmentTime.text=dateString;
    }
}

#pragma mark pickerview

-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    if (pickerView==projectPickerView) {
        return 1;
    }
    return 0;
}

-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    if (pickerView==projectPickerView) {
        return self.store.items.count+1;
    }
    return 0;
}

-(NSString*)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    if (pickerView==projectPickerView) {
        if (row==0) {
            return @"";
        }
        else
        {
            StoreItem* it=[self.store.items objectAtIndex:row-1];
            return it.name;
        }
    }
    return @"";
}

-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    if (pickerView==projectPickerView) {
        self.appointmentProject.text=[self pickerView:pickerView titleForRow:row forComponent:component];
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return UITableViewAutomaticDimension;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section==0) {
        return 12;
    }
    return 0.001;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 12;
}

-(NSString*)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section
{
    return nil;
}

-(NSString*)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return nil;
}

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
    }
}

-(void)storeAppointmentView:(StoreAppointmentView *)view didSelectType:(AppointmentType)type
{
    UserModel* usr=[UserModel getUser];
    if (usr.access_token.length==0) {
        UIViewController* lo=[[UIStoryboard storyboardWithName:@"Personal" bundle:nil]instantiateViewControllerWithIdentifier:@"PersonalLoginViewController"];
        [self.navigationController pushViewController:lo animated:YES];
        [MBProgressHUD showErrorMessage:@"请先登录"];
        return;
    }
    if (type==AppointmentTypeCheck) {
        UIViewController* app=[[UIStoryboard storyboardWithName:@"Store" bundle:nil]instantiateViewControllerWithIdentifier:@"StoreAllAppoinmentListViewController"];
        [self.navigationController pushViewController:app animated:YES];
    }
    else if(type==AppointmentTypeNormal)
    {
        [self goToAppointment:nil];
    }
}

@end
