//
//  KBGroupListViewController.m
//  KikBug
//
//  Created by DamonLiu on 16/1/8.
//  Copyright © 2016年 DamonLiu. All rights reserved.
//

#import "KBGroupListViewController.h"
#import "KBGroupTableViewCell.h"
#import "KBGroupManager.h"

@implementation KBGroupListViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.navigationController setNavigationBarHidden:NO];

    UIButton* addButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 24, 24)];
    [addButton setImage:[UIImage imageNamed:@"Add_icon"] forState:UIControlStateNormal];
    [addButton addTarget:self action:@selector(addButtonPressed) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem* item = [[UIBarButtonItem alloc] initWithCustomView:addButton];
    self.navigationItem.rightBarButtonItem = item;
}

- (void)loadData
{
//    [KBGroupManager get]
}

- (void)configTableView {
    [super configTableView];
    self.tableView.backgroundColor = RGB(227, 227, 227);
}

- (void)configConstrains
{
    [self.tableView autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsZero];
}

- (NSInteger)tableView:(UITableView*)tableView numberOfRowsInSection:(NSInteger)section
{
    return 20;
}

- (UITableViewCell*)tableView:(UITableView*)tableView cellForRowAtIndexPath:(NSIndexPath*)indexPath
{
    KBGroupTableViewCell *cell = [KBGroupTableViewCell cellForTableView:tableView];
    [cell bindModel:nil];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [KBGroupTableViewCell calculateCellHeightWithData:nil];
}

#pragma mark - UI Event
- (void)addButtonPressed
{
    UIViewController *vc = [[HHRouter shared] matchController:SEARCH_GROUP_PAGE_URL];
    [[KBNavigator sharedNavigator] showViewController:vc];
}

@end
