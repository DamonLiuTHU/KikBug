//
//  KBGroupSearchViewController.m
//  KikBug
//
//  Created by DamonLiu on 16/3/10.
//  Copyright © 2016年 DamonLiu. All rights reserved.
//

#import "KBGroupManager.h"
#import "KBGroupSearchModel.h"
#import "KBGroupSearchTableViewCell.h"
#import "KBGroupSearchViewController.h"

@interface KBGroupSearchViewController () <UISearchBarDelegate, UISearchControllerDelegate>
@property (strong, nonatomic) UISearchBar* searchBar;
@property (strong, nonatomic) UISearchController* searchController;
@property (strong, nonatomic) KBGroupSearchModel* model;
@end

@implementation KBGroupSearchViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view setBackgroundColor:[UIColor whiteColor]];
    self.title = @"搜索群组";
    self.searchBar = [UISearchBar new];
    self.searchBar.delegate = self;
    self.searchBar.placeholder = @"输入小组关键字";
    self.searchController = [UISearchController new];
    self.searchController.delegate = self;

    [self.view addSubview:self.searchBar];
}

- (void)loadData
{
    WEAKSELF;
    [KBGroupManager searchGroupWithKeyword:@"" block:^(KBGroupSearchModel* baseMode, NSError* error) {
        [weakSelf endRefreshing];
        weakSelf.model = baseMode;
        [weakSelf.tableView reloadData];
    }];
}

- (void)configTableView
{
    [super configTableView];
    //    [self.tableView registerClass:[KBGroupSearchTableViewCell class] forCellReuseIdentifier:[KBGroupSearchTableViewCell cellIdentifier]];
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleSingleLine];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self.searchBar becomeFirstResponder];
}

- (void)configConstrains
{
    [self.searchBar autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsZero excludingEdge:ALEdgeBottom];
    [self.tableView autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsZero excludingEdge:ALEdgeTop];
    [self.tableView autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:self.searchBar];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - SearchBar delegate
- (void)searchBar:(UISearchBar*)searchBar textDidChange:(NSString*)searchText
{
    //    NSLog(@"%@",searchText);
    WEAKSELF;
    [KBGroupManager searchGroupWithKeyword:searchText block:^(KBGroupSearchModel* baseMode, NSError* error) {
        weakSelf.model = baseMode;
        [weakSelf.tableView reloadData];
    }];
}

#pragma mark - table view
- (UITableViewCell*)tableView:(UITableView*)tableView cellForRowAtIndexPath:(NSIndexPath*)indexPath
{
    KBGroupSearchTableViewCell* cell = [KBGroupSearchTableViewCell cellForTableView:tableView];
    [cell bindModel:self.model.items[indexPath.row]];
    return cell;
}

- (CGFloat)tableView:(UITableView*)tableView heightForRowAtIndexPath:(NSIndexPath*)indexPath
{
    return [KBGroupSearchTableViewCell cellHeight];
}

- (NSInteger)tableView:(UITableView*)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.model.items.count;
}

/**
 *  弹出群组详情页面
 *
 *  @param tableView tableView description
 *  @param indexPath indexPath description
 */
- (void)tableView:(UITableView*)tableView didSelectRowAtIndexPath:(NSIndexPath*)indexPath
{
    NSString *params = [NSString stringWithFormat:@"/?groupId=%ld",(long)self.model.items[indexPath.row].groupId];
    UIViewController *vc = [[HHRouter shared] matchController:[GROUP_DETAIL_PAGE stringByAppendingString:params]];
    [[KBNavigator sharedNavigator] showViewController:vc];
}

@end
