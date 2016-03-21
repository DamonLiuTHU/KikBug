//
//  KBRegisterViewController.m
//  KikBug
//
//  Created by DamonLiu on 16/3/19.
//  Copyright © 2016年 DamonLiu. All rights reserved.
//

#import "KBRegisterViewController.h"
#import "KBRegisterManager.h"
#import "KBOnePixelLine.h"

@interface KBRegisterViewController ()<UITextFieldDelegate>
@property (strong,nonatomic) UILabel *hintLabel;
@property (strong,nonatomic) UILabel *countryHintLabel;
@property (strong,nonatomic) UILabel *plus86HintLabel;
@property (strong,nonatomic) UITextField *phoneField;
@property (strong,nonatomic) UIButton *registerButton;
@property (strong,nonatomic) KBOnePixelLine *line;
@end

@implementation KBRegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view setBackgroundColor:[UIColor whiteColor]];
    [self configSubviews];
    [self configNavigationBar];
    [self.phoneField addObserver:self forKeyPath:@"text" options:NSKeyValueObservingOptionNew context:nil];
    UITapGestureRecognizer *rec = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapBackground)];
    [self.view addGestureRecognizer:rec];
}

- (void)tapBackground
{
    [self.phoneField resignFirstResponder];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context
{
//    [self.registerButton setHighlighted:![NSString isNilorEmpty:self.phoneField.text]];
}

- (void)configSubviews
{
    
    self.line = [[KBOnePixelLine alloc] initWithFrame:CGRectMake(0, 0, 0, 1)];
//    [self.line setLinePosition:GSLinePositionBottom];
    [self.line setLineColor:[UIColor lightGrayColor]];
    
    self.hintLabel = [UILabel new];
    self.hintLabel.text = @"请输入你的手机号";
    self.hintLabel.font = APP_FONT(25);
    
    self.plus86HintLabel = [UILabel new];
    self.plus86HintLabel.text = @"+86";
    self.plus86HintLabel.font = APP_FONT(APP_FONT_SIZE_LARGE);
    
    self.phoneField = [UITextField new];
    self.phoneField.keyboardType = UIKeyboardTypeNumberPad;
//    self.phoneField.clearsOnBeginEditing = YES;
    self.phoneField.clearButtonMode = UITextFieldViewModeWhileEditing;
    [self.phoneField setPlaceholder:@"请填写手机号码"];
    self.phoneField.delegate = self;
    
    self.registerButton = [UIButton new];
    [self.registerButton setBackgroundColor:THEME_COLOR];
    [self.registerButton addTarget:self action:@selector(registerButtonPressed) forControlEvents:UIControlEventTouchUpInside];
    
    NSAttributedString *attrStr = [[NSAttributedString alloc] initWithString:@"注册" attributes:BUTTON_TITLE_ATTRIBUTE];
    [self.registerButton setAttributedTitle:attrStr forState:UIControlStateHighlighted];
    
    NSAttributedString *grayStr = [[NSAttributedString alloc] initWithString:@"注册" attributes:BUTTON_TITLE_NOTENABLED_ATTRIBUTE];
    [self.registerButton setAttributedTitle:grayStr forState:UIControlStateNormal];
    self.registerButton.layer.cornerRadius = 5;

    
    [self.view addSubview:self.plus86HintLabel];
    [self.view addSubview:self.phoneField];
    [self.view addSubview:self.registerButton];
    [self.view addSubview:self.hintLabel];
    [self.view addSubview:self.line];
}

- (void)configConstrains
{
    [super configConstrains];
    
    [self.hintLabel autoAlignAxisToSuperviewAxis:ALAxisVertical];
    [self.hintLabel autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:50.0f];

    [self.plus86HintLabel autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:10.0f];
//    [self.plus86HintLabel autoPinEdgeToSuperviewEdge:ALEdgeTop  withInset:40.0f];
    [self.plus86HintLabel autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:self.hintLabel withOffset:50.0f];
    [self.plus86HintLabel autoSetDimension:ALDimensionWidth toSize:60.0f];
    
    [self.phoneField autoPinEdge:ALEdgeLeft toEdge:ALEdgeRight ofView:self.plus86HintLabel];
    [self.phoneField autoAlignAxis:ALAxisBaseline toSameAxisOfView:self.plus86HintLabel];
    [self.phoneField autoPinEdge:ALEdgeRight toEdge:ALEdgeRight ofView:self.view withOffset:-10.0f];
    
    [self.registerButton autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:10.0f];
    [self.registerButton autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:10.0f];
    [self.registerButton autoSetDimension:ALDimensionHeight toSize:40.0f];
    [self.registerButton autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:self.plus86HintLabel withOffset:30.0f];
    
    [self.line autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:10.0f];
    [self.line autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:10.0f];
    [self.line autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:self.phoneField withOffset:5.0f];
    [self.line autoSetDimension:ALDimensionHeight toSize:1.0f];
    
    [super updateViewConstraints];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)configNavigationBar
{
    UINavigationController* nav = self.navigationController;
    [nav setNavigationBarHidden:NO];
    
    UIButton* closeBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 60, 35)];
    [closeBtn addTarget:self action:@selector(closeLoginViewController) forControlEvents:UIControlEventTouchUpInside];
    [closeBtn setBackgroundColor:THEME_COLOR];
    closeBtn.titleLabel.font = APP_FONT(13);
    [closeBtn setTitle:@"关闭" forState:UIControlStateNormal];
    [closeBtn sizeToFit];
    
    
    
    UIBarButtonItem* backItem = [[UIBarButtonItem alloc] initWithCustomView:closeBtn];
    self.navigationItem.leftBarButtonItem = backItem;
}

- (void)closeLoginViewController
{
    [self dismissViewControllerAnimated:YES completion:^{
        //
    }];
}



#pragma mark - Textfield delegate
- (void)textFieldDidBeginEditing:(UITextField *)textField
{
//    [self.registerButton setHighlighted:YES];
}

//- (BOOL)textField:(UITextField*)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString*)string
//{
//    
//}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
//    [self.registerButton setHighlighted:![NSString isNilorEmpty:textField.text]];
}

#pragma mark - Register button pressed
- (void)registerButtonPressed
{
    [self tapBackground];
    WEAKSELF;
    [KBRegisterManager getToken:self.phoneField.text
                     completion:^(KBBaseModel *model, NSError *error) {
                         if (!error) {
                             [weakSelf showHudViewWithText:@"验证码发送成功"];
                         } else {
                             
                         }
                     }];
}

@end
