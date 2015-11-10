//
//  TaskDetailViewController.m
//  KikBug
//
//  Created by DamonLiu on 15/8/11.
//  Copyright (c) 2015年 DamonLiu. All rights reserved.
//

#import "TaskDetailViewController.h"
#import "KBTaskListModel.h"
#import "AFNetworking.h"
#import "KBTaskDetailModel.h"
#import "KBOnePixelLine.h"
#import "SDWebImageManager.h"
#import "KBHttpManager.h"



@interface TaskDetailViewController ()

@property (strong,nonatomic) KBTaskListModel* model;
@property (strong,nonatomic) KBTaskDetailModel* detailModel;
@property (weak, nonatomic) IBOutlet UITextView *taskDescription;

@property (weak, nonatomic) IBOutlet UILabel *taskIdLabel;
@property (weak, nonatomic) IBOutlet UILabel *appSizeLabel;
@property (weak, nonatomic) IBOutlet UILabel *categoryLabel;
@property (weak, nonatomic) IBOutlet UILabel *addDateLabel;
@property (weak, nonatomic) IBOutlet UILabel *dueDateLabel;
@property (weak, nonatomic) IBOutlet UIImageView *icon;

@end


@implementation TaskDetailViewController{
    __weak IBOutlet UIButton *jumpButton;
    NSURL* appUrl;
    CGContextRef ctx;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self configNavigationBar];
    UISwipeGestureRecognizer* rec = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(backToPreviousPage)];
    [rec setDirection:UISwipeGestureRecognizerDirectionRight];
    [self.contentView addGestureRecognizer:rec];
    [self loadData];
    
    KBOnePixelLine* line = [KBOnePixelLine new];
    [line setFrame:CGRectMake(8, self.taskDescription.y - 1 , SCREEN_WIDTH - 8*2, 1)];
    [self.view addSubview:line];
}

-(void)configNavigationBar
{
    UINavigationController* nav = (UINavigationController*)[[UIApplication sharedApplication].keyWindow rootViewController];
    [nav.navigationItem.leftBarButtonItem setTitle:@"返回任务列表"];
    self.title = self.model.taskName;
}

-(void)loadData
{
    if(self.model){
        WEAKSELF
        [KBHttpManager SendGetHttpReqeustWithUrl:GETURL(@"taskDetailUrl") Params:@{@"taskId":self.model.taskId} CallBack:^(id responseObject, NSError *error) {
            KBTaskDetailModel* model = [KBTaskDetailModel objectWithKeyValues:responseObject];
            weakSelf.detailModel = model;
            [weakSelf updateUIwithModel:model];
        }];
    }
}

-(void)updateUIwithModel:(KBTaskDetailModel*)model
{
    self.taskDescription.text = model.Description;
    self.addDateLabel.text = [NSString dateFromTimeStamp:model.addDate];
    self.dueDateLabel.text = [NSString dateFromTimeStamp:model.deadline];
    self.taskIdLabel.text = [NSString stringWithFormat:@"%ld",(long)model.taskId];
    self.appSizeLabel.text = model.appSize;
    self.categoryLabel.text = model.category;
    WEAKSELF
    [[SDWebImageManager sharedManager] downloadImageWithURL:[NSURL URLWithString:model.iconLocation] options:SDWebImageAvoidAutoSetImage progress:^(NSInteger receivedSize, NSInteger expectedSize) {
        //
    } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished, NSURL *imageURL) {
        //
        if(!error&&image){
            weakSelf.icon.image = image;
        }
    }];
}

-(void)backToPreviousPage{
//    [self dismissViewControllerAnimated:YES completion:nil];
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)fillWithContent:(KBTaskListModel *)idata{
    self.model = idata;
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)jumpToNextPage:(id)sender {
    if(appUrl!=nil){
        [[UIApplication sharedApplication] openURL:appUrl];
    }else{
//        [[UIApplication sharedApplication]]
    }
}

@end
