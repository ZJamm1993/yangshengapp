//
//  StoreHttpTool.m
//  yangsheng
//
//  Created by Macx on 17/7/13.
//  Copyright © 2017年 jam. All rights reserved.
//

#import "StoreHttpTool.h"

@implementation StoreHttpTool

+(void)getNeighbourStoreListPage:(NSInteger)page lng:(NSString *)lng lat:(NSString *)lat mult:(NSInteger)mult cityCode:(NSString*)cityCode success:(void (^)(NSArray *,CityModel*))success isCache:(BOOL)isCache
{
    NSString* str=[ZZUrlTool fullUrlWithTail:@"/Entity/Store/list"];
    if (lng.length==0) {
        lng=@"113.389563";
    }
    if (lat.length==0) {
        lat=@"23.115948";
    }
    NSMutableDictionary* par=[self pageParams];
    [par setValue:[NSNumber numberWithInteger:page] forKey:@"page"];
    [par setValue:lng forKey:@"lng"];
    [par setValue:lat forKey:@"lat"];
    [par setValue:[NSNumber numberWithInteger:mult] forKey:@"mult"];
    [par setValue:cityCode forKey:@"citycode"];
    
    [self get:str params:par usingCache:isCache success:^(NSDictionary *resp) {
        NSDictionary* data=[resp valueForKey:@"data"];
        NSArray* list=[data valueForKey:@"list"];
        NSMutableArray* arr=[NSMutableArray array];
        for (NSDictionary* st in list) {
            StoreModel* store=[[StoreModel alloc]initWithDictionary:st];
            [arr addObject:store];
        }
        NSDictionary* loc=[data valueForKey:@"location"];
        CityModel* city=[[CityModel alloc]initWithDictionary:loc];
        if (success) {
            success(arr,city);
        }
    } failure:^(NSError *f) {
        
    }];
}

///Entity/Store/all_list
+(void)getAllStoreListPage:(NSInteger)page success:(void (^)(NSArray *))success isCache:(BOOL)isCache
{
    NSString* str=[ZZUrlTool fullUrlWithTail:@"/Entity/Store/all_list"];
        NSMutableDictionary* par=[self pageParams];
    [par setValue:[NSNumber numberWithInteger:page] forKey:@"page"];
    
    [self get:str params:par usingCache:isCache success:^(NSDictionary *resp) {
        NSDictionary* data=[resp valueForKey:@"data"];
        NSArray* list=[data valueForKey:@"list"];
        NSMutableArray* arr=[NSMutableArray array];
        for (NSDictionary* st in list) {
            StoreModel* store=[[StoreModel alloc]initWithDictionary:st];
            [arr addObject:store];
        }
        if (success) {
            success(arr);
        }
    } failure:^(NSError *f) {
        
    }];
}

+(void)getAllStoreMapListSuccess:(void (^)(NSArray *))success isCache:(BOOL)isCache
{
    NSString* str=[ZZUrlTool fullUrlWithTail:@"/Entity/Store/map_list"];
    
    [self get:str params:nil usingCache:isCache success:^(NSDictionary *re) {
        NSDictionary* data=[re valueForKey:@"data"];
        NSArray* list=[data valueForKey:@"list"];
        NSMutableArray* arr=[NSMutableArray array];
        for (NSDictionary* st in list) {
            StoreModel* store=[[StoreModel alloc]initWithDictionary:st];
            [arr addObject:store];
        }
        if (success) {
            success(arr);
        }
    } failure:^(NSError *er) {
        
    }];
}

+(void)searchStoreWithKeyword:(NSString *)keyword page:(NSInteger)page success:(void (^)(NSArray *))success isCache:(BOOL)isCache
{
    if (keyword.length==0) {
        return;
    }
    NSString* ur=[ZZUrlTool fullUrlWithTail:@"/Entity/Store/search"];
    NSMutableDictionary* par=[self pageParams];
    [par setValue:[NSNumber numberWithInteger:page] forKey:@"page"];
    [par setValue:keyword forKey:@"keyword"];
    
    [self post:ur params:par success:^(NSDictionary *resp) {
        NSDictionary* data=[resp valueForKey:@"data"];
        NSArray* list=[data valueForKey:@"list"];
        NSMutableArray* arr=[NSMutableArray array];
        for (NSDictionary* st in list) {
            StoreModel* store=[[StoreModel alloc]initWithDictionary:st];
            [arr addObject:store];
        }
        if (success) {
            success(arr);
        }
    } failure:^(NSError *f) {
        NSLog(@"%@",f);
    }];
}

+(void)getStoreItemsSuccess:(void (^)(NSArray *))success isCache:(BOOL)isCache
{
    NSString* ur=[ZZUrlTool fullUrlWithTail:@"/Entity/Item/list"];
    
    [self get:ur params:nil usingCache:isCache success:^(NSDictionary *responseObject) {
        NSArray* data=[responseObject valueForKey:@"data"];
        NSMutableArray* result=[NSMutableArray array];
        for (NSDictionary* d in data) {
            StoreItem* item=[[StoreItem alloc]initWithDictionary:d];
            [result addObject:item];
        }
        if (success) {
            success(result);
        }
    } failure:^(NSError *err) {
        
    }];
}

+(void)getStoreDetailWithId:(NSString *)idd success:(void (^)(NSArray *))success isCache:(BOOL)isCache
{
    NSString* str=[ZZUrlTool fullUrlWithTail:@"/Entity/Store/show"];
    
    NSMutableDictionary* p=[NSMutableDictionary dictionary];
    [p setValue:idd forKey:@"id"];
    [self get:str params:p usingCache:isCache success:^(NSDictionary *re) {
        NSDictionary* data=[re valueForKey:@"data"];
        NSDictionary* store=[data valueForKey:@"store"];
        NSMutableArray* arr=[NSMutableArray array];
        StoreModel* sm=[[StoreModel alloc]initWithDictionary:store];
        [arr addObject:sm];
        if (success) {
            success(arr);
        }
    } failure:^(NSError *err) {
        
    }];
}

+(void)getCitysWithLevel:(NSString *)level keywords:(NSString *)keywords success:(void (^)(NSArray *))success isCache:(BOOL)isCache
{
    NSString* ur=[ZZUrlTool fullUrlWithTail:@"/Api/map/getdistrict"];
    
    NSMutableDictionary* p=[NSMutableDictionary dictionary];
    [p setValue:level forKey:@"level"];
    [p setValue:keywords forKey:@"keywords"];
    
    [self get:ur params:p usingCache:isCache success:^(NSDictionary *responseObject) {
        NSArray* data=[responseObject valueForKey:@"data"];
        NSMutableArray* result=[NSMutableArray array];
        for (NSDictionary* d in data) {
            CityModel* item=[[CityModel alloc]initWithDictionary:d];
            [result addObject:item];
        }
        if (success) {
            success(result);
        }
    } failure:^(NSError *err) {
        
    }];
}

+(void)getApplyResultWithToken:(NSString *)token success:(void (^)(StoreApplyModel *))success
{
    if (token.length==0) {
        if (success) {
            success(nil);
        }
        return;
    }
    
    NSString* str=[ZZUrlTool fullUrlWithTail:@"/User/Ostore/index"];
    
    NSMutableDictionary* p=[NSMutableDictionary dictionary];
    [p setValue:token forKey:@"access_token"];
    
    [self get:str params:p usingCache:NO success:^(NSDictionary *re) {
        NSDictionary* data=[re valueForKey:@"data"];
        StoreApplyModel* app=[[StoreApplyModel alloc]initWithDictionary:data];
        if (success) {
            success(app);
        }
    } failure:^(NSError *er) {
        if (success) {
            success(nil);
        }
    }];
}

+(void)applyStoreSubmitName:(NSString *)name tel:(NSString *)tel idcard:(NSString *)idcard area:(NSString *)area address:(NSString *)address positive:(NSString *)positive negative:(NSString *)negative token:(NSString *)token success:(void (^)(BOOL, NSString *))success
{
    NSMutableDictionary* di=[NSMutableDictionary dictionary];
    [di setValue:name forKey:@"name"];
    [di setValue:tel forKey:@"tel"];
    [di setValue:idcard forKey:@"idcard"];
    [di setValue:area forKey:@"area"];
    [di setValue:address forKey:@"address"];
    [di setValue:positive forKey:@"positive"];
    [di setValue:negative forKey:@"negative"];
    [di setValue:token forKey:@"access_token"];
    
    NSString* str=[ZZUrlTool fullUrlWithTail:@"/User/Ostore/do_open"];
    
    [self post:str params:di success:^(NSDictionary *responseObject) {
        BOOL ok=responseObject.code==0;
        NSString* msg=[responseObject valueForKey:@"message"];
        if (success) {
            success(ok,msg);
        }
    } failure:^(NSError *error) {
        if (success) {
            success(NO,@"请求失败");
        }
    }];
}

+(void)appointStoreWithStoreId:(NSString *)storeid date:(NSString *)date tel:(NSString *)tel itemName:(NSString *)itemName token:(NSString *)token success:(void (^)(BOOL, NSString *))success
{
    NSMutableDictionary* di=[NSMutableDictionary dictionary];
    [di setValue:storeid forKey:@"store_id"];
    [di setValue:date forKey:@"date"];
    [di setValue:tel forKey:@"u_tel"];
    [di setValue:itemName forKey:@"item_name"];
    [di setValue:token forKey:@"access_token"];
    
    NSString* str=[ZZUrlTool fullUrlWithTail:@"/User/Retention/do_retain"];
    
    [self post:str params:di success:^(NSDictionary *responseObject) {
        BOOL ok=responseObject.code==0;
        NSString* msg=[responseObject valueForKey:@"message"];
        if (success) {
            success(ok,msg);
        }
    } failure:^(NSError *error) {
        if (success) {
            success(NO,@"请求失败");
        }
    }];
}

/////upload idcard

+(void)uploadIDCard:(UIImage *)idcard token:(NSString *)token success:(void (^)(NSString *))success
{
    NSURL* _ur=[NSURL URLWithString:[ZZUrlTool fullUrlWithTail:@"/User/Ostore/avatar_upload"]];
    
    // Dictionary that holds post parameters. You can set your post parameters that your server accepts or programmed to accept.
    NSMutableDictionary* _params = [[NSMutableDictionary alloc] init];
    [_params setValue:token forKey:@"access_token"];
    
    // the boundary string : a random string, that will not repeat in post data, to separate post data fields.
    NSString *BoundaryConstant = @"----------V2ymHFg03ehbqgZCaKO6jy";
    
    // string constant for the post parameter 'file'. My server uses this name: `file`. Your's may differ
    NSString* FileParamConstant = @"file";
    
    // the server url to which the image (or the media) is uploaded. Use your server url here
    NSURL* requestURL = _ur;
    
    // create request
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setCachePolicy:NSURLRequestReloadIgnoringLocalCacheData];
    [request setHTTPShouldHandleCookies:NO];
    [request setTimeoutInterval:60];
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
    
    //unknown size;
    CGSize size=CGSizeMake(1024,768);
    UIGraphicsBeginImageContext(CGSizeMake(size.width,size.height));
    [idcard drawInRect:CGRectMake(0, 0, size.width, size.height)];
    
    UIImage *scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    NSData *imageData = UIImageJPEGRepresentation(scaledImage, 0.7);
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

+(void)getAllAppointmentListPage:(NSInteger)page token:(NSString *)token success:(void (^)(NSArray *))success isCache:(BOOL)isCache
{
    NSString* str=[ZZUrlTool fullUrlWithTail:@"/User/Retention/list"];
    NSMutableDictionary* par=[self pageParams];
    [par setValue:token forKey:@"access_token"];
    [par setValue:[NSNumber numberWithInteger:page] forKey:@"page"];
    
    [self get:str params:par usingCache:isCache success:^(NSDictionary *resp) {
        NSDictionary* data=[resp valueForKey:@"data"];
        NSArray* list=[data valueForKey:@"list"];
        NSMutableArray* arr=[NSMutableArray array];
        for (NSDictionary* st in list) {
            StoreModel* store=[[StoreModel alloc]initWithDictionary:st];
            [arr addObject:store];
        }
        if (success) {
            success(arr);
        }
    } failure:^(NSError *f) {
        
    }];
}

+(void)cancelAppointmentId:(NSString *)idd token:(NSString *)token success:(void (^)(BOOL, NSString *))success
{
    NSMutableDictionary* di=[NSMutableDictionary dictionary];
    [di setValue:idd forKey:@"id"];
    [di setValue:token forKey:@"access_token"];
    
    NSString* str=[ZZUrlTool fullUrlWithTail:@"/User/Retention/delete_retain"];
    
    [self post:str params:di success:^(NSDictionary *responseObject) {
        BOOL ok=responseObject.code==0;
        NSString* msg=[responseObject valueForKey:@"message"];
        if (success) {
            success(ok,msg);
        }
    } failure:^(NSError *error) {
        if (success) {
            success(NO,@"请求失败");
        }
    }];
}

@end
