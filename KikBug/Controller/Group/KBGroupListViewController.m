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
#import "KBGroupSearchModel.h"

@interface KBGroupListViewController ()
@property (strong,nonatomic) KBGroupSearchModel *model;
@end

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
//    [self showLoadingView];
    WEAKSELF;
    [KBGroupManager fetchMyGroupsWithBlock:^(KBGroupSearchModel *baseMode, NSError *error) {
//        [weakSelf hideLoadingView];
        [weakSelf endRefreshing];
        if (!error) {
            weakSelf.model = baseMode;
            [weakSelf.tableView reloadData];
            if (baseMode.items && baseMode.items.count == 0){
                [weakSelf showEmptyViewWithText:@"你还没有加入任何群组,点击加号立即加入群组!"];
            } else {
                [weakSelf removeEmptyView];
            }
        } else {
            
        }
    }];
}

- (void)configTableView {
    [super configTableView];
    [self.tableView setBackgroundColor:[UIColor colorWithHexNumber:0xe3e3e3]];
}

- (void)configConstrains
{
    [self.tableView autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsZero];
}


#pragma mark - Table Delegate
- (NSInteger)tableView:(UITableView*)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.model.items.count;
}

- (UITableViewCell*)tableView:(UITableView*)tableView cellForRowAtIndexPath:(NSIndexPath*)indexPath
{
    KBGroupTableViewCell *cell = [KBGroupTableViewCell cellForTableView:tableView];
    [cell bindModel:self.model.items[indexPath.row]];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [KBGroupTableViewCell calculateCellHeightWithData:nil];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    KBGroupSearchItem *item = self.model.items[indexPath.row];
    NSString *url = GROUP_TASKS;
    UIViewController *vc = [[HHRouter shared] matchController:url];
    [vc setParams:@{@"groupId":@(item.groupId)}];
    [[KBNavigator sharedNavigator] showViewController:vc];
}

#pragma mark - UI Event
- (void)addButtonPressed
{
    UIViewController *vc = [[HHRouter shared] matchController:SEARCH_GROUP_PAGE_URL];
    [[KBNavigator sharedNavigator] showViewController:vc];
}

@end
