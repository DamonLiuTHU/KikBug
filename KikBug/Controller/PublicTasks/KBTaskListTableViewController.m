//
//  KBTaskListTableViewController.m
//  KikBug
//
//  Created by DamonLiu on 15/8/6.
//  Copyright (c) 2015年 DamonLiu. All rights reserved.
//

#import "KBTaskListTableViewController.h"

#import "KBTaskDetailViewController.h"
#import "AFNetworking.h"
#import "KBTaskListModel.h"
#import "KBHttpManager.h"
#import "MBProgressHUD.h"
#import "KBUserHomeViewController.h"
#import "KBTaskCellTableViewCell.h"
#import "KBTaskListManager.h"

static NSString* identifier = @"kikbug";

@interface KBTaskListTableViewController ()
@property (strong, nonatomic) MBProgressHUD *hud;


@end

@implementation KBTaskListTableViewController{
    NSArray* dataSource;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
//    [self navigationLeftButton];
    [self.navigationController setNavigationBarHidden:NO];
    [self navigationRightButton];
    [self showLoadingView];
    [self loadData];
//    [self.tableView setRowHeight:80];
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [self.tableView registerClass:[KBTaskCellTableViewCell class] forCellReuseIdentifier:identifier];
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        // 进入刷新状态后会自动调用这个block
        [self loadData];
    }];
    [self setTitle:@"任务广场"];
}
-(void)close{
    [self dismissViewControllerAnimated:YES completion:nil];
}


-(void)navigationRightButton
{
//    UIBarButtonItem* myButton = [UIBarButtonItem new];
//    myButton.title = @"个人中心";
//    myButton.style = UIBarButtonItemStyleBordered;
//    myButton.target = self;
//    myButton.action = @selector(goToUserHome);
//    self.navigationItem.rightBarButtonItem = myButton;
}

-(void)navigationLeftButton
{
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"注销" style:UIBarButtonItemStylePlain target:self action:@selector(close)];
}

-(void)goToUserHome
{
    KBUserHomeViewController* vc = [KBUserHomeViewController new];
    [self.navigationController pushViewController:vc animated:YES];
}

-(void)loadData{
    
//    [KBHttpManager sendGetHttpReqeustWithUrl:GETURL(@"taskListUrl") Params:nil CallBack:^(id responseObject, NSError *error) {
//        if(responseObject && !error){
//            NSDictionary* dic = (NSDictionary*)responseObject;
//            NSArray* datas = dic[@"tasks"];
//            NSMutableArray* tmpArary = [NSMutableArray array];
//            for(id tmp in datas)
//            {
//                KBTaskListModel* model = [KBTaskListModel mj_objectWithKeyValues:tmp];
//                [tmpArary addObject:model];
//            }
//            
//            dataSource = tmpArary;
//            [self.tableView reloadData];
//            
//        }else{
//            [self showLoadingViewWithText:@"网络错误，请重新刷新"];
//        }
//        [self hideLoadingView];
//    }];
    
    [KBTaskListManager fetchPublicTasksWithCompletion:^(NSArray<KBTaskListModel *> *model, NSError *error) {
        [self.tableView.mj_header endRefreshing];
        if(model && !error){
            dataSource = model;
            [self.tableView reloadData];

        }else{
            [self showLoadingViewWithText:@"网络错误，请重新刷新"];
        }
        [self hideLoadingView];
    }];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    dataSource = nil;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
 
    // Return the number of rows in the section.
    return dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    KBTaskCellTableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:identifier forIndexPath:indexPath];
    if([cell isKindOfClass:[KBTaskCellTableViewCell class]]){
        [cell fillWithContent:dataSource[indexPath.row]];
    }
    return cell;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [KBTaskCellTableViewCell cellHeight];
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
//    KBTaskDetailViewController* detailVC = [[KBTaskDetailViewController alloc]initWithNibName:@"KBTaskDetailViewController" bundle:nil];
    [self showLoadingView];
    KBTaskDetailViewController *detailVC = (KBTaskDetailViewController*)[[HHRouter shared] matchController:TASK_DETAIL];
    [detailVC fillWithContent:dataSource[indexPath.row]];
    [self.navigationController pushViewController:detailVC animated:YES];
    [self hideLoadingView];
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
}


#pragma mark - Hud Methods

- (void)showLoadingView
{
    [self showLoadingViewWithText:TIP_LOADING];
}

- (void)showLoadingViewWithText:(NSString *)text
{
    if (!self.hud) {
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:[self hubShowInView] animated:YES];
        if (text) {
            hud.labelText = text;
        } else {
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

- (UIView *)hubShowInView
{
    UIView *inView;
    if (self.tableView) {
        inView = self.tableView;
    }
    else {
        inView = self.view;
    }
    return inView;
}


@end
