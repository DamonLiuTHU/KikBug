//
//  KBBaseTableViewController.m
//  KikBug
//
//  Created by DamonLiu on 16/3/9.
//  Copyright © 2016年 DamonLiu. All rights reserved.
//

#import "KBBaseTableViewController.h"
#import "KBEmptyView.h"
#import "KBUIConstant.h"

@interface KBBaseTableViewController ()
@property (strong,nonatomic) KBEmptyView *emptyView;
@end

@implementation KBBaseTableViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self configTableView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/**
 *  覆盖这个方法，在方法内初始化tableview等，不需要子类自己调用。
 */
- (void)configTableView
{
    self.tableView = [UITableView new];
    //    self.tableView.backgroundColor = RGB(227, 227, 227);
    //    [self.tableView setBackgroundColor:[UIColor lightGrayColor]];
    [self.tableView setBackgroundColor:[UIColor whiteColor]];
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    WEAKSELF;
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [weakSelf loadData];
    }];
    [KBBaseTableViewController configHeaderStyle:self.tableView];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    [self.view addSubview:self.tableView];
}

/**
 *  设置头部的文字样式
 */
+ (void)configHeaderStyle:(UITableView*)tableView
{
    if ([tableView.mj_header isKindOfClass:[MJRefreshStateHeader class]]) {
        MJRefreshStateHeader* header = (MJRefreshStateHeader*)tableView.mj_header;
        // 设置字体
        header.stateLabel.font = APP_FONT(12);
        header.lastUpdatedTimeLabel.font = APP_FONT(10);

        // 设置颜色
        header.stateLabel.textColor = [KBUIConstant themeDarkColor];
        header.lastUpdatedTimeLabel.textColor = [KBUIConstant themeDarkColor];
    }
}

- (void)configConstrains
{
    [super configConstrains];
    [self.tableView autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsZero];
}

- (void)loadData
{
    [super loadData];
    [self removeEmptyView];
    [self.tableView.mj_header endRefreshing];
}

- (void)endRefreshing
{
    [self.tableView.mj_header endRefreshing];
}

#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView*)tableView numberOfRowsInSection:(NSInteger)section
{
    return 0;
}

- (UITableViewCell*)tableView:(UITableView*)tableView cellForRowAtIndexPath:(NSIndexPath*)indexPath
{
    return nil;
}

#pragma mark - Empty View
- (void)showEmptyViewWithText:(NSString *)text
{
    if (!self.emptyView) {
        self.emptyView = [KBEmptyView new];
        self.emptyView.tipText = text;
        WEAKSELF;
        self.emptyView.block = ^(){
            [weakSelf loadData];
        };
    }
    if ([self.view.subviews containsObject:self.emptyView]) {
        [self.view bringSubviewToFront:self.emptyView];
    } else {
        [self.view addSubview:self.emptyView];
        [self.emptyView autoPinEdgesToSuperviewEdges];
    }
}

- (void)showEmptyView
{
    if (!self.emptyView) {
        self.emptyView = [KBEmptyView new];
        self.emptyView.tipText = @"没有找到可以展示的数据";
        WEAKSELF;
        self.emptyView.block = ^(){
            [weakSelf loadData];
        };
    }
    if ([self.view.subviews containsObject:self.emptyView]) {
        [self.view bringSubviewToFront:self.emptyView];
    } else {
        [self.view addSubview:self.emptyView];
        [self.emptyView autoPinEdgesToSuperviewEdges];
    }
}

- (void)removeEmptyView
{
    if (self.emptyView) {
        [self.emptyView removeFromSuperview];
    }
}

- (void)showErrorView
{
    if (!self.emptyView) {
        self.emptyView = [KBEmptyView new];
        WEAKSELF;
        self.emptyView.block = ^(){
            [weakSelf loadData];
        };
    }
    if ([self.view.subviews containsObject:self.emptyView]) {
        [self.view bringSubviewToFront:self.emptyView];
    } else {
        [self.view addSubview:self.emptyView];
        [self.emptyView autoPinEdgesToSuperviewEdges];
    }
}

@end
