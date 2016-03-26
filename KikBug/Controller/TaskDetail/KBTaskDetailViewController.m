//
//  KBTaskDetailViewController.m
//  KikBug
//
//  Created by DamonLiu on 15/8/11.
//  Copyright (c) 2015年 DamonLiu. All rights reserved.
//

#import "AFNetworking.h"
#import "DNImagePickerController.h"
#import "KBBaseModel.h"
#import "KBBugManager.h"
#import "KBBugReport.h"
#import "KBHttpManager.h"
#import "KBImageManager.h"
#import "KBOnePixelLine.h"
#import "KBReportData.h"
#import "KBReportManager.h"
#import "KBTaskDetailModel.h"
#import "KBTaskDetailViewController.h"
#import "KBTaskListModel.h"
#import "KBTaskManager.h"
#import "KBUserHomeViewController.h"
#import "MBProgressHUD.h"
#import "SDWebImageManager.h"
#import "UIImageView+RJLoader.h"
#import "UIImageView+WebCache.h"
#import "UIViewController+DNImagePicker.h"
#import "UIImageView+EaseUse.h"

@interface KBTaskDetailViewController ()

@property (strong, nonatomic) KBTaskListModel* model;
@property (strong, nonatomic) KBTaskDetailModel* detailModel;
@property (strong, nonatomic) MBProgressHUD* hud;

@property (strong, nonatomic) UITextView* taskDescription;
@property (strong, nonatomic) UILabel* taskDescriptionHint;
@property (strong, nonatomic) UILabel* taskIdLabel;
@property (strong, nonatomic) UILabel* taskIdLabelHint;
@property (strong, nonatomic) UILabel* appSizeLabel;
@property (strong, nonatomic) UILabel* appSizeLabelHint;
@property (strong, nonatomic) UILabel* categoryLabel;
@property (strong, nonatomic) UILabel* categoryLabelHint;
@property (strong, nonatomic) UILabel* addDateLabel;
@property (strong, nonatomic) UILabel* addDateLabelHint;
@property (strong, nonatomic) UILabel* dueDateLabel;
@property (strong, nonatomic) UILabel* dueDateLabelHint;
@property (strong, nonatomic) UIImageView* icon;
//@property (strong, nonatomic) UIButton* jumpButton;
@property (strong, nonatomic) UIButton* acceptTask;
@property (strong, nonatomic) KBOnePixelLine* line;

@property (strong, nonatomic) UIScrollView* scrollView;
@property (strong, nonatomic) UIView* containerView;
@property (strong, nonatomic) UIButton* goToMyReportsBtn; /**< 跳转到我的Bug报告页面 */
@property (strong, nonatomic) UIButton* addBugReportBtn;
@property (strong, nonatomic) UIButton* startTestTask;

@property (assign, nonatomic) BOOL isTaskAccepted;

@end

@implementation KBTaskDetailViewController {
    NSURL* appUrl;
    CGContextRef ctx;
}

- (instancetype)init
{
    if (self = [super init]) {
        [self createSubviews];
        self.isTaskAccepted = NO;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor whiteColor]];
    [self showLoadingView];
    //    [self createSubviews];
    [self configSubviews];
    [self configNavigationBar];
    UISwipeGestureRecognizer* rec = [[UISwipeGestureRecognizer alloc]
        initWithTarget:self
                action:@selector(backToPreviousPage)];
    [rec setDirection:UISwipeGestureRecognizerDirectionRight];
    [self.view addGestureRecognizer:rec];

    //    self.acceptTask.hidden = self.model.isAccepted;
    self.goToMyReportsBtn.hidden = !self.acceptTask.hidden;
    self.startTestTask.hidden = !self.acceptTask.hidden;

    [self addObserver:self forKeyPath:@"isTaskAccepted" options:NSKeyValueObservingOptionNew context:nil];
}

- (void)observeValueForKeyPath:(NSString*)keyPath ofObject:(id)object change:(NSDictionary<NSString*, id>*)change context:(void*)context
{
    //    self.acceptTask.hidden = self.isTaskAccepted;
    self.goToMyReportsBtn.hidden = !self.isTaskAccepted;
    self.startTestTask.hidden = !self.isTaskAccepted;
}

- (void)dealloc
{
    [self removeObserver:self forKeyPath:@"isTaskAccepted"];
}

- (void)createSubviews
{
    self.startTestTask = [UIButton new];
    self.taskDescription = [UITextView new];
    self.taskDescriptionHint = [UILabel new];
    self.taskIdLabelHint = [UILabel new];
    self.taskIdLabel = [UILabel new];
    self.appSizeLabel = [UILabel new];
    self.appSizeLabelHint = [UILabel new];
    self.categoryLabelHint = [UILabel new];
    self.categoryLabel = [UILabel new];
    self.addDateLabelHint = [UILabel new];
    self.addDateLabel = [UILabel new];
    self.dueDateLabelHint = [UILabel new];
    self.dueDateLabel = [UILabel new];
    self.icon = [UIImageView new];
    //    self.jumpButton = [UIButton new];
    self.acceptTask = [UIButton new];
    self.containerView = [UIView new];
    self.goToMyReportsBtn = [UIButton new];
    self.scrollView = [UIScrollView new];
}

- (void)configSubviews
{
    [self.startTestTask addTarget:self action:@selector(startTaskButtonPressed) forControlEvents:UIControlEventTouchUpInside];
    [self.goToMyReportsBtn addTarget:self action:@selector(checkMyReportsButtonPressed) forControlEvents:UIControlEventTouchUpInside];
    //    [self.jumpButton addTarget:self action:@selector(jumpToApp:) forControlEvents:UIControlEventTouchUpInside];
    [self.taskDescription setEditable:NO];
#if DEBUG
//    [self.taskDescription setBackgroundColor:[UIColor lightGrayColor]];
#endif
    [self.acceptTask
        setAttributedTitle:[[NSAttributedString alloc]
                               initWithString:@"接受任务"
                                   attributes:@{ NSFontAttributeName : APP_FONT(12),
                                       NSForegroundColorAttributeName : THEME_COLOR }]
                  forState:UIControlStateNormal];
    [self.acceptTask setBackgroundColor:[UIColor whiteColor]];
    self.acceptTask.layer.cornerRadius = 3.0f;
    [self.acceptTask addTarget:self action:@selector(acceptTaskButtonPressed) forControlEvents:UIControlEventTouchUpInside];

    //    [self.jumpButton
    //        setAttributedTitle:[[NSAttributedString alloc]
    //                               initWithString:@"jump"
    //                                   attributes:@{ NSFontAttributeName : APP_FONT(10),
    //                                       NSForegroundColorAttributeName : [UIColor whiteColor] }]
    //                  forState:UIControlStateNormal];
    //    [self.jumpButton setBackgroundColor:THEME_COLOR];
    //    self.jumpButton.layer.cornerRadius = 3.0f;
    self.line = [[KBOnePixelLine alloc] initWithFrame:CGRectZero];
    [self.line setLineColor:[UIColor grayColor]];

    [self.taskIdLabelHint setAttributedText:[[NSAttributedString alloc]
                                                initWithString:@"任务Id"
                                                    attributes:SUBTITLE_ATTRIBUTE]];
    [self.appSizeLabelHint
        setAttributedText:[[NSAttributedString alloc]
                              initWithString:@"分数"
                                  attributes:SUBTITLE_ATTRIBUTE]];
    [self.categoryLabelHint
        setAttributedText:[[NSAttributedString alloc]
                              initWithString:@"分类"
                                  attributes:SUBTITLE_ATTRIBUTE]];
    [self.addDateLabelHint
        setAttributedText:[[NSAttributedString alloc]
                              initWithString:@"添加日期"
                                  attributes:SUBTITLE_ATTRIBUTE]];
    [self.dueDateLabelHint
        setAttributedText:[[NSAttributedString alloc]
                              initWithString:@"到期日期"
                                  attributes:SUBTITLE_ATTRIBUTE]];

    [self.goToMyReportsBtn setAttributedTitle:[[NSAttributedString alloc]
                                                  initWithString:@"查看/修改Bug报告"
                                                      attributes:BUTTON_TITLE_ATTRIBUTE]
                                     forState:UIControlStateNormal];
    [self.goToMyReportsBtn setBackgroundColor:THEME_COLOR];
    [self.goToMyReportsBtn.layer setCornerRadius:5.0f];
    [self.startTestTask setBackgroundColor:THEME_COLOR];
    [self.startTestTask.layer setCornerRadius:5.0f];

    [self.startTestTask setAttributedTitle:[[NSAttributedString alloc]
                                               initWithString:@"开始测试"
                                                   attributes:BUTTON_TITLE_ATTRIBUTE]
                                  forState:UIControlStateNormal];

    [self.view addSubview:self.appSizeLabelHint];
    [self.view addSubview:self.appSizeLabel];
    [self.view addSubview:self.categoryLabelHint];
    [self.view addSubview:self.categoryLabel];
    [self.view addSubview:self.addDateLabelHint];
    [self.view addSubview:self.addDateLabel];
    [self.view addSubview:self.dueDateLabelHint];
    [self.view addSubview:self.dueDateLabel];
    [self.view addSubview:self.taskIdLabel];
    [self.view addSubview:self.taskIdLabelHint];
    [self.view addSubview:self.icon];
    //    [self.view addSubview:self.jumpButton];
    [self.view addSubview:self.line];
    [self.view addSubview:self.scrollView];
    [self.scrollView addSubview:self.containerView];
    [self.containerView addSubview:self.goToMyReportsBtn];
    [self.containerView addSubview:self.taskDescriptionHint];
    [self.containerView addSubview:self.taskDescription];
    [self.containerView addSubview:self.startTestTask];
}

- (void)configConstrains
{
    [self.icon autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:8];
    [self.icon autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:8];
    [self.icon autoSetDimension:ALDimensionWidth toSize:80];
    [self.icon autoSetDimension:ALDimensionHeight toSize:80];

    //    [self.jumpButton autoPinEdge:ALEdgeTop
    //                          toEdge:ALEdgeBottom
    //                          ofView:self.icon
    //                      withOffset:5.0f];
    //    [self.jumpButton autoAlignAxis:ALAxisVertical toSameAxisOfView:self.icon];
    //    [self.jumpButton autoSetDimensionsToSize:CGSizeMake(60, 20)];

    [self.taskIdLabelHint autoPinEdge:ALEdgeLeft
                               toEdge:ALEdgeRight
                               ofView:self.icon
                           withOffset:5.0f];
    [self.taskIdLabelHint autoPinEdge:ALEdgeTop
                               toEdge:ALEdgeTop
                               ofView:self.icon];

    [self.taskIdLabel autoPinEdge:ALEdgeLeft
                           toEdge:ALEdgeRight
                           ofView:self.taskIdLabelHint
                       withOffset:5.0f];
    [self.taskIdLabel autoPinEdge:ALEdgeBottom
                           toEdge:ALEdgeBottom
                           ofView:self.taskIdLabelHint];

    [self.appSizeLabelHint autoPinEdge:ALEdgeLeft
                                toEdge:ALEdgeRight
                                ofView:self.icon
                            withOffset:5.0f];

    [self.appSizeLabelHint autoPinEdge:ALEdgeTop
                                toEdge:ALEdgeBottom
                                ofView:self.taskIdLabelHint
                            withOffset:5];

    [self.appSizeLabel autoPinEdge:ALEdgeLeft
                            toEdge:ALEdgeRight
                            ofView:self.appSizeLabelHint
                        withOffset:5.0f];
    [self.appSizeLabel autoPinEdge:ALEdgeBottom
                            toEdge:ALEdgeBottom
                            ofView:self.appSizeLabelHint];

    [self.categoryLabelHint autoPinEdge:ALEdgeLeft
                                 toEdge:ALEdgeRight
                                 ofView:self.icon
                             withOffset:5.0f];
    [self.categoryLabelHint autoPinEdge:ALEdgeTop
                                 toEdge:ALEdgeBottom
                                 ofView:self.appSizeLabelHint
                             withOffset:5];

    [self.categoryLabel autoPinEdge:ALEdgeLeft
                             toEdge:ALEdgeRight
                             ofView:self.categoryLabelHint
                         withOffset:5.0f];
    [self.categoryLabel autoPinEdge:ALEdgeBottom
                             toEdge:ALEdgeBottom
                             ofView:self.categoryLabelHint];

    [self.addDateLabelHint autoPinEdge:ALEdgeLeft
                                toEdge:ALEdgeRight
                                ofView:self.icon
                            withOffset:5.0f];
    [self.addDateLabelHint autoPinEdge:ALEdgeTop
                                toEdge:ALEdgeBottom
                                ofView:self.categoryLabelHint
                            withOffset:5];

    [self.addDateLabel autoPinEdge:ALEdgeLeft
                            toEdge:ALEdgeRight
                            ofView:self.addDateLabelHint
                        withOffset:5.0f];
    [self.addDateLabel autoPinEdge:ALEdgeBottom
                            toEdge:ALEdgeBottom
                            ofView:self.addDateLabelHint];

    [self.dueDateLabelHint autoPinEdge:ALEdgeLeft
                                toEdge:ALEdgeRight
                                ofView:self.icon
                            withOffset:5.0f];
    [self.dueDateLabelHint autoPinEdge:ALEdgeTop
                                toEdge:ALEdgeBottom
                                ofView:self.addDateLabelHint
                            withOffset:5];

    [self.dueDateLabel autoPinEdge:ALEdgeLeft
                            toEdge:ALEdgeRight
                            ofView:self.dueDateLabelHint
                        withOffset:5.0f];
    [self.dueDateLabel autoPinEdge:ALEdgeBottom
                            toEdge:ALEdgeBottom
                            ofView:self.dueDateLabelHint];

    [self.taskDescriptionHint autoPinEdge:ALEdgeTop
                                   toEdge:ALEdgeBottom
                                   ofView:self.line];
    [self.taskDescriptionHint autoPinEdge:ALEdgeLeft
                                   toEdge:ALEdgeLeft
                                   ofView:self.icon];

    [self.line autoPinEdge:ALEdgeTop
                    toEdge:ALEdgeBottom
                    ofView:self.dueDateLabel
                withOffset:5.0f];

    [self.line autoPinEdge:ALEdgeLeft
                    toEdge:ALEdgeLeft
                    ofView:self.view
                withOffset:10];
    [self.line autoPinEdge:ALEdgeRight
                    toEdge:ALEdgeRight
                    ofView:self.view
                withOffset:-10];
    [self.line autoSetDimension:ALDimensionHeight toSize:1.0f];

    [self.scrollView
        autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsMake(
                                                   0, 10, BOTTOM_BAR_HEIGHT, 10)
                                 excludingEdge:ALEdgeTop];
    [self.scrollView autoPinEdge:ALEdgeTop
                          toEdge:ALEdgeBottom
                          ofView:self.line
                      withOffset:5.0f];

    [self.taskDescription autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsZero excludingEdge:ALEdgeBottom];

    [self.startTestTask autoSetDimensionsToSize:CGSizeMake(150, 40)];
    [self.goToMyReportsBtn autoSetDimensionsToSize:CGSizeMake(150, 40)];

    [self.goToMyReportsBtn autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:self.taskDescription withOffset:5.0f];
    [self.startTestTask autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:self.taskDescription withOffset:5.0f];

    [self.startTestTask autoAlignAxis:ALAxisVertical toSameAxisOfView:self.containerView withOffset:-80];
    [self.goToMyReportsBtn autoAlignAxis:ALAxisVertical toSameAxisOfView:self.containerView withOffset:+80];

    [self.containerView autoPinEdgesToSuperviewEdges];

    [self.containerView autoPinEdge:ALEdgeBottom toEdge:ALEdgeBottom ofView:self.goToMyReportsBtn withOffset:5.0f];

    [super updateViewConstraints];
}

- (void)configNavigationBar
{
    [self.navigationController setNavigationBarHidden:NO];
    self.title = self.model.taskName;
    [self navigationRightButton];
    [self navigationLeftButton];
}

- (void)viewDidDisappear:(BOOL)animated
{

}
- (void)navigationLeftButton
{
}
- (void)navigationRightButton
{
    [self.acceptTask setFrame:CGRectMake(0, 0, 60, 30)];
    UIBarButtonItem* item = [[UIBarButtonItem alloc] initWithCustomView:self.acceptTask];
    self.navigationItem.rightBarButtonItem = item;
}

- (void)goToUserHome
{
    KBUserHomeViewController* vc = [KBUserHomeViewController new];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)loadData
{
    if (self.model) {
        WEAKSELF;
        [KBTaskManager fetchTaskDetailInfoWithTaskId:self.model.taskId completion:^(KBTaskDetailModel* model, NSError* error) {
            weakSelf.detailModel = model;
            [weakSelf updateUIwithModel:model];
            [weakSelf hideLoadingView];
        }];
    }
}

- (void)updateUIwithModel:(KBTaskDetailModel*)model
{

    self.taskDescription.attributedText = [[NSAttributedString alloc]
        initWithString:model.taskdescription ? model.taskdescription : @""
            attributes:TITLE_ATTRIBUTE];

    CGFloat heightForTaskDesc = [model.taskdescription heightForString:model.taskdescription fontSize:14 andWidth:self.scrollView.width];
    [self.taskDescription autoSetDimensionsToSize:CGSizeMake(self.scrollView.width, heightForTaskDesc)];
    [self updateViewConstraints];

    self.addDateLabel.attributedText = [[NSAttributedString alloc]
        initWithString:[NSString dateFromTimeStamp:model.addDate]
            attributes:TITLE_ATTRIBUTE];
    self.dueDateLabel.attributedText = [[NSAttributedString alloc]
        initWithString:[NSString dateFromTimeStamp:model.deadline]
            attributes:TITLE_ATTRIBUTE];
    self.taskIdLabel.attributedText = [[NSAttributedString alloc]
        initWithString:[NSString stringWithFormat:@"%ld", (long)model.taskId]
            attributes:TITLE_ATTRIBUTE];
    self.appSizeLabel.attributedText =
        [[NSAttributedString alloc] initWithString:INT_TO_STIRNG(model.points)
                                        attributes:TITLE_ATTRIBUTE];
    self.categoryLabel.attributedText =
        [[NSAttributedString alloc] initWithString:NSSTRING_NOT_NIL(model.category)
                                        attributes:TITLE_ATTRIBUTE];
    [self.icon setImageWithUrl:model.iconLocation];
    [self markAcceptBtnAsAccepted:self.detailModel.hasTask];
}

- (void)backToPreviousPage
{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    self.model = nil;
    self.detailModel = nil;
}

/**
 *  用列表页的粗略信息填充DetailVC
 *
 *  @param idata 少部分信息
 */
- (void)fillWithContent:(KBTaskListModel*)idata
{
    self.model = idata;
}

- (void)markAcceptBtnAsAccepted:(BOOL)bol
{
    [self.acceptTask setEnabled:!bol];
    self.isTaskAccepted = bol;
    [self.acceptTask
        setAttributedTitle:[[NSAttributedString alloc]
                               initWithString:bol ? @"已接受" : @"接受"
                                   attributes:@{ NSFontAttributeName : APP_FONT(12),
                                       NSForegroundColorAttributeName : THEME_COLOR }]
                  forState:UIControlStateNormal];
}

- (void)showLoadingView
{
    [self showLoadingViewWithText:TIP_LOADING];
}

- (void)hideLoadingView
{
    [self.hud hide:YES];
    [self hubShowInView].userInteractionEnabled = YES;
    self.hud = nil;
}

- (UIView*)hubShowInView
{
    UIView* inView = self.view;
    return inView;
}

#pragma mark - UI Events

- (void)acceptTaskButtonPressed
{
    WEAKSELF;
    [KBTaskManager acceptTaskWithTaskId:self.model.taskId completion:^(KBBaseModel* model, NSError* error) {
        //        NSLog(model.message);
        if (!error) {
            [weakSelf showLoadingViewWithText:@"任务添加成功" withDuration:2.0f];
        }
        else {
            NSString* errormsg = [NSString stringWithFormat:@"%@ (%@)", model.message, INT_TO_STIRNG(model.status)];
            [weakSelf showAlertViewWithText:errormsg];
        }
    }];
}

- (void)startTaskButtonPressed
{
    [self jumpToApp:nil];
}

/**
 *  发出开始测试的Scheme
 *
 *  @param sender sender description
 */
- (void)jumpToApp:(id)sender
{
    NSString* host = @"Airvin";
    NSString* str = [NSString stringWithFormat:@"%@://?taskId=%ld", host, (long)self.detailModel.taskId];
    appUrl = [NSURL URLWithString:str];
    [[UIApplication sharedApplication] openURL:appUrl];
}

#pragma mark - UIEvent
- (void)checkMyReportsButtonPressed
{
    if ([KBReportManager getReportId] < 0) {
        //不允许用户填写bug报告 因为测试报告上传失败了。
    }
    [KBReportManager uploadTaskReport:[KBTaskReport fakeReport] withCompletion:^(KBBaseModel* model, NSError* error) {
        UIViewController* vc = [[HHRouter shared] matchController:MY_BUG_REPORT_LIST];
        [vc setParams:@{ @"taskId" : @(self.detailModel.taskId) }];
        [[KBNavigator sharedNavigator] showViewController:vc];
    }];
}
@end
