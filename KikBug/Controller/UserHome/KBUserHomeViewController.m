//
//  KBUserHomeViewController.m
//  KikBug
//
//  Created by DamonLiu on 15/11/10.
//  Copyright © 2015年 DamonLiu. All rights reserved.
//

#import "KBUserAvatarCell.h"
#import "KBUserHomeCellModel.h"
#import "KBUserHomeViewController.h"
#import "KBUserInfoManager.h"
#import "KBUserInfoModel.h"
#import "KBUserSimpleInfoCell.h"

@interface KBUserHomeViewController ()
@property (strong, nonatomic) UIButton* loginButton;

@property (strong, nonatomic) UILabel* registerDate;
@property (strong, nonatomic) UILabel* credit;

@property (strong, nonatomic) UILabel* registerDateHint;
@property (strong, nonatomic) UILabel* creditHint;

@property (strong, nonatomic) UIButton* editBtn;

@property (strong, nonatomic) NSArray<KBUserHomeCellModel*>* dataSource;

@end

@implementation KBUserHomeViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
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

- (void)configTableView
{
    [super configTableView];
    [self.tableView setBackgroundColor:[UIColor colorWithHexNumber:0xe3e3e3]];
}

- (void)loadData
{
    [KBUserInfoManager fetchUserInfoCompletion:^(KBUserInfoModel* model, NSError* error) {
        [self endRefreshing];

        NSMutableArray<KBUserHomeCellModel*>* array = [NSMutableArray array];

        [array addObject:[KBUserHomeCellModel emptyCellWithHeight:10.0f]];
        
        KBUserHomeCellModel* cellModel = [[KBUserHomeCellModel alloc] initWithClass:[KBUserAvatarCell class] cellHeight:80.0f model:model];
        [array addObject:cellModel];

        self.dataSource = array;
        [self.tableView reloadData];
    }];
}

- (void)showLoginButton
{
    KBViewController* loginVC = (KBViewController*)[[HHRouter shared] matchController:LOGIN_PAGE_NAME];
    [[KBNavigator sharedNavigator] showViewController:loginVC withShowType:KBUIManagerShowTypePresent];
}

- (void)configConstrains
{
    [super configConstrains];
    [self.loginButton autoSetDimensionsToSize:CGSizeMake(200, 50)];
    [self.loginButton autoAlignAxisToSuperviewAxis:ALAxisVertical];
    [self.loginButton autoPinEdgeToSuperviewEdge:ALEdgeBottom withInset:BOTTOM_BAR_HEIGHT + 10];
    [super updateViewConstraints];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Delegate for table view
- (NSInteger)tableView:(UITableView*)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataSource.count;
}

- (CGFloat)tableView:(UITableView*)tableView heightForRowAtIndexPath:(NSIndexPath*)indexPath
{
    return self.dataSource[indexPath.row].cellHeight;
}

- (UITableViewCell*)tableView:(UITableView*)tableView cellForRowAtIndexPath:(NSIndexPath*)indexPath
{
    Class cls = self.dataSource[indexPath.row].cellClass;
    id cell = [cls cellForTableView:tableView];
    if ([cell respondsToSelector:@selector(bindModel:)]) {
        [cell performSelector:@selector(bindModel:) withObject:self.dataSource[indexPath.row].model];
    }
    return cell;
}
@end
