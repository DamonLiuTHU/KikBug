//
//  KBTaskReportListViewController.m
//  KikBug
//
//  Created by DamonLiu on 16/4/5.
//  Copyright © 2016年 DamonLiu. All rights reserved.
//

#import "KBTaskReportListViewController.h"
#import "KBReportManager.h"
#import "KBReportListCell.h"

@interface KBTaskReportListViewController ()
JSONSTIRNG taskId;
@property (strong,nonatomic) NSArray<KBReportListModel *> *dataSource;
@end

@implementation KBTaskReportListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"任务报告";
    
    //右上角的加号按钮
    UIButton* addButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 24, 24)];
    [addButton setImage:[UIImage imageNamed:@"Add_icon"] forState:UIControlStateNormal];
    [addButton addTarget:self action:@selector(addButtonPressed) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem* item = [[UIBarButtonItem alloc] initWithCustomView:addButton];
    self.navigationItem.rightBarButtonItem = item;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)configTableView
{
    [super configTableView];
    [self.tableView setBackgroundColor:LIGHT_GRAY_COLOR];
}

- (void)loadData
{
    WEAKSELF;
    [KBReportManager getAllUserReportForTaskId:self.taskId completion:^(NSArray<KBReportListModel *> *model, NSError *error) {
        [weakSelf endRefreshing];
        if (model) {
            weakSelf.dataSource = model;
            [weakSelf.tableView reloadData];
        }
    }];
}

#pragma mark - TableView Delegate

- (UITableViewCell*)tableView:(UITableView*)tableView cellForRowAtIndexPath:(NSIndexPath*)indexPath
{
    KBReportListCell* cell = [KBReportListCell cellForTableView:tableView];
    [cell bindModel:self.dataSource[indexPath.row]];
    return cell;
}

- (CGFloat)tableView:(UITableView*)tableView heightForRowAtIndexPath:(NSIndexPath*)indexPath
{
    return [KBReportListCell cellHeight];
}

- (NSInteger)tableView:(UITableView*)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataSource.count;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    KBReportListModel *report = self.dataSource[indexPath.row];
    
    //跳转到某个Report的Bug列表下面。
    UIViewController* vc = [[HHRouter shared] matchController:MY_BUG_REPORT_LIST];
    [vc setParams:@{ @"reportId" : @(report.reportId) }];
    [[KBNavigator sharedNavigator] showViewController:vc];

}

#pragma mark - UI Event

- (void)addButtonPressed
{
    UIViewController *vc = [[HHRouter shared] matchController:CREATE_REPORT_STEP_1];
    [vc setParams:@{@"taskId":self.taskId,
                    }];
    [UIManager showViewController:vc];
}

#pragma mark - Parse Param
- (void)setParams:(NSDictionary*)params
{
    self.taskId = params[@"taskId"];
}




@end
