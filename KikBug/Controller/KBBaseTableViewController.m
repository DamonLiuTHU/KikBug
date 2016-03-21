//
//  KBBaseTableViewController.m
//  KikBug
//
//  Created by DamonLiu on 16/3/9.
//  Copyright © 2016年 DamonLiu. All rights reserved.
//

#import "KBBaseTableViewController.h"

@interface KBBaseTableViewController ()

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
        header.stateLabel.font = APP_FONT(14);
        header.lastUpdatedTimeLabel.font = APP_FONT(14);

        // 设置颜色
        header.stateLabel.textColor = THEME_COLOR;
        header.lastUpdatedTimeLabel.textColor = THEME_COLOR;
    }
}

- (void)loadData
{
    [super loadData];
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

@end
