//
//  KBNavigator.m
//  KikBug
//
//  Created by DamonLiu on 16/1/26.
//  Copyright © 2016年 DamonLiu. All rights reserved.
//

#import "KBNavigator.h"
#import "KBTaskListTableViewController.h"
#import "KBUserHomeViewController.h"

@interface KBNavigator ()<UITabBarControllerDelegate>
@property (nonatomic, strong) UITabBarController *tabBarController;

@property (nonatomic, strong) UINavigationController *presentNavController;
@end

@implementation KBNavigator

SINGLETON_IMPLEMENTION(KBNavigator, sharedNavigator);

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)showViewController:(UIViewController *)viewController {
    [self showViewController:viewController withShowType:KBUIManagerShowTypePush];
}

- (void)showViewController:(UIViewController *)viewController withShowType:(KBUIManagerShowType)showType {
    switch (showType) {
        case KBUIManagerShowTypePush:
        {
            [[self currentNavigationController] pushViewController:viewController animated:YES];
        }
            break;
        case KBUIManagerShowTypePresent:
        {
            self.presentNavController = [self navControllerWithRoot:viewController];
            self.presentNavController.navigationBarHidden = YES;
            [self.tabBarController presentViewController:self.presentNavController
                                                animated:YES
                                              completion:NULL];

        }
            break;
        default:
            break;
    }
}

#pragma mark - Utility

- (UINavigationController *)currentNavigationController
{
    return (UINavigationController *)[self.tabBarController selectedViewController];
}

- (UINavigationController *)navControllerWithRoot:(UIViewController *)controller
{
    NSParameterAssert(controller);
    UINavigationController *aNav = [[UINavigationController alloc] initWithRootViewController:controller];
    [aNav.navigationBar setBarTintColor:THEME_COLOR];
    [aNav.navigationBar setTintColor:[UIColor whiteColor]];
    [aNav.navigationBar setTitleTextAttributes:@{NSFontAttributeName:APP_FONT(17),
                                                 NSForegroundColorAttributeName:[UIColor whiteColor]}];
    [aNav.navigationBar setTranslucent:NO];
    aNav.navigationBarHidden = YES;
    
    return aNav;
}


- (void)showRootViewController {
    UITabBarController *tb = [[UITabBarController alloc]init];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    tb.delegate = self;
    tb.automaticallyAdjustsScrollViewInsets = NO;
    [UIApplication sharedApplication].keyWindow.rootViewController = tb;
    
    KBTaskListTableViewController *listVC = [[KBTaskListTableViewController alloc] init];
    UINavigationController* nav = [self navControllerWithRoot:listVC];
    [tb addChildViewController:nav];
    
    KBUserHomeViewController *userVC = [[KBUserHomeViewController alloc] initWithNibName:NSStringFromClass([KBUserHomeViewController class]) bundle:[NSBundle mainBundle]];
    userVC.title = @"个人中心";
    [tb addChildViewController:userVC];
    
    self.tabBarController = tb;
}



#pragma mark - 
#pragma mark - TabbarControllerDelegate


@end
