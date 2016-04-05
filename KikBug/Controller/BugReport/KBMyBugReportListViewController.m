//
//  MyBugReportListViewController.m
//  KikBug
//
//  Created by DamonLiu on 16/3/24.
//  Copyright © 2016年 DamonLiu. All rights reserved.
//

#import "DNImageFlowViewController.h"
#import "DNImagePickerController.h"
#import "KBBugListTableViewCell.h"
#import "KBBugManager.h"
#import "KBBugReport.h"
#import "KBMyBugReportListViewController.h"
#import "KBReportData.h"
#import "KBReportManager.h"
#import "DNPhotoBrowser.h"
#import "KBBugReportStep1ViewController.h"
#import "KBImageBrowser.h"

@interface KBMyBugReportListViewController () 
@property (strong, nonatomic) NSArray<KBBugReport*>* dataSource;
@property (strong, nonatomic) NSString* reportId;
@end

@implementation KBMyBugReportListViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    UIButton* addButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 24, 24)];
    [addButton setImage:[UIImage imageNamed:@"Add_icon"] forState:UIControlStateNormal];
    [addButton addTarget:self action:@selector(addButtonPressed) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem* item = [[UIBarButtonItem alloc] initWithCustomView:addButton];
    self.navigationItem.rightBarButtonItem = item;
}

- (void)configTableView
{
    [super configTableView];
    [self.tableView setBackgroundColor:GRAY_COLOR];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)loadData
{
    [[KBBugManager sharedInstance] getAllBugReportsForReport:self.reportId withCompletion:^(NSArray<KBBugReport *> *reports, NSError *error) {
        [self.tableView.mj_header endRefreshing];
        if (reports) {
            self.dataSource = reports;
            [self.tableView reloadData];
        }
    }];
}

#pragma mark - TableView Delegate

- (UITableViewCell*)tableView:(UITableView*)tableView cellForRowAtIndexPath:(NSIndexPath*)indexPath
{
    KBBugListTableViewCell* cell = [KBBugListTableViewCell cellForTableView:tableView];
    [cell bindModel:self.dataSource[indexPath.row]];
    return cell;
}

- (CGFloat)tableView:(UITableView*)tableView heightForRowAtIndexPath:(NSIndexPath*)indexPath
{
    return [KBBugListTableViewCell calculateCellHeightWithData:self.dataSource[indexPath.row].bugDescription];
}

- (NSInteger)tableView:(UITableView*)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataSource.count;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    KBBugReport *report = self.dataSource[indexPath.row];
    NSArray *imgUrlArray = [report.imgUrl componentsSeparatedByString:@";"];
    if (!imgUrlArray) {
        imgUrlArray = @[report.imgUrl];
    }
    KBImageBrowser *browser = [[KBImageBrowser alloc] initWithImageUrls:imgUrlArray];
    [UIManager showViewController:browser];
}

#pragma mark - UI Utility - Photo

/**
 *  预览部分
 *
 *  @param assets 图片
 *  @param page   第几页
 */
- (void)browserPhotoAsstes:(NSArray<DNAsset *> *)assets pageIndex:(NSInteger)page
{
    DNPhotoBrowser *browser = [[DNPhotoBrowser alloc] initWithPhotos:assets
                                                        currentIndex:page
                                                           fullImage:YES];
//    browser.delegate = self;
    browser.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:browser animated:YES];
}

#pragma mark - UI Event

/**
 *  开始填写一份bug报告流程
 */
- (void)addButtonPressed
{
    UIViewController *vc = [[HHRouter shared] matchController:ADD_BUG_STEP_1];
    [vc setParams:@{@"reportId":self.reportId,
                    @"taskId":@(self.dataSource.firstObject.taskId)}];
    [UIManager showViewController:vc];
}

#pragma mark - Parse Param
- (void)setParams:(NSDictionary*)params
{
    self.reportId = params[@"reportId"];
}

@end
