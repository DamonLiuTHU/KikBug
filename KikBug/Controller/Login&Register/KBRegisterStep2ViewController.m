//
//  KBRegisterStep2ViewController.m
//  KikBug
//
//  Created by DamonLiu on 16/3/19.
//  Copyright © 2016年 DamonLiu. All rights reserved.
//

#import "KBRegisterManager.h"
#import "KBRegisterStep2ViewController.h"
#import "KBLoginManager.h"

@interface KBRegisterStep2ViewController ()
@property (strong, nonatomic) UILabel* titleLabel;
@property (strong, nonatomic) UILabel* phoneHintLabel;
@property (strong, nonatomic) UILabel* phoneLabel;
@property (strong, nonatomic) UILabel* tokenHintLabel;
@property (strong, nonatomic) UITextField* tokenTextField;
@property (strong, nonatomic) UIButton* commitButton;
@property (strong, nonatomic) UILabel* tipLabel;
@property (strong, nonatomic) UITextField* pswField;
@property (strong, nonatomic) UILabel* pswHintLabel;
@end

@implementation KBRegisterStep2ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self configSubviews];
}

- (void)configSubviews
{
    NSDictionary* graytextAttr = @{ NSForegroundColorAttributeName : [UIColor grayColor],
        NSFontAttributeName : APP_FONT_SMALL };

    NSDictionary* blackTextAttr = @{ NSForegroundColorAttributeName : [UIColor blackColor],
        NSFontAttributeName : APP_FONT_SMALL };

    self.titleLabel = [UILabel new];
    [self.titleLabel setText:@"短信验证码已发送,请填写验证码"];
    [self.titleLabel setNumberOfLines:0];
    [self.titleLabel setFont:APP_FONT(30)];
    [self.view addSubview:self.titleLabel];

    self.phoneHintLabel = [UILabel new];
    self.phoneHintLabel.attributedText = [[NSAttributedString alloc] initWithString:@"手机号" attributes:graytextAttr];

    self.phoneLabel = [UILabel new];
    self.phoneLabel.attributedText = [[NSAttributedString alloc] initWithString:STORED_USER_PHONE attributes:graytextAttr];

    [self.view addSubview:self.phoneHintLabel];
    [self.view addSubview:self.phoneLabel];

    self.tokenHintLabel = [UILabel new];
    self.tokenHintLabel.attributedText = [[NSAttributedString alloc] initWithString:@"验证码" attributes:blackTextAttr];
    [self.view addSubview:self.tokenHintLabel];

    self.tokenTextField = [UITextField new];
    self.tokenTextField.placeholder = @"请输入验证码";
    self.tokenTextField.keyboardType = UIKeyboardTypeNumberPad;
    [self.view addSubview:self.tokenTextField];

    self.commitButton = [UIButton new];
    [self.commitButton setTitle:@"提交" forState:UIControlStateDisabled];
    [self.commitButton setTitle:@"提交" forState:UIControlStateNormal];
    [self.commitButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.commitButton.layer.cornerRadius = 5.0f;
    [self.view addSubview:self.commitButton];
    [self.commitButton setBackgroundColor:THEME_COLOR];
    [self.commitButton addTarget:self action:@selector(commitTokenButtonPressed) forControlEvents:UIControlEventTouchUpInside];

    self.tipLabel = [UILabel new];
    self.tipLabel.attributedText = [[NSAttributedString alloc] initWithString:@"短信验证码30min内有效" attributes:SUBTITLE_ATTRIBUTE];
    [self.view addSubview:self.tipLabel];

    self.pswHintLabel = [UILabel new];
    self.pswHintLabel.attributedText = [[NSAttributedString alloc] initWithString:@"新密码" attributes:blackTextAttr];
    [self.view addSubview:self.pswHintLabel];

    self.pswField = [UITextField new];
    self.pswField.placeholder = @"请设置新的密码";
    self.pswField.secureTextEntry = YES;
    [self.view addSubview:self.pswField];
}

- (void)configConstrains
{
    [self.titleLabel autoAlignAxisToSuperviewAxis:ALAxisVertical];
    [self.titleLabel autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:30.0f];
    [self.titleLabel autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:15.0f];
    [self.titleLabel autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:15.0f];
    [self.titleLabel setTextAlignment:NSTextAlignmentCenter];

    [self.phoneLabel autoAlignAxisToSuperviewAxis:ALAxisVertical];
    [self.phoneLabel autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:self.titleLabel withOffset:50.0f];

    [self.tokenTextField autoPinEdge:ALEdgeLeft toEdge:ALEdgeLeft ofView:self.phoneLabel];
    [self.tokenTextField autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:self.phoneLabel withOffset:25.0f];

    [self.phoneHintLabel autoPinEdge:ALEdgeRight toEdge:ALEdgeLeft ofView:self.phoneLabel withOffset:-43.0f];
    [self.phoneHintLabel autoAlignAxis:ALAxisBaseline toSameAxisOfView:self.phoneLabel];

    [self.tokenHintLabel autoPinEdge:ALEdgeLeft toEdge:ALEdgeLeft ofView:self.phoneHintLabel];
    [self.tokenHintLabel autoAlignAxis:ALAxisBaseline toSameAxisOfView:self.tokenTextField];

    [self.pswField autoPinEdge:ALEdgeLeft toEdge:ALEdgeLeft ofView:self.phoneLabel];
    [self.pswField autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:self.tokenTextField withOffset:25.0f];
    
    [self.pswHintLabel autoPinEdge:ALEdgeLeft toEdge:ALEdgeLeft ofView:self.phoneHintLabel];
    [self.pswHintLabel autoAlignAxis:ALAxisBaseline toSameAxisOfView:self.pswField];


    [self.commitButton autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:self.pswField withOffset:30.0f];
    [self.commitButton autoAlignAxisToSuperviewAxis:ALAxisVertical];
    [self.commitButton autoPinEdge:ALEdgeLeft toEdge:ALEdgeLeft ofView:self.view withOffset:15.0f];
    [self.commitButton autoPinEdge:ALEdgeRight toEdge:ALEdgeRight ofView:self.view withOffset:-15.0f];
    [self.commitButton autoSetDimension:ALDimensionHeight toSize:40.0f];

    [self.tipLabel autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:self.commitButton withOffset:20.0f];
    [self.tipLabel autoAlignAxisToSuperviewAxis:ALAxisVertical];

    [super updateViewConstraints];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)commitTokenButtonPressed
{
    WEAKSELF;
    [KBRegisterManager registerUser:STORED_USER_PHONE token:self.tokenTextField.text psw:self.pswField.text completion:^(KBBaseModel* model, NSError* error) {
        if (!error) {
//            [weakSelf dismissViewControllerAnimated:YES completion:^{
//                UIViewController *vc = [[KBNavigator sharedNavigator] topViewController];
//                [weakSelf showHudViewWithText:@"注册成功" inView:vc.view];
//            }];
            [KBLoginManager loginWithPhone:STORED_USER_PHONE password:weakSelf.pswField.text completion:^(KBLoginModel *model, NSError *error) {
                [UIManager showRootViewController];
            }];
        }
        else {
            [weakSelf showHudViewWithText:@"验证码错误,请重新填写"];
        }
    }];
}
@end
