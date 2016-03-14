//
//  KBGroupDetailViewController.m
//  KikBug
//
//  Created by DamonLiu on 16/3/14.
//  Copyright © 2016年 DamonLiu. All rights reserved.
//

#import "KBGroupDetailModel.h"
#import "KBGroupDetailViewController.h"
#import "KBGroupManager.h"

@interface KBGroupDetailViewController ()
@property (strong, nonatomic) UILabel* groupNameHintLabel;
@property (strong, nonatomic) UILabel* groupNameLabel;
@property (strong, nonatomic) UILabel* createrNameHintLabel;
@property (strong, nonatomic) UILabel* createrNameLabel;
@property (strong, nonatomic) UILabel* createrContactHintLabel;
@property (strong, nonatomic) UILabel* createrContactLabel;
@property (strong, nonatomic) UIButton* joinBtn;
@property (copy,nonatomic) NSString *groupId;
@end

@implementation KBGroupDetailViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view setBackgroundColor:[UIColor whiteColor]];
    self.title = @"群组详情";
    self.groupId = self.params[@"groupId"];
    self.groupNameLabel = [UILabel new];
    self.groupNameHintLabel = [UILabel new];
    self.createrNameHintLabel = [UILabel new];
    self.createrNameLabel = [UILabel new];
    self.createrContactLabel = [UILabel new];
    self.createrContactHintLabel = [UILabel new];
    self.joinBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [self.joinBtn.layer setCornerRadius:5.0f];
    [self.joinBtn setBackgroundColor:THEME_COLOR];
    [self.joinBtn addTarget:self action:@selector(joinButtonPressed) forControlEvents:UIControlEventTouchUpInside];

    self.groupNameHintLabel.attributedText = [[NSAttributedString alloc] initWithString:@"群组名:" attributes:SUBTITLE_ATTRIBUTE];
    self.createrNameHintLabel.attributedText = [[NSAttributedString alloc] initWithString:@"创建者:" attributes:SUBTITLE_ATTRIBUTE];
    self.createrContactHintLabel.attributedText = [[NSAttributedString alloc] initWithString:@"创建者联系方式" attributes:SUBTITLE_ATTRIBUTE];
    [self.joinBtn setAttributedTitle:[[NSAttributedString alloc] initWithString:@"加入" attributes:BUTTON_TITLE_ATTRIBUTE] forState:UIControlStateNormal];

    [self.view addSubview:self.joinBtn];
    [self.view addSubview:self.groupNameLabel];
    [self.view addSubview:self.groupNameHintLabel];
    [self.view addSubview:self.createrNameHintLabel];
    [self.view addSubview:self.createrNameLabel];
    [self.view addSubview:self.createrContactLabel];
    [self.view addSubview:self.createrContactHintLabel];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)loadData
{
    [super loadData];
    WEAKSELF;
    [KBGroupManager fetchGroupDetailWithGroupId:self.groupId block:^(KBGroupDetailModel* model, NSError* error) {
        weakSelf.groupNameLabel.attributedText = [[NSAttributedString alloc] initWithString:NSSTRING_NOT_NIL(model.name) attributes:TITLE_ATTRIBUTE];
        weakSelf.createrContactLabel.attributedText = [[NSAttributedString alloc] initWithString:NSSTRING_NOT_NIL(model.contact) attributes:TITLE_ATTRIBUTE];
        weakSelf.createrNameLabel.attributedText = [[NSAttributedString alloc] initWithString:NSSTRING_NOT_NIL(model.operatorName) attributes:TITLE_ATTRIBUTE];
    }];
}

- (void)configConstrains
{
    [super configConstrains];

    //    [self.groupNameHintLabel autoPinEdgeToSuperviewMargin:ALEdgeTop];
    [self.groupNameHintLabel autoPinEdgeToSuperviewMargin:ALEdgeLeft];
    [self.groupNameHintLabel autoAlignAxis:ALAxisBaseline toSameAxisOfView:self.groupNameLabel];

    [self.groupNameLabel autoPinEdge:ALEdgeLeft toEdge:ALEdgeRight ofView:self.groupNameHintLabel withOffset:SMALL_MARGIN];
    [self.groupNameLabel autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:SMALL_MARGIN];

    [self.createrNameHintLabel autoPinEdgeToSuperviewMargin:ALEdgeLeft];
    [self.createrNameHintLabel autoAlignAxis:ALAxisBaseline toSameAxisOfView:self.createrNameLabel];

    [self.createrNameLabel autoPinEdge:ALEdgeLeft toEdge:ALEdgeRight ofView:self.createrNameHintLabel withOffset:SMALL_MARGIN];
    [self.createrNameLabel autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:self.groupNameLabel withOffset:MEDIUM_MARGIN];

    [self.createrContactHintLabel autoPinEdgeToSuperviewMargin:ALEdgeLeft];
    [self.createrContactHintLabel autoAlignAxis:ALAxisBaseline toSameAxisOfView:self.createrContactLabel];

    [self.createrContactLabel autoPinEdge:ALEdgeLeft toEdge:ALEdgeRight ofView:self.createrContactHintLabel withOffset:SMALL_MARGIN];
    [self.createrContactLabel autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:self.createrNameLabel withOffset:MEDIUM_MARGIN];

    [self.joinBtn autoSetDimensionsToSize:CGSizeMake(100, 60)];
    [self.joinBtn autoPinEdgeToSuperviewMargin:ALEdgeRight];
    [self.joinBtn autoAlignAxis:ALAxisHorizontal toSameAxisOfView:self.createrNameLabel];

    [super updateViewConstraints];
}

- (void)joinSuccess
{
    
}

- (void)showWrongPhraseAlertView
{
    WEAKSELF;
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"口令错误" message:@"" preferredStyle: UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [weakSelf joinButtonPressed];
    }]];
    [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        //点击按钮的响应事件；
    }]];
    [self presentViewController:alert animated:YES completion:nil];
}

#pragma mark - UI Event
- (void)joinButtonPressed
{
    //初始化提示框；
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"输入口令" message:@"" preferredStyle: UIAlertControllerStyleAlert];

    WEAKSELF;
    [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        //点击按钮的响应事件；
        NSString *phraseFromUser = [alert.textFields firstObject].text;
        if ([NSString isNilorEmpty:phraseFromUser]) {
            return;
        }
//        NSLog(@"%@",phraseFromUser);
        [KBGroupManager joinGroupWithGroupId:weakSelf.groupId phrase:phraseFromUser block:^(KBBaseModel *baseMode, NSError *error) {
            if (error) {
                [weakSelf showWrongPhraseAlertView];
            } else {
                [weakSelf joinSuccess];
            }
        }];
    }]];
    
    [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        //点击按钮的响应事件；
    }]];
    
    
    [alert addTextFieldWithConfigurationHandler:^(UITextField *textField) {
        // 可以在这里对textfield进行定制，例如改变背景色
//        textField.backgroundColor = [UIColor orangeColor];
        
    }];
    
    //弹出提示框；
    [self presentViewController:alert animated:true completion:nil];
}

@end
