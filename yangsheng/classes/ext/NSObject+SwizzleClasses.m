//
//  NSObject+SwizzleClasses.m
//  yangsheng
//
//  Created by Macx on 2017/8/22.
//  Copyright © 2017年 jam. All rights reserved.
//

#import "NSObject+SwizzleClasses.h"

//#import <UMMobClick/MobClick.h>
#import "UIImageView+WebCache.h"

@implementation NSObject (SwizzleClasses)

@end

@implementation UITableView(SwizzleClasses)

+(void)load
{
    NSLog(@"UITableView Class Load");
    NSLog(@"swizzle reloaddata");
    [[self class]jr_swizzleMethod:@selector(reloadData) withMethod:@selector(myReloadData) error:nil];
}

-(void)myReloadData
{
    NSDictionary* dic=[NSDictionary dictionaryWithObject:self forKey:@"tableView"];
    [[NSNotificationCenter defaultCenter]postNotificationName:UITableViewReloadDataNotification object:nil userInfo:dic];
    [self myReloadData];
}

@end

@implementation UICollectionView(SwizzleClasses)

+(void)load
{
    NSLog(@"UICollectionView Class Load");
    NSLog(@"swizzle reloadsections");
    [[self class]jr_swizzleMethod:@selector(reloadSections:) withMethod:@selector(myReloadSections:) error:nil];
}

-(void)myReloadSections:(NSIndexSet*)sections
{
    NSDictionary* dic=[NSDictionary dictionaryWithObject:self forKey:@"collectionView"];
    [[NSNotificationCenter defaultCenter]postNotificationName:UICollectionViewReloadSectionsNotification object:nil userInfo:dic];
    [self myReloadSections:sections];
}

@end

@implementation UIViewController(SwizzleClasses)

+(void)load
{
    NSLog(@"UIViewController Class Load");
    NSLog(@"swizzle viewdidload");
    [[self class]jr_swizzleMethod:@selector(viewDidLoad) withMethod:@selector(myViewDidLoad) error:nil];
}

-(void)myViewDidLoad
{
    NSLog(@"\"%@\" view did load",NSStringFromClass([self class]));
    BOOL isNotUIViewController=![self isMemberOfClass:[UIViewController class]];
    BOOL isNotNavgationController=![self isKindOfClass:[UINavigationController class]];
    BOOL isNotTabbarController=![self isKindOfClass:[UITabBarController class]];
    
    BOOL isChecked=isNotUIViewController&&isNotNavgationController&&isNotTabbarController;
    if (isChecked) {
        
//        [MobClick event:@"viewdidload" attributes:[NSDictionary dictionaryWithObject:NSStringFromClass([self class]) forKey:@"viewcontroller"]];
    }
    [self myViewDidLoad];
}

@end

@implementation UIImageView(SwizzleClasses)

+(void)load
{
    NSLog(@"UIImageView Class Load");
//    NSLog(@"swizzle sd_setImageWithURL");
//    [[self class]jr_swizzleMethod:@selector(sd_setImageWithURL:) withMethod:@selector(my_sd_setImageWithURL:) error:nil];
}

-(void)my_sd_setImageWithURL:(NSURL*)url
{
    NSString* urlstr=[url absoluteString];
    NSLog(@"load image: %@",urlstr);
//    NSString* suburl=[urlstr stringByReplacingOccurrencesOfString:[ZZUrlTool main] withString:@"main/"];
//    [MobClick event:@"loadimage" attributes:[NSDictionary dictionaryWithObject:suburl forKey:@"imageurl"]];
    [self my_sd_setImageWithURL:url];
}

@end

