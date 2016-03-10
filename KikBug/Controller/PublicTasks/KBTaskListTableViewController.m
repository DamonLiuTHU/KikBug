//
//  KBTaskListTableViewController.m
//  KikBug
//
//  Created by DamonLiu on 15/8/6.
//  Copyright (c) 2015年 DamonLiu. All rights reserved.
//

#import "KBTaskListTableViewController.h"

#import "AFNetworking.h"
#import "KBHttpManager.h"
#import "KBTaskCellTableViewCell.h"
#import "KBTaskDetailViewController.h"
#import "KBTaskListManager.h"
#import "KBTaskListModel.h"
#import "KBUserHomeViewController.h"
#import "MBProgressHUD.h"

static NSString* identifier = @"kikbug";

@interface KBTaskListTableViewController ()
@property (strong, nonatomic) MBProgressHUD* hud;

@end

@implementation KBTaskListTableViewController {
    NSArray* dataSource;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.navigationController setNavigationBarHidden:NO];
    [self showLoadingView];
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [self.tableView registerClass:[KBTaskCellTableViewCell class] forCellReuseIdentifier:identifier];
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        // 进入刷新状态后会自动调用这个block
        [self loadData];
    }];

    [self setTitle:@"任务广场"];
    [self loadData];
}
- (void)close
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

//- (void)navigationLeftButton
//{
//    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"注销" style:UIBarButtonItemStylePlain target:self action:@selector(close)];
//}

//- (void)goToUserHome
//{
//    KBUserHomeViewController* vc = [KBUserHomeViewController new];
//    [self.navigationController pushViewController:vc animated:YES];
//}

- (void)loadData
{
    [KBTaskListManager fetchPublicTasksWithCompletion:^(NSArray<KBTaskListModel*>* model, NSError* error) {
        [self.tableView.mj_header endRefreshing];
        if (model && !error) {
            dataSource = model;
            [self.tableView reloadData];
        }
        else {
            [self showLoadingViewWithText:@"网络错误，请重新刷新"];
        }
        [self hideLoadingView];
    }];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    dataSource = nil;
    
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView*)tableView
{

    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView*)tableView numberOfRowsInSection:(NSInteger)section
{

    // Return the number of rows in the section.
    return dataSource.count;
}

- (UITableViewCell*)tableView:(UITableView*)tableView cellForRowAtIndexPath:(NSIndexPath*)indexPath
{
    KBTaskCellTableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:identifier forIndexPath:indexPath];
    if ([cell isKindOfClass:[KBTaskCellTableViewCell class]]) {
        [cell fillWithContent:dataSource[indexPath.row]];
    }
    return cell;
}

- (CGFloat)tableView:(UITableView*)tableView heightForRowAtIndexPath:(NSIndexPath*)indexPath
{
    return [KBTaskCellTableViewCell cellHeight];
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView*)tableView didSelectRowAtIndexPath:(NSIndexPath*)indexPath
{
    KBTaskDetailViewController* detailVC = (KBTaskDetailViewController*)[[HHRouter shared] matchController:TASK_DETAIL];
    [detailVC fillWithContent:dataSource[indexPath.row]];
    //    [self.navigationController pushViewController:detailVC animated:YES];
    [[KBNavigator sharedNavigator] showViewController:detailVC];
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
}

#pragma mark - Hud Methods

- (void)showLoadingView
{
    [self showLoadingViewWithText:TIP_LOADING];
}

- (void)showLoadingViewWithText:(NSString*)text
{
    if (!self.hud) {
        MBProgressHUD* hud = [MBProgressHUD showHUDAddedTo:[self hubShowInView] animated:YES];
        if (text) {
            hud.labelText = text;
        }
        else {
            hud.labelText = @"加载中...";
        }

        hud.removeFromSuperViewOnHide = YES;
        self.hud = hud;
    }
    [self hubShowInView].userInteractionEnabled = NO;
}

- (void)hideLoadingView
{
    [self.hud hide:YES];
    [self hubShowInView].userInteractionEnabled = YES;
    self.hud = nil;
}

- (UIView*)hubShowInView
{
    UIView* inView;
    if (self.tableView) {
        inView = self.tableView;
    }
    else {
        inView = self.view;
    }
    return inView;
}

#pragma mark - Auto Layout



@end
