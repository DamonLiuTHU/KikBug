//
//  KBLoginViewController.m
//  KikBug
//
//  Created by DamonLiu on 16/1/26.
//  Copyright © 2016年 DamonLiu. All rights reserved.
//

#import "KBLoginViewController.h"
#import "KBLogoView.h"

@interface KBLoginViewController ()
@property (strong,nonatomic) KBLogoView *logo;
@end

@implementation KBLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.logo = [[KBLogoView alloc] init];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
