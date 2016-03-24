//
//  MyBugReportListViewController.m
//  KikBug
//
//  Created by DamonLiu on 16/3/24.
//  Copyright © 2016年 DamonLiu. All rights reserved.
//

#import "KBMyBugReportListViewController.h"
#import "KBBugListTableViewCell.h"
#import "KBBugReport.h"

@interface KBMyBugReportListViewController ()

@end

@implementation KBMyBugReportListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)configTableView
{
    [super configTableView];
    [self.tableView setBackgroundColor:GRAY_COLOR];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - TableView Delegate

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    KBBugReport *fake = [[KBBugReport alloc] init];
    fake.bugId = 100;
    fake.bugDescription = @"这是个bug这是个bug这是个bug这是个bug这是个bug这是个bug这是个bug这是个bug这是个bug这是个bug这是个bug这是个bug这是个bug这是个bug这是个bug这是个bug这是个bug这是个bug这是个bug";
    
    KBBugListTableViewCell *cell = [KBBugListTableViewCell cellForTableView:tableView];
    [cell bindModel:fake];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [KBBugListTableViewCell cellHeight];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 10;
}


@end
