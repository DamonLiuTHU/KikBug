//
//  TaskListTableViewController.m
//  KikBug
//
//  Created by DamonLiu on 15/8/6.
//  Copyright (c) 2015年 DamonLiu. All rights reserved.
//

#import "TaskListTableViewController.h"
#import "TaskCellTableViewCell.h"
#import "TaskCellData.h"
#import "TaskDetailViewController.h"
@interface TaskListTableViewController ()



@end

@implementation TaskListTableViewController{
    NSArray* dataSource;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    [self loadData];
//    UIBarButtonItem* item = [[UIBarButtonItem alloc] initWithTitle:@"return" style:UIBarButtonItemStyleDone target:self action:@selector(close)];
//    self.navigationItem.leftBarButtonItem = item;
//    [self.navigationController.navigationBar setHidden:NO];
//    UINavigationController* nav = self.navigationController;
//    if(nav==nil){
//        NSLog(@"nil");
//    }
//    [self.tableView registerClass:[TaskCell class] forCellReuseIdentifier:identifier ];
    [self.tableView setRowHeight:100];
    UINib* cellnib = [UINib nibWithNibName:@"TaskCellTableViewCell" bundle:nil];
    [self.tableView registerNib:cellnib forCellReuseIdentifier:identifier];
}

-(void)close{
    
}


-(void)loadData{
    dataSource = [[NSMutableArray alloc]init];
//    TaskCell* test = [[TaskCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
//    TaskCell* test2 = [[TaskCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
//    NSMutableArray* tmp = [[NSMutableArray alloc]initWithObjects:test,test2, nil];
    UIImage* tmpImage = [UIImage imageNamed:@"google"];
    TaskCellData* data = [[TaskCellData alloc]initWithImage:tmpImage Introduction:@"this is a test introduction" URL:@"SignInMaster://"];
    TaskCellData* data2 = [[TaskCellData alloc]initWithImage:[UIImage imageNamed:@"twitter-1"] Introduction:@"twitter" URL:@"itms-apps://"];
    NSArray* tmp = @[data,data2];
    dataSource = tmp;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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

static NSString* identifier = @"kikbug";
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TaskCellTableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:identifier forIndexPath:indexPath];
    if([cell isKindOfClass:[TaskCellTableViewCell class]]){
        [cell fillWithContent:dataSource[indexPath.row]];
    }
    return cell;
}



#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    UINavigationController* nav = self.navigationController;
    TaskDetailViewController* detailVC = [[TaskDetailViewController alloc]initWithNibName:@"TaskDetailViewController" bundle:nil];
    [detailVC loadView]; //if you don't load it, the view's component will be nil.
    [detailVC viewDidLoad];
    [detailVC fillWithContent:dataSource[indexPath.row]];
    [nav pushViewController:detailVC animated:YES];
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


@end
