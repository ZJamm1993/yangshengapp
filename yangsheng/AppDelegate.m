//
//  AppDelegate.m
//  yangsheng
//
//  Created by jam on 17/7/6.
//  Copyright © 2017年 jam. All rights reserved.
//

#import "AppDelegate.h"
#import "Reachability.h"
#import "UserModel.h"
#import "PersonalHttpTool.h"

@interface AppDelegate ()
{
    Reachability* reach;
}
@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    reach=[Reachability reachabilityForInternetConnection];
    [reach startNotifier];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(networkStateChange:) name:kReachabilityChangedNotification object:nil];
    
    [self autoLoginAgain];
//    [self performSelector:@selector(networkStateChange:) withObject:nil afterDelay:10];
    return YES;
}

-(void)networkStateChange:(NSNotification*)noti
{
    Reachability* r=reach;
    if (r.currentReachabilityStatus==NotReachable) {
        [MBProgressHUD showErrorMessage:@"似乎网络已断开"];
    }
    else if(r.currentReachabilityStatus==ReachableViaWiFi)
    {
        [MBProgressHUD showErrorMessage:@"已连接到WIFI"];
    }
    else if(r.currentReachabilityStatus==ReachableViaWWAN)
    {
        [MBProgressHUD showErrorMessage:@"已连接到移动网络"];
    }
}

-(void)autoLoginAgain
{
    UserModel* lastUser=[UserModel getUser];
    NSString* password=[UserModel getPassword];
    if (lastUser.mobile.length>0&&password.length>0) {
        [PersonalHttpTool loginUserWithMobile:lastUser.mobile password:password success:^(UserModel *user) {
            if (user.access_token.length>0) {
                [UserModel saveUser:user];
            }
            else
            {
                UIAlertController* alert=[UIAlertController alertControllerWithTitle:@"登录信息已过期" message:@"是否重新登录" preferredStyle:UIAlertControllerStyleAlert];
                [alert addAction:[UIAlertAction actionWithTitle:@"否" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                    [UserModel deleteUser];
                    [UserModel deletePassword];
                }]];
                [alert addAction:[UIAlertAction actionWithTitle:@"是" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                    UIViewController* root=self.window.rootViewController;
                    if ([root isKindOfClass:[UITabBarController class]]) {
                        UITabBarController* tab=(UITabBarController*)root;
                        UIViewController* selectedVc=tab.selectedViewController;
                        if ([selectedVc isKindOfClass:[UINavigationController class]]) {
                            UINavigationController* nav=(UINavigationController*)selectedVc;
                            UIViewController* lo=[[UIStoryboard storyboardWithName:@"Personal" bundle:nil]instantiateViewControllerWithIdentifier:@"PersonalLoginViewController"];
                            [nav pushViewController:lo animated:YES];
                        }
                    }
                }]];
                [self.window.rootViewController presentViewController:alert animated:YES completion:nil];
            }
        }];
    }
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
