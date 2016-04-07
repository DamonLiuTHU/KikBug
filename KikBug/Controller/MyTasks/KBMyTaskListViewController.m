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
//    [super loadData];
    WEAKSELF;
    [KBTaskListManager fetchMyTasksWithCompletion:^(NSArray<KBTaskListModel *> *model, NSError *error) {
        [self endRefreshing];
        [weakSelf hideLoadingView];
        if (model && !error) {
            weakSelf.dataSource = model;
            if (model.count > 0) {
                [weakSelf removeEmptyView];
                [weakSelf.tableView reloadData];
            } else {
                [weakSelf showEmptyViewWithText:@"您还没有添加任务,请到任务广场中添加"];
            }
        } else {
            [weakSelf showErrorView];
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
    UIViewController* detailVC = (KBTaskDetailViewController*)[[HHRouter shared] matchController:TASK_DETAIL];
    [detailVC setParams:@{@"taskId":self.dataSource[indexPath.row].taskId}];
    [UIManager showViewController:detailVC withShowType:KBUIManagerShowTypePush];
    [self hideLoadingView];
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
}
#pragma mark - Memory Management
- (void)didReceiveMemoryWarning
{
    self.dataSource = nil;
}
@end
