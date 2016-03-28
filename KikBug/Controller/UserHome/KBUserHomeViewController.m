//
//  KBUserHomeViewController.m
//  KikBug
//
//  Created by DamonLiu on 15/11/10.
//  Copyright © 2015年 DamonLiu. All rights reserved.
//

#import "KBUserHomeViewController.h"

@interface KBUserHomeViewController ()
@property (strong,nonatomic) UIButton *loginButton;

@property (strong,nonatomic) UILabel *registerDate;
@property (strong,nonatomic) UILabel *credit;


@property (strong,nonatomic) UILabel *registerDateHint;
@property (strong,nonatomic) UILabel *creditHint;

@property (strong,nonatomic) UIButton *editBtn;

@end

@implementation KBUserHomeViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor whiteColor]];
    [self.navigationController setNavigationBarHidden:NO];

//    if (YES) {
//        KBViewController* loginVC = (KBViewController *)[[HHRouter shared] matchController:LOGIN_PAGE_NAME];
//        [[KBNavigator sharedNavigator] showViewController:loginVC withShowType:KBUIManagerShowTypePresent];
//    }
    
    self.loginButton = [UIButton new];
    [self.loginButton setBackgroundColor:THEME_COLOR];
    [self.loginButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.view addSubview:self.loginButton];
    [self.loginButton.layer setCornerRadius:5.0f];
    [self.loginButton setTitle:@"登录" forState:UIControlStateNormal];
    [self.loginButton addTarget:self action:@selector(showLoginButton) forControlEvents:UIControlEventTouchUpInside];
    
    
}

- (void)showLoginButton
{
    KBViewController* loginVC = (KBViewController *)[[HHRouter shared] matchController:LOGIN_PAGE_NAME];
    [[KBNavigator sharedNavigator] showViewController:loginVC withShowType:KBUIManagerShowTypePresent];
}

- (void)configConstrains
{
    [super configConstrains];
    [self.loginButton autoSetDimensionsToSize:CGSizeMake(200, 50)];
    [self.loginButton autoAlignAxisToSuperviewAxis:ALAxisVertical];
    [self.loginButton autoPinEdgeToSuperviewEdge:ALEdgeBottom withInset:BOTTOM_BAR_HEIGHT+10];
    [super updateViewConstraints];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];

}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
