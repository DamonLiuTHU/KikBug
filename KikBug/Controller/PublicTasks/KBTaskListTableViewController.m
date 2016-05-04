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
#import "KBBaseTableViewController.h"

static NSString* identifier = @"kikbug";

@interface KBTaskListTableViewController ()
@property (strong, nonatomic) MBProgressHUD* hud;
//@property (strong, nonatomic) NSArray<KBTaskListModel*>* dataSourceForGroup;
//@property (strong, nonatomic) NSArray<KBTaskListModel*>* dataSourceForPublicTasks;
@property (strong, nonatomic) NSArray<KBTaskListModel*>* dataSource;
@property (strong, nonatomic) NSMutableDictionary* dataSourceDic;
@property (strong, nonatomic) UISegmentedControl* segmentedControl;

@property (assign, nonatomic) BOOL isFirstLoadData;
@end

@implementation KBTaskListTableViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.isFirstLoadData = YES;
    [self.navigationController setNavigationBarHidden:NO];
    [self showLoadingView];
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [self.tableView registerClass:[KBTaskCellTableViewCell class] forCellReuseIdentifier:identifier];
//    self.tableView.backgroundColor = RGB(227, 227, 227);
    WEAKSELF;
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        // 进入刷新状态后会自动调用这个block
        [weakSelf loadData];
    }];
    
//    self.dataSourceForGroup = ;
//    self.dataSourceForPublicTasks = ;
    self.dataSourceDic = [NSMutableDictionary dictionary];

    [KBBaseTableViewController configHeaderStyle:self.tableView];
    [self setTitle:@"任务广场"];
    [self loadData];
    [self configSegmentControl];
    [self addObserver:self forKeyPath:@"self.segmentedControl.selectedSegmentIndex" options:NSKeyValueObservingOptionNew context:nil];

}

- (void)dealloc
{
    [self removeObserver:self forKeyPath:@"self.segmentedControl.selectedSegmentIndex"];
}

//- (void)viewWillAppear:(BOOL)animated{
//    [self.segmentedControl setValue:@(0) forKey:@"selectedSegmentIndex"];//应用KVO
//    [super viewWillAppear:animated];
//}


- (void)observeValueForKeyPath:(NSString*)keyPath ofObject:(id)object change:(NSDictionary<NSString*, id>*)change context:(void*)context
{
    NSInteger newIndex = self.segmentedControl.selectedSegmentIndex;
    self.dataSource = self.dataSourceDic[@(newIndex)];
    [self.tableView reloadData];
}

- (void)configSegmentControl
{
    NSArray* segmentedArray = [NSArray arrayWithObjects:@"公开任务", @"群组任务", nil];
    UISegmentedControl* segmentedControl = [[UISegmentedControl alloc] initWithItems:segmentedArray];
    segmentedControl.selectedSegmentIndex = 0;
    segmentedControl.tintColor = [UIColor whiteColor];
    [self.navigationItem setTitleView:segmentedControl];
    self.segmentedControl = segmentedControl;
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
    WEAKSELF;
    [KBTaskListManager fetchPublicTasksWithCompletion:^(NSArray<KBTaskListModel*>* model, NSError* error) {
        [weakSelf.tableView.mj_header endRefreshing];
        if (model && !error) {
            weakSelf.dataSourceDic[@(0)] = model;
            if (self.isFirstLoadData) {
                self.isFirstLoadData = NO;
                self.dataSource = model;
            }
            [weakSelf.tableView reloadData];
        }
        else {
            [weakSelf showLoadingViewWithText:@"网络错误，请重新刷新"];
        }
        [weakSelf hideLoadingView];
    }];
    
    [KBTaskListManager fetchTasksFromGroupWithCompletion:^(NSArray<KBTaskListModel *> *model, NSError *error) {
        if (model && !error) {
            weakSelf.dataSourceDic[@(1)] = model;
            [weakSelf.tableView reloadData];
        }
        else {
            [weakSelf showLoadingViewWithText:@"网络错误，请重新刷新"];
        }
        [weakSelf hideLoadingView];
    }];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
//    self.dataSourceForPublicTasks = nil;
//    self.dataSourceForGroup = nil;
//    self.dataSourceDic = nil;
//    self.dataSource = nil;
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

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView*)tableView didSelectRowAtIndexPath:(NSIndexPath*)indexPath
{
    UIViewController* detailVC = (KBTaskDetailViewController*)[[HHRouter shared] matchController:TASK_DETAIL];
    [detailVC setParams:@{@"taskId":self.dataSource[indexPath.row].taskId}];
    [UIManager showViewController:detailVC withShowType:KBUIManagerShowTypePush];
    [self hideLoadingView];
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
