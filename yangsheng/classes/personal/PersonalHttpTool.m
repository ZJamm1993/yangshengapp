//
//  PersonalHttpTool.m
//  yangsheng
//
//  Created by Macx on 17/7/12.
//  Copyright © 2017年 jam. All rights reserved.
//

#import "PersonalHttpTool.h"

@implementation PersonalHttpTool

+(void)logOutUserToken:(NSString *)token
{
    NSMutableDictionary* p=[NSMutableDictionary dictionary];
    [p setValue:token forKey:@"access_token"];
    
    NSString* str=[ZZUrlTool fullUrlWithTail:@"/User/Login/logout"];
    [self post:str params:p success:nil failure:nil];
}

+(void)getUserInfoWithToken:(NSString *)token success:(void (^)(UserModel *))success
{
    NSString* str=[ZZUrlTool fullUrlWithTail:@"/User/Profile/userinfo"];
    NSMutableDictionary* p=[NSMutableDictionary dictionary];
    [p setValue:token forKey:@"access_token"];
    [self get:str params:p usingCache:NO success:^(NSDictionary *res) {
        NSDictionary* data=[res valueForKey:@"data"];
        UserModel* us=[[UserModel alloc]initWithDictionary:data];
        if (us.access_token.length>0) {
            if (success) {
                success(us);
            }
            return;
        }
        if (success) {
            success(nil);
        }
    } failure:^(NSError *err) {
    }];
}

+(void)getCodeWithMobile:(NSString *)mobile success:(void (^)(BOOL))success
{
    NSString* str=[ZZUrlTool fullUrlWithTail:@"/User/Index/getmobilenum"];
    [self post:str params:[NSDictionary dictionaryWithObject:mobile forKey:@"mobile"] success:^(NSDictionary *responseObject) {
        NSString* msg=[responseObject valueForKey:@"message"];
        NSLog(@"msg:%@",msg);
        
        if (success) {
            if (responseObject.code==0) {
                success(YES);
//#warning 不要告诉我验证码
//                [MBProgressHUD showSuccessMessage:msg];
            }
            else
            {
                success(NO);
            }
        }
    } failure:^(NSError *error) {
        success(NO);
    }];
}

+(void)registerUserWithMobile:(NSString *)mobile password:(NSString *)password code:(NSString *)code invite:(NSString *)invite success:(void (^)(UserModel *))success
{
    invite=@"20";
    if (mobile.length==0||password.length==0||code.length==0||invite.length==0) {
        if (success) {
            success(nil);
            
        }
        return;
    }
    NSString* str=[ZZUrlTool fullUrlWithTail:@"/User/Register/doregister"];
    
    NSMutableDictionary* p=[NSMutableDictionary dictionary];
    
    [p setValue:mobile forKey:@"mobile"];
    [p setValue:password forKey:@"password"];
    [p setValue:code forKey:@"code"];
    [p setValue:invite forKey:@"invite"];
    
    [self post:str params:p success:^(NSDictionary *responseObject) {
        NSDictionary* data=[responseObject valueForKey:@"data"];
        UserModel* us=[[UserModel alloc]initWithDictionary:data];
        if (success) {
            success(us);
        }
    } failure:^(NSError *error) {
        if (success) {
            success(nil);
        }
    }];
}

+(void)changePasswordWithMobile:(NSString *)mobile password:(NSString *)password code:(NSString *)code success:(void (^)(BOOL))success
{
    if (mobile.length==0||password.length==0||code.length==00) {
        if (success) {
            success(NO);
            
        }
        return;
    }
    NSString* str=[ZZUrlTool fullUrlWithTail:@"/User/Login/do_mobile_forgot_password"];
    
    NSMutableDictionary* p=[NSMutableDictionary dictionary];
    
    [p setValue:mobile forKey:@"mobile"];
    [p setValue:password forKey:@"password"];
    [p setValue:code forKey:@"code"];
    
    [self post:str params:p success:^(NSDictionary *responseObject) {
        BOOL changed=responseObject.code==0;
        if (success) {
            success(changed);
        }
    } failure:^(NSError *error) {
        if (success) {
            success(NO);
        }
    }];
}

+(void)changePasswordWithOldPassword:(NSString *)old newPassword:(NSString *)neew token:(NSString *)token success:(void (^)(BOOL))success
{
    if (old.length==0||neew.length==0||token.length==00) {
        if (success) {
            success(NO);
            
        }
        return;
    }
    NSString* str=[ZZUrlTool fullUrlWithTail:@"/User/Login/dopassword_reset"];
    
    NSMutableDictionary* p=[NSMutableDictionary dictionary];
    
    [p setValue:old forKey:@"oldpassword"];
    [p setValue:neew forKey:@"password"];
    [p setValue:neew forKey:@"repassword"];
    [p setValue:token forKey:@"access_token"];
    
    [self post:str params:p success:^(NSDictionary *responseObject) {
        BOOL changed=responseObject.code==0;
        if (success) {
            success(changed);
        }
    } failure:^(NSError *error) {
        if (success) {
            success(NO);
        }
    }];
}

+(void)changeUserNickName:(NSString *)nick token:(NSString *)token success:(void (^)(BOOL))success
{
    if (nick.length==0||token.length==0) {
        if (success) {
            success(NO);
            
        }
        return;
    }
    NSString* str=[ZZUrlTool fullUrlWithTail:@"/User/Profile/edit_post"];
    
    NSMutableDictionary* p=[NSMutableDictionary dictionary];
    
    [p setValue:nick forKey:@"user_nicename"];
    [p setValue:token forKey:@"access_token"];
    
    [self post:str params:p success:^(NSDictionary *responseObject) {
        BOOL changed=responseObject.code==0;
        if (success) {
            success(changed);
        }
    } failure:^(NSError *error) {
        if (success) {
            success(NO);
        }
    }];
}

+(void)changeUserMobile:(NSString *)mobile code:(NSString *)code token:(NSString *)token success:(void (^)(BOOL))success
{
    if (mobile.length==0||token.length==0||code.length==0) {
        if (success) {
            success(NO);
            
        }
        return;
    }
    NSString* str=[ZZUrlTool fullUrlWithTail:@"/User/Profile/edit_post"];
    
    NSMutableDictionary* p=[NSMutableDictionary dictionary];
    
    [p setValue:mobile forKey:@"mobile"];
    [p setValue:code forKey:@"code"];
    [p setValue:token forKey:@"access_token"];
    
    [self post:str params:p success:^(NSDictionary *responseObject) {
        BOOL changed=responseObject.code==0;
        if (success) {
            success(changed);
        }
    } failure:^(NSError *error) {
        if (success) {
            success(NO);
        }
    }];
}

+(void)loginUserWithMobile:(NSString *)mobile password:(NSString *)password success:(void (^)(UserModel *))success
{
    if (mobile.length==0||password.length==0) {
        if (success) {
            success(nil);
            
        }
        return;
    }
    NSString* str=[ZZUrlTool fullUrlWithTail:@"/User/Login/dologin"];
    
    NSMutableDictionary* p=[NSMutableDictionary dictionary];
    
    [p setValue:mobile forKey:@"mobile"];
    [p setValue:password forKey:@"password"];
    
    [self post:str params:p success:^(NSDictionary *responseObject) {
        NSDictionary* data=[responseObject valueForKey:@"data"];
        UserModel* us=[[UserModel alloc]initWithDictionary:data];
        if (success) {
            success(us);
        }
    } failure:^(NSError *error) {
        if (success) {
            success(nil);
        }
    }];
}

+(void)loginUserWithWechatCode:(NSString *)code success:(void (^)(UserModel *))success
{
    if (code.length==0) {
        if (success) {
            success(nil);
        }
        return;
    }
    NSString* str=[ZZUrlTool fullUrlWithTail:@"/User/Login/authorization"];
    
    NSMutableDictionary* p=[NSMutableDictionary dictionary];
    [p setValue:code forKey:@"code"];
    
    [self post:str params:p success:^(NSDictionary *responseObject) {
        NSDictionary* data=[responseObject valueForKey:@"data"];
        UserModel* us=[[UserModel alloc]initWithDictionary:data];
        if (success) {
            success(us);
        }
    } failure:^(NSError *error) {
        if (success) {
            success(nil);
        }
    }];
}

+(void)uploadAvatar:(UIImage *)avatar token:(NSString *)token success:(void (^)(NSString *))success
{
    NSURL* _ur=[NSURL URLWithString:[ZZUrlTool fullUrlWithTail:@"/User/Profile/avatar_upload"]];
    
    
    // Dictionary that holds post parameters. You can set your post parameters that your server accepts or programmed to accept.
    NSMutableDictionary* _params = [[NSMutableDictionary alloc] init];
    [_params setValue:token forKey:@"access_token"];
    
    // the boundary string : a random string, that will not repeat in post data, to separate post data fields.
    NSString *BoundaryConstant = @"----------V2ymHFg03ehbqgZCaKO6jy";
    
    // string constant for the post parameter 'file'. My server uses this name: `file`. Your's may differ
    NSString* FileParamConstant = @"img";
    
    // the server url to which the image (or the media) is uploaded. Use your server url here
    NSURL* requestURL = _ur;
    
    // create request
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setCachePolicy:NSURLRequestReloadIgnoringLocalCacheData];
    [request setHTTPShouldHandleCookies:NO];
    [request setTimeoutInterval:30];
    [request setHTTPMethod:@"POST"];
    
    // set Content-Type in HTTP header
    NSString *contentType = [NSString stringWithFormat:@"multipart/form-data; boundary=%@", BoundaryConstant];
    [request setValue:contentType forHTTPHeaderField: @"Content-Type"];
    
    // post body
    NSMutableData *body = [NSMutableData data];
    
    // add params (all params are strings)
    for (NSString *param in _params) {
        [body appendData:[[NSString stringWithFormat:@"--%@\r\n", BoundaryConstant] dataUsingEncoding:NSUTF8StringEncoding]];
        [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"%@\"\r\n\r\n", param] dataUsingEncoding:NSUTF8StringEncoding]];
        [body appendData:[[NSString stringWithFormat:@"%@\r\n", [_params objectForKey:param]] dataUsingEncoding:NSUTF8StringEncoding]];
    }
    
    // add image data
    CGSize size=CGSizeMake(200,200);
    UIGraphicsBeginImageContext(CGSizeMake(size.width,size.height));
    [avatar drawInRect:CGRectMake(0, 0, size.width, size.height)];
    
    UIImage *scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    NSData *imageData = UIImageJPEGRepresentation(scaledImage, 0.8);
    if (imageData) {
        [body appendData:[[NSString stringWithFormat:@"--%@\r\n", BoundaryConstant] dataUsingEncoding:NSUTF8StringEncoding]];
        [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"%@\"; filename=\"image.jpg\"\r\n", FileParamConstant] dataUsingEncoding:NSUTF8StringEncoding]];
        [body appendData:[@"Content-Type: image/jpeg\r\n\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
        [body appendData:imageData];
        [body appendData:[[NSString stringWithFormat:@"\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
    }
    
    [body appendData:[[NSString stringWithFormat:@"--%@--\r\n", BoundaryConstant] dataUsingEncoding:NSUTF8StringEncoding]];
    
    // setting the body of the post to the reqeust
    [request setHTTPBody:body];
    
    // set the content-length
    NSString *postLength = [NSString stringWithFormat:@"%d",(int) [body length]];
    [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
    
    // set URL
    [request setURL:requestURL];
        NSURLSession* session=[NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
        NSURLSessionDataTask* dataTast=[session dataTaskWithRequest:request completionHandler:^(NSData * data, NSURLResponse * response, NSError * error) {
            //            NSLog(@"data:\n%@",data);
            //            NSLog(@"resp:\n%@",response);
            //            NSLog(@"erro:\n%@",error);
            
            dispatch_async(dispatch_get_main_queue(), ^{
                if (data) {
                    NSDictionary* result=[self dictionaryWithResponseData:data];
                    NSString* d=[result valueForKey:@"data"];
                    if (success) {
                        success(d);
                    }
                }
                else if(error)
                {
                    if (success) {
                        success(@"");
                    }
                }
            });
            
        }];
        [dataTast resume];
}

@end
