//
//  KBTaskDetailViewController.m
//  KikBug
//
//  Created by DamonLiu on 15/8/11.
//  Copyright (c) 2015年 DamonLiu. All rights reserved.
//

#import "AFNetworking.h"
#import "KBBaseModel.h"
#import "KBHttpManager.h"
#import "KBOnePixelLine.h"
#import "KBTaskDetailModel.h"
#import "KBTaskDetailViewController.h"
#import "KBTaskListModel.h"
#import "KBTaskManager.h"
#import "KBUserHomeViewController.h"
#import "MBProgressHUD.h"
#import "SDWebImageManager.h"
#import "UIImageView+RJLoader.h"
#import "UIImageView+WebCache.h"

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
@property (strong, nonatomic) UIButton* jumpButton;
@property (strong, nonatomic) UIButton* acceptTask;
@property (strong, nonatomic) KBOnePixelLine* line;
@end

@implementation KBTaskDetailViewController {
    NSURL* appUrl;
    CGContextRef ctx;
}


- (instancetype)init {
    if (self = [super init]) {
        [self createSubviews];
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
    [self loadData];
}

- (void)viewWillAppear:(BOOL)animated {
    
}


- (void)createSubviews {
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
    self.jumpButton = [UIButton new];
    self.acceptTask = [UIButton new];
}

- (void)configSubviews
{
    [self.taskDescription setEditable:NO];
    [self.acceptTask
        setAttributedTitle:[[NSAttributedString alloc]
                               initWithString:@"接受任务"
                                   attributes:@{ NSFontAttributeName : APP_FONT(10),
                                       NSForegroundColorAttributeName : [UIColor whiteColor] }]
                  forState:UIControlStateNormal];
    [self.acceptTask setBackgroundColor:THEME_COLOR];
    self.acceptTask.layer.cornerRadius = 3.0f;
    [self.acceptTask addTarget:self action:@selector(acceptTaskButtonPressed) forControlEvents:UIControlEventTouchUpInside];

    [self.jumpButton
        setAttributedTitle:[[NSAttributedString alloc]
                               initWithString:@"jump"
                                   attributes:@{ NSFontAttributeName : APP_FONT(10),
                                       NSForegroundColorAttributeName : [UIColor whiteColor] }]
                  forState:UIControlStateNormal];
    [self.jumpButton setBackgroundColor:THEME_COLOR];
    self.jumpButton.layer.cornerRadius = 3.0f;
    self.line = [[KBOnePixelLine alloc] initWithFrame:CGRectZero];
    [self.line setLineColor:[UIColor grayColor]];
    //    [self.line setFrame:CGRectMake(8, self.taskDescription.y - 1 ,
    //    SCREEN_WIDTH - 8*2, 1)];

    [self.taskIdLabelHint setAttributedText:[[NSAttributedString alloc]
                                                initWithString:@"任务Id"
                                                    attributes:SUBTITLE_ATTRIBUTE]];
    [self.appSizeLabelHint
        setAttributedText:[[NSAttributedString alloc]
                              initWithString:@"App大小"
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

    [self.view addSubview:self.taskDescriptionHint];
    [self.view addSubview:self.taskDescription];
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
    [self.view addSubview:self.jumpButton];
    [self.view addSubview:self.line];
    [self.view addSubview:self.acceptTask];

    [self configConstrains];
}

- (void)configConstrains
{
    [self.icon autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:8];
    [self.icon autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:8];
    [self.icon autoSetDimension:ALDimensionWidth toSize:60];
    [self.icon autoSetDimension:ALDimensionHeight toSize:60];

    [self.jumpButton autoPinEdge:ALEdgeTop
                          toEdge:ALEdgeBottom
                          ofView:self.icon
                      withOffset:5.0f];
    [self.jumpButton autoAlignAxis:ALAxisVertical toSameAxisOfView:self.icon];
    [self.jumpButton autoSetDimensionsToSize:CGSizeMake(60, 20)];

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
                                   ofView:self.jumpButton];
    [self.taskDescriptionHint autoPinEdge:ALEdgeLeft
                                   toEdge:ALEdgeLeft
                                   ofView:self.icon];

    [self.line autoPinEdge:ALEdgeTop
                    toEdge:ALEdgeBottom
                    ofView:self.jumpButton
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

    [self.taskDescription
        autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsMake(
                                                   0, 10, BOTTOM_BAR_HEIGHT, 10)
                                 excludingEdge:ALEdgeTop];
    [self.taskDescription autoPinEdge:ALEdgeTop
                               toEdge:ALEdgeBottom
                               ofView:self.line
                           withOffset:5.0f];

    //    [self.acceptTask autoSetDimensionsToSize:CGSizeMake(60, 20)];
    //    [self.acceptTask autoAlignAxis:ALAxisHorizontal toSameAxisOfView:self.icon];
    //    [self.acceptTask autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:-5.0f];
    [self.acceptTask autoPinEdge:ALEdgeTop toEdge:ALEdgeTop ofView:self.view withOffset:5.0f];
    [self.acceptTask autoPinEdge:ALEdgeRight toEdge:ALEdgeRight ofView:self.view withOffset:-5.0f];
    [self.acceptTask autoPinEdge:ALEdgeBottom toEdge:ALEdgeTop ofView:self.line withOffset:-5.0f];
    [self.acceptTask autoMatchDimension:ALDimensionWidth toDimension:ALDimensionHeight ofView:self.acceptTask];

    [super updateViewConstraints];
}

- (void)configNavigationBar
{
    self.title = self.model.taskName;
    [self navigationRightButton];
}

- (void)navigationRightButton
{
    
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
    self.addDateLabel.attributedText = [[NSAttributedString alloc]
        initWithString:[NSString dateFromTimeStamp:model.addDate]
            attributes:TITLE_ATTRIBUTE];
    self.dueDateLabel.attributedText = [[NSAttributedString alloc]
        initWithString:[NSString dateFromTimeStamp:model.deadline]
            attributes:TITLE_ATTRIBUTE];
    ;
    self.taskIdLabel.attributedText = [[NSAttributedString alloc]
        initWithString:[NSString stringWithFormat:@"%ld", (long)model.taskId]
            attributes:TITLE_ATTRIBUTE];
    ;
    self.appSizeLabel.attributedText =
        [[NSAttributedString alloc] initWithString:NSSTRING_NOT_NIL(model.appSize)
                                        attributes:TITLE_ATTRIBUTE];
    ;
    self.categoryLabel.attributedText =
        [[NSAttributedString alloc] initWithString:NSSTRING_NOT_NIL(model.category)
                                        attributes:TITLE_ATTRIBUTE];
    WEAKSELF;
    //    [weakSelf.icon startLoaderWithTintColor:[UIColor blackColor]];
    [[SDWebImageManager sharedManager]
        downloadImageWithURL:[NSURL URLWithString:model.iconLocation]
        options:SDWebImageAvoidAutoSetImage
        progress:^(NSInteger receivedSize, NSInteger expectedSize) {
            //        CGFloat process =
            //        ((CGFloat)receivedSize/(CGFloat)expectedSize);
            //        NSLog(@"show progress");
            //        [weakSelf.icon updateImageDownloadProgress:process];
        }
        completed:^(UIImage* image, NSError* error, SDImageCacheType cacheType,
            BOOL finished, NSURL* imageURL) {
            //
            if (!error && image) {
                weakSelf.icon.image = image;
                //            [weakSelf.icon reveal];
            }
        }];
}

- (void)backToPreviousPage
{
    //    [self dismissViewControllerAnimated:YES completion:nil];
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    self.model = nil;
    self.detailModel = nil;
}
- (void)fillWithContent:(KBTaskListModel*)idata
{
    self.model = idata;
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little
preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (void)jumpToNextPage:(id)sender
{
    if (appUrl != nil) {
        [[UIApplication sharedApplication] openURL:appUrl];
    }
    else {
        //        [[UIApplication sharedApplication]]
    }
}

- (void)showLoadingView
{
    [self showLoadingViewWithText:TIP_LOADING];
}

- (void)showLoadingViewWithText:(NSString*)text
{
    if (!self.hud) {
        MBProgressHUD* hud =
            [MBProgressHUD showHUDAddedTo:[self hubShowInView] animated:YES];
        if (text) {
            hud.labelText = text;
        }
        else {
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

- (UIView*)hubShowInView
{
    UIView* inView = self.view;
    return inView;
}

- (void)acceptTaskButtonPressed
{
    [KBTaskManager acceptTaskWithTaskId:self.model.taskId completion:^(KBBaseModel* model, NSError* error) {
        NSLog(model.message);
    }];
}

@end
