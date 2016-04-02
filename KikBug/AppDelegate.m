//
//  AppDelegate.m
//  KikBug
//
//  Created by DamonLiu on 15/8/6.
//  Copyright (c) 2015年 DamonLiu. All rights reserved.
//

#import "AppDelegate.h"
#import "KBLoginManager.h"
#import "KBReportData.h"
#import "KBReportManager.h"
#import "KBTaskListTableViewController.h"
#import "NSString+EasyUse.h"
#import "KBLoginViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication*)application didFinishLaunchingWithOptions:(NSDictionary*)launchOptions
{
    // Override point for customization after application launch.
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor clearColor];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    [self.window makeKeyAndVisible];
    [KBNavigator registerLocalUrls];
    
    if ([KBLoginManager checkIfNeedLoginPage]) {
        KBLoginViewController *vc = [UIManager showLoginPageIfNeededWithSuccessCompletion:^{
            [[KBNavigator sharedNavigator] showRootViewController];    
        }];
        vc.navigationItem.leftBarButtonItem = nil;
    } else {
        [[KBNavigator sharedNavigator] showRootViewController];
    }
    
   //    if ([KBLoginManager checkIfNeedLoginPage]) {
//        KBViewController* loginVC = (KBViewController*)[[HHRouter shared] matchController:LOGIN_PAGE_NAME];
//        [[KBNavigator sharedNavigator] showViewController:loginVC withShowType:KBUIManagerShowTypePresent];
//    }

    return YES;
}

- (void)applicationWillResignActive:(UIApplication*)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication*)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication*)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication*)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication*)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

- (BOOL)application:(UIApplication*)application openURL:(NSURL*)url sourceApplication:(NSString*)sourceApplication annotation:(id)annotation
{
    NSLog(@"Calling Application Bundle ID: %@", sourceApplication);
    NSLog(@"URL scheme:%@", [url scheme]);
    NSLog(@"URL query: %@", [url query]);

    NSDictionary* params = [NSString splitQuery:[url query]];
    KBTaskReport* report = [KBTaskReport mj_objectWithKeyValues:params];
    [KBReportManager uploadTaskReport:report withCompletion:^(KBBaseModel* model, NSError* error) {
        if (!error) {
            //
        }
    }];
    return YES;
}

@end
