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
#import "TaskCellTableViewCell.h"

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
    [self navigationRightButton];
    [self showLoadingView];
    [self loadData];
    [self.tableView setRowHeight:100];
    UINib* cellnib = [UINib nibWithNibName:@"TaskCellTableViewCell" bundle:nil];
    [self.tableView registerNib:cellnib forCellReuseIdentifier:identifier];
    [self setTitle:@"任务列表"];
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
    
    [KBHttpManager sendGetHttpReqeustWithUrl:GETURL(@"taskListUrl") Params:nil CallBack:^(id responseObject, NSError *error) {
        if(responseObject && !error){
            NSDictionary* dic = (NSDictionary*)responseObject;
            NSArray* datas = dic[@"tasks"];
            NSMutableArray* tmpArary = [NSMutableArray array];
            for(id tmp in datas)
            {
                KBTaskListModel* model = [KBTaskListModel mj_objectWithKeyValues:tmp];
                [tmpArary addObject:model];
            }
            
            dataSource = tmpArary;
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
    TaskCellTableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:identifier forIndexPath:indexPath];
    if([cell isKindOfClass:[TaskCellTableViewCell class]]){
        [cell fillWithContent:dataSource[indexPath.row]];
    }
    return cell;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
//    UINavigationController* nav = self.navigationController;

    KBTaskDetailViewController* detailVC = [[KBTaskDetailViewController alloc]initWithNibName:@"KBTaskDetailViewController" bundle:nil];
    [detailVC fillWithContent:dataSource[indexPath.row]];
//    [detailVC loadView]; //if you don't load it, the view's component will be nil.
//    [detailVC viewDidLoad];
//    if(!self.navigationController){
//        UINavigationController* nav = [[UINavigationController alloc] initWithRootViewController:self];
//        [nav pushViewController:detailVC animated:YES];
//    }else{
        [self.navigationController pushViewController:detailVC animated:YES];
//    [self.navigationController presentViewController:detailVC animated:YES completion:nil];
//    }
//    [nav pushViewController:detailVC animated:YES];
//    [self presentViewController:nav animated:YES completion:nil];
    
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/


//#pragma mark - Navigation
//
//// In a storyboard-based application, you will often want to do a little preparation before navigation
//- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
//    // Get the new view controller using [segue destinationViewController].
//    // Pass the selected object to the new view controller.
//}
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
