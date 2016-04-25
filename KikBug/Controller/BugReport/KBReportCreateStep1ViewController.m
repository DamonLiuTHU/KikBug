//
//  KBReportCreateStep1ViewController.m
//  KikBug
//
//  Created by DamonLiu on 16/4/25.
//  Copyright © 2016年 DamonLiu. All rights reserved.
//

#import "KBReportCreateStep1ViewController.h"
#import "KBReportData.h"
#import "KBReportManager.h"

@interface KBReportCreateStep1ViewController ()
@property (copy, nonatomic) NSString* taskId;
@property (strong, nonatomic) UILabel* reportNameFieldHint;
@property (strong, nonatomic) UITapGestureRecognizer* tapBackgroundRec;
@property (strong, nonatomic) UITextField* reportNameField;
@property (strong, nonatomic) KBTaskReport* report;
@property (strong, nonatomic) UIButton* uploadButton;
@end

@implementation KBReportCreateStep1ViewController
- (void)viewDidLoad
{
    [self.view setBackgroundColor:[UIColor whiteColor]];
    [self createReport];

    self.tapBackgroundRec = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideKeyBoards)];
    [self.view addGestureRecognizer:self.tapBackgroundRec];
    self.uploadButton = [UIButton new];
    [self.uploadButton setAttributedTitle:[[NSAttributedString alloc]
                                              initWithString:@"确定创建"
                                                  attributes:BUTTON_TITLE_ATTRIBUTE]
                                 forState:UIControlStateNormal];
    [self.uploadButton setBackgroundColor:[KBUIConstant themeDarkColor]];
    [self.uploadButton.layer setCornerRadius:5.0f];
    [self.view addSubview:self.uploadButton];
    self.reportNameField = [self createTextFieldWithPlaceHolder:@"请输入报告名称"];
    [self.uploadButton addTarget:self action:@selector(uploadReport) forControlEvents:UIControlEventTouchUpInside];
}

- (void)createReport
{
    /**
     JSONINT taskId;
     JSONSTIRNG name;           //报告名称
     JSONSTIRNG logLocation;    //系统生成的
     JSONSTIRNG reportLocation; //
     JSONSTIRNG mobileBrand;//苹果
     JSONSTIRNG mobileModel;//iPhone 6s
     JSONSTIRNG mobileOs;   //
     //@property (assign,nonatomic) NSInteger bugFound;// 发现的bug数量 = 0
     JSONINT timeUsed; //以秒的形式
     JSONSTIRNG stepDescription; //整个报告的描述 @『等待补充』
     */
    
    self.report = [[KBTaskReport alloc] init];
    self.report.taskId = [self.taskId integerValue];
    self.report.mobileModel = [[UIDevice currentDevice] localizedModel];
    self.report.mobileBrand = [[UIDevice currentDevice] model];
    self.report.mobileOs = [NSString stringWithFormat:@"%@ %@", [[UIDevice currentDevice] systemName], [[UIDevice currentDevice] systemVersion]];
    self.report.timeUsed = 0;
    self.report.stepDescription = @"等待补充";
}

- (UITextField*)createTextFieldWithPlaceHolder:(NSString*)text
{
    UITextField* field = [UITextField new];
    field.placeholder = text;
    field.layer.borderColor = THEME_COLOR.CGColor;
    field.layer.borderWidth = 1.0f;
    field.layer.cornerRadius = 5.0f;

    UIView* view = [UIView new];
    field.leftView = view;
    [view autoSetDimension:ALDimensionWidth toSize:10.0f];
    field.leftViewMode = UITextFieldViewModeAlways;
    [self.view addSubview:field];
    return field;
}

- (void)configConstrains
{
    [super configConstrains];
    [self.reportNameField autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:10.0f];
    [self.reportNameField autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:20.0f];
    [self.reportNameField autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:10.f];
    [self.reportNameField autoSetDimension:ALDimensionHeight toSize:50.0f];
    [self.uploadButton autoSetDimension:ALDimensionHeight toSize:80.0f];
    [self.uploadButton autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsMake(0, 10, 10 + BOTTOM_BAR_HEIGHT, 10) excludingEdge:ALEdgeTop];
    
    [super updateViewConstraints];
}

- (void)hideKeyBoards
{
    [self.reportNameField resignFirstResponder];
}

#pragma mark - Parse Param
- (void)setParams:(NSDictionary*)params
{
    self.taskId = params[@"taskId"];
}

#pragma mark - UIEvent
- (void)uploadReport
{
    self.report.name = self.reportNameField.text;
    [self showLoadingView];
    WEAKSELF;
    [KBReportManager uploadTaskReport:self.report withCompletion:^(KBBaseModel *model, NSError *error) {
        [self hideLoadingView];
        if (!error) {
            [weakSelf showHudViewWithText:@"上传成功"];
        } else {
            [weakSelf showHudViewWithText:@"上传失败"];
        }
    }];
}
@end
