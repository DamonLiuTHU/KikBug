//
//  KBNavigator.h
//  KikBug
//
//  Created by DamonLiu on 16/1/26.
//  Copyright © 2016年 DamonLiu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface KBNavigator : UIViewController

SINGLETON_INTERFACE(KBNavigator, sharedNavigator);

- (void)showViewControllerWithClass:(Class)cls;

- (void)showViewControllerWithClass:(Class)cls param:(NSDictionary *)param;

- (void)showViewControllerWithClass:(Class)cls param:(NSDictionary *)param needLogin:(BOOL)needLogin;

- (void)showViewControllerWithName:(NSString *)name;

- (void)showViewControllerWithName:(NSString *)name param:(NSDictionary *)param;

- (void)showViewControllerWithName:(NSString *)name param:(NSDictionary *)param needLogin:(BOOL)needLogin;

- (void)showViewController:(UIViewController *)viewController;

@end
