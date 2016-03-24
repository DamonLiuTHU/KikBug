//
//  KBMyTaskListViewController.m
//  KikBug
//
//  Created by DamonLiu on 16/1/8.
//  Copyright © 2016年 DamonLiu. All rights reserved.
//

#import "KBHttpManager.h"
#import "KBMyTaskListViewController.h"
#import "KBTaskCellTableViewCell.h"
#import "KBTaskDetailViewController.h"
#import "KBTaskListModel.h"
#import "KBTaskListManager.h"
#import "MJExtension.h"

@interface KBMyTaskListViewController () <UITableViewDelegate, UITableViewDataSource>
@property (strong, nonatomic) NSArray<KBTaskListModel*>* dataSource;
@end

@implementation KBMyTaskListViewController

static NSString* identifier = @"KBMyTaskListViewController";

- (void)viewDidLoad
{
    [super viewDidLoad];
//    [self setTitle:@"我的任务"];
    [self.view setBackgroundColor:[UIColor whiteColor]];
    [self.navigationController setNavigationBarHidden:NO];

//    self.dataSourceForMyTasks = [NSArray array];
    self.dataSource = [NSArray array];
}


- (void)loadData
{
    [self showLoadingView];
    WEAKSELF;
    [KBTaskListManager fetchMyTasksWithCompletion:^(NSArray<KBTaskListModel *> *model, NSError *error) {
        [weakSelf.tableView.mj_header endRefreshing];
        [weakSelf hideLoadingView];
        if (model && !error) {
            weakSelf.dataSource = model;
            [weakSelf.tableView reloadData];
        } else {
            [weakSelf showLoadingViewWithText:@"网络错误，请重新刷新"];
        }
    }];
}

- (void)configTableView
{
    [super configTableView];
    [self.tableView registerClass:[KBTaskCellTableViewCell class] forCellReuseIdentifier:identifier];
}

#pragma mark - TableView Delegate DataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView*)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView*)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataSource.count;
}

- (UITableViewCell*)tableView:(UITableView*)tableView cellForRowAtIndexPath:(NSIndexPath*)indexPath
{
    KBTaskCellTableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:identifier forIndexPath:indexPath];
    if ([cell isKindOfClass:[KBTaskCellTableViewCell class]]) {
        [cell fillWithContent:self.dataSource[indexPath.row]];
    }
    return cell;
}

- (CGFloat)tableView:(UITableView*)tableView heightForRowAtIndexPath:(NSIndexPath*)indexPath
{
    return [KBTaskCellTableViewCell cellHeight];
}

- (void)tableView:(UITableView*)tableView didSelectRowAtIndexPath:(NSIndexPath*)indexPath
{
    KBTaskDetailViewController* detailVC = (KBTaskDetailViewController*)[[HHRouter shared] matchController:TASK_DETAIL];
    [detailVC fillWithContent:self.dataSource[indexPath.row]];
    [self.navigationController pushViewController:detailVC animated:YES];
    [self hideLoadingView];
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
}
#pragma mark - Memory Management
- (void)didReceiveMemoryWarning
{
    self.dataSource = nil;
}
@end
