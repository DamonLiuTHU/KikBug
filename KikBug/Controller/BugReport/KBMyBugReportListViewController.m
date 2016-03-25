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

@interface KBMyBugReportListViewController () <DNImagePickerControllerDelegate>
@property (strong, nonatomic) NSArray<KBBugReport*>* dataSource;
@property (strong, nonatomic) NSString* taskId;
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
    [[KBBugManager sharedInstance] getAllBugReportsWithCompletion:^(NSArray<KBBugReport*>* reports) {
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
    return [KBBugListTableViewCell cellHeight];
}

- (NSInteger)tableView:(UITableView*)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataSource.count;
}

#pragma mark - UI Event
/**
 *  开始填写一份bug报告流程
 */
- (void)addButtonPressed
{
    DNImagePickerController* imagePicker = [[DNImagePickerController alloc] init];
    imagePicker.imagePickerDelegate = self;
    imagePicker.filterType = DNImagePickerFilterTypePhotos;
    //    [imagePicker showAlbumList];
    [self presentViewController:imagePicker animated:YES completion:^{
        //

    }];
}

#pragma mark - DNImagePickerControllerDelegate

- (void)dnImagePickerController:(DNImagePickerController*)imagePickerController sendImages:(NSArray<DNAsset*>*)imageAssets isFullImage:(BOOL)fullImage
{
    WEAKSELF;
    KBBugReport* report = [KBBugReport reportWithDNAssets:imageAssets taskId:self.taskId];
    [[KBBugManager sharedInstance] uploadBugReport:report withCompletion:^(KBBaseModel* model, NSError* error) {
        if (!error) {
            [weakSelf loadData];
        }
        else {
        }
    }];
}

- (void)dnImagePickerControllerDidCancel:(DNImagePickerController*)imagePicker
{
    [imagePicker dismissViewControllerAnimated:YES completion:^{

    }];
}
#pragma mark - Parse Param
- (void)setParams:(NSDictionary*)params
{
    self.taskId = params[@"taskId"];
}

@end
