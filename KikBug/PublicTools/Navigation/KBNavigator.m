//
//  KBNavigator.m
//  KikBug
//
//  Created by DamonLiu on 16/1/26.
//  Copyright © 2016年 DamonLiu. All rights reserved.
//

#import "KBNavigator.h"

@interface KBNavigator ()

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
    if (!viewController) {
        return;
    }
    
    
}

@end
