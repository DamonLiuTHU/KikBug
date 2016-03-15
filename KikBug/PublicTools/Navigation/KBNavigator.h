//
//  KBNavigator.h
//  KikBug
//
//  Created by DamonLiu on 16/1/26.
//  Copyright © 2016年 DamonLiu. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger,KBUIManagerShowType){
    KBUIManagerShowTypePush = 0,
    KBUIManagerShowTypePresent,
};

@interface KBNavigator : UIViewController

SINGLETON_INTERFACE(KBNavigator, sharedNavigator);

- (void)showRootViewController;

//- (void)showViewControllerWithClass:(Class)cls;

//- (void)showViewControllerWithClass:(Class)cls param:(NSDictionary *)param;

//- (void)showViewControllerWithClass:(Class)cls param:(NSDictionary *)param needLogin:(BOOL)needLogin;

//- (void)showViewControllerWithName:(NSString *)name;

//- (void)showViewControllerWithName:(NSString *)name param:(NSDictionary *)param;

//- (void)showViewControllerWithName:(NSString *)name param:(NSDictionary *)param needLogin:(BOOL)needLogin;
+ (void)setNavigationBarStyle:(UINavigationController *)aNav;

- (void)showViewController:(UIViewController *)viewController;

- (void)showViewController:(UIViewController *)viewController withShowType:(KBUIManagerShowType)showType;

+ (void)registerLocalUrls;

+ (void)showLoginPage;

@end
