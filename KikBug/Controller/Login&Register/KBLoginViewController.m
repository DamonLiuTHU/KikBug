//
//  KBLoginViewController.m
//  KikBug
//
//  Created by DamonLiu on 16/1/26.
//  Copyright © 2016年 DamonLiu. All rights reserved.
//

#import "KBHttpManager.h"
#import "KBLoginManager.h"
#import "KBLoginViewController.h"
#import "KBLogoView.h"

@interface KBLoginViewController () <UITextFieldDelegate>
@property (strong, nonatomic) KBLogoView* logo;
@property (strong, nonatomic) UILabel* plus86Label;
@property (strong, nonatomic) UITextField* phoneNumber;
@property (strong, nonatomic) UIView* onepixleLine;
@property (strong, nonatomic) UILabel* pswLabel;
@property (strong, nonatomic) UITextField* pswFiled;
@property (strong, nonatomic) UIView* onepixleLine2;
@property (strong, nonatomic) UIButton* loginBtn;
@property (strong, nonatomic) UIButton* loginWithSMS;
@property (strong, nonatomic) UIButton* forgetPswBtn;
@property (strong, nonatomic) UITapGestureRecognizer* rec;
@end

@implementation KBLoginViewController

- (instancetype)init
{
    if (self = [super init]) {
        [self createSubviews];
    }
    return self;
}

- (void)createSubviews
{
    self.logo = [[KBLogoView alloc] init];
    self.plus86Label = [UILabel new];
    self.pswLabel = [UILabel new];
    self.onepixleLine = [[UIView alloc] init];
    self.onepixleLine2 = [[UIView alloc] init];
    self.loginBtn = [UIButton new];
    self.loginWithSMS = [UIButton new];
    self.forgetPswBtn = [UIButton new];

    self.phoneNumber = [UITextField new];
    self.pswFiled = [UITextField new];

    self.rec = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideKeyboards)];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.view addGestureRecognizer:self.rec];
    self.title = @"登录";
    self.view.backgroundColor = [UIColor whiteColor];

    [self setUpLabels];
    [self setUpLines];
    [self setUpBtns];
    [self setUpTextFileds];
    [self addSubviews];

    if ([KBLoginManager isUserLoggedIn]) {
        NSString* userPhone = [[NSUserDefaults standardUserDefaults] valueForKey:USER_PHONE];
        NSString* userEmail = [[NSUserDefaults standardUserDefaults] valueForKey:USER_EMAIL];
        [self.phoneNumber setText:userPhone ? userPhone : userEmail];
    }
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self configNavigationBar];
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
- (void)hideKeyboards
{
    [self.phoneNumber resignFirstResponder];
    [self.pswFiled resignFirstResponder];
}

- (void)setUpLabels
{

    self.plus86Label.text = @"+86";
    [self.plus86Label sizeToFit];

    self.pswLabel.text = @"密码";
    [self.pswLabel sizeToFit];
}

- (void)setUpLines
{

    [self.onepixleLine autoSetDimension:ALDimensionWidth toSize:self.view.width - 2 * MEDIUM_MARGIN];
    [self.onepixleLine autoSetDimension:ALDimensionHeight toSize:1];
    [self.onepixleLine setBackgroundColor:THEME_COLOR];

    [self.onepixleLine2 autoSetDimension:ALDimensionWidth toSize:self.view.width - 2 * MEDIUM_MARGIN];
    [self.onepixleLine2 autoSetDimension:ALDimensionHeight toSize:1];
    [self.onepixleLine2 setBackgroundColor:THEME_COLOR];
}

- (void)setUpBtns
{

    //    [self.loginBtn setTitle:@"登录" forState:UIControlStateNormal];
    NSAttributedString* loginBtnStr = [[NSAttributedString alloc] initWithString:@"登录" attributes:@{ NSForegroundColorAttributeName : [UIColor whiteColor], NSFontAttributeName : APP_FONT(17) }];
    [self.loginBtn setAttributedTitle:loginBtnStr forState:UIControlStateNormal];
    [self.loginBtn setBackgroundColor:THEME_COLOR];
    [self.loginBtn autoSetDimension:ALDimensionWidth toSize:self.view.width - 2 * MEDIUM_MARGIN];
    [self.loginBtn autoSetDimension:ALDimensionHeight toSize:35];
    [self.loginBtn addTarget:self action:@selector(loginButtonPressed) forControlEvents:UIControlEventTouchUpInside];
    self.loginBtn.layer.cornerRadius = 5;

    NSAttributedString* loginWithSMSStr = [[NSAttributedString alloc] initWithString:@"通过短信登录" attributes:@{ NSFontAttributeName : APP_FONT(11), NSForegroundColorAttributeName : THEME_COLOR }];
    [self.loginWithSMS setAttributedTitle:loginWithSMSStr forState:UIControlStateNormal];
    [self.loginWithSMS setTitleColor:THEME_COLOR forState:UIControlStateNormal];

    NSAttributedString* forgetPswBtnStr = [[NSAttributedString alloc] initWithString:@"忘记密码?" attributes:@{ NSFontAttributeName : APP_FONT(11), NSForegroundColorAttributeName : THEME_COLOR }];
    [self.forgetPswBtn setAttributedTitle:forgetPswBtnStr forState:UIControlStateNormal];
    [self.forgetPswBtn setTitleColor:THEME_COLOR forState:UIControlStateNormal];
}

- (void)setUpTextFileds
{
    self.phoneNumber.placeholder = @"手机号/邮箱";
    self.phoneNumber.delegate = self;
    self.phoneNumber.keyboardType = UIKeyboardTypeEmailAddress; //设置键盘类型为默认的
    self.phoneNumber.returnKeyType = UIReturnKeyDone;
    self.phoneNumber.font = APP_FONT(16);
    self.phoneNumber.keyboardAppearance = UIKeyboardAppearanceDefault;

    self.pswFiled.placeholder = @"填写密码";
    self.pswFiled.secureTextEntry = YES;
    self.pswFiled.delegate = self;
    self.pswFiled.keyboardType = UIKeyboardTypeDefault;
    self.pswFiled.returnKeyType = UIReturnKeyDone;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    [textField resignFirstResponder];
    
    return YES;
}

//- (BOOL)textField:(UITextField*)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString*)string
//{
//    return [self validateNumber:string];
//}

//只允许输入数字
//- (BOOL)validateNumber:(NSString*)number
//{
//    BOOL res = YES;
//    NSCharacterSet* tmpSet = [NSCharacterSet characterSetWithCharactersInString:@"0123456789"];
//    int i = 0;
//    while (i < number.length) {
//        NSString* string = [number substringWithRange:NSMakeRange(i, 1)];
//        NSRange range = [string rangeOfCharacterFromSet:tmpSet];
//        if (range.length == 0) {
//            res = NO;
//            break;
//        }
//        i++;
//    }
//    return res;
//}

//检查是否为手机号的方法
//- (BOOL)checkPhoneNumInput:(NSString*)phoneStr
//{
//    NSString* photoRange = @"^1(3[0-9]|4[0-9]|5[0-9]|7[0-9]|8[0-9])\\d{8}$"; //正则表达式
//    NSPredicate* regexMobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", photoRange];
//    BOOL result = [regexMobile evaluateWithObject:phoneStr];
//    if (result) {
//        return YES;
//    }
//    else {
//        return NO;
//    }
//}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)addSubviews
{
    [self.view addSubview:self.logo];
    [self.view addSubview:self.plus86Label];
    [self.view addSubview:self.phoneNumber];
    [self.view addSubview:self.onepixleLine];
    [self.view addSubview:self.pswLabel];
    [self.view addSubview:self.pswFiled];
    [self.view addSubview:self.onepixleLine2];
    [self.view addSubview:self.loginBtn];
    [self.view addSubview:self.loginWithSMS];
    [self.view addSubview:self.forgetPswBtn];
}

- (void)configConstrains
{
//    [self.phoneNumber autoSetDimension:ALDimensionWidth toSize:300];
    [self.phoneNumber autoSetDimension:ALDimensionHeight toSize:self.plus86Label.height];

//    [self.pswFiled autoSetDimension:ALDimensionWidth toSize:300];
    //    [self.pswFiled autoSetDimension:ALDimensionHeight toSize:LARGE_MARGIN];

    [self.logo autoAlignAxisToSuperviewMarginAxis:ALAxisVertical];
    [self.logo autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:20];

    [self.plus86Label autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:23];
    [self.plus86Label autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:self.logo withOffset:23];
    [self.plus86Label setContentHuggingPriority:UILayoutPriorityDefaultHigh forAxis:UILayoutConstraintAxisHorizontal];
    
    [self.phoneNumber autoPinEdge:ALEdgeLeft toEdge:ALEdgeRight ofView:self.plus86Label withOffset:23];
    [self.phoneNumber autoAlignAxis:ALAxisBaseline toSameAxisOfView:self.self.plus86Label];
    [self.phoneNumber autoPinEdge:ALEdgeRight toEdge:ALEdgeRight ofView:self.view withOffset:-MEDIUM_MARGIN];
    
    [self.onepixleLine autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:self.phoneNumber withOffset:5];
    [self.onepixleLine autoAlignAxisToSuperviewAxis:ALAxisVertical];
    
    [self.pswLabel autoPinEdge:ALEdgeLeft toEdge:ALEdgeLeft ofView:self.plus86Label];
    [self.pswLabel autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:self.plus86Label withOffset:LARGE_MARGIN];
    [self.pswLabel autoPinEdge:ALEdgeRight toEdge:ALEdgeRight ofView:self.plus86Label];

    [self.pswFiled autoPinEdge:ALEdgeLeft toEdge:ALEdgeRight ofView:self.pswLabel withOffset:23];
    [self.pswFiled autoAlignAxis:ALAxisBaseline toSameAxisOfView:self.pswLabel];
    [self.pswFiled autoPinEdge:ALEdgeRight toEdge:ALEdgeRight ofView:self.view withOffset:-MEDIUM_MARGIN];
    
    [self.onepixleLine2 autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:self.pswFiled withOffset:5];
    [self.onepixleLine2 autoAlignAxisToSuperviewAxis:ALAxisVertical];
    
//    [self.pswFiled autoSetDimensionsToSize:self.phoneNumber.size];
//    [self.pswFiled autoPinEdge:ALEdgeRight toEdge:ALEdgeRight ofView:self.onepixleLine2];

    [self.loginBtn autoAlignAxisToSuperviewAxis:ALAxisVertical];
    [self.loginBtn autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:self.onepixleLine2 withOffset:60];

    [self.loginWithSMS autoAlignAxisToSuperviewAxis:ALAxisVertical];
    [self.loginWithSMS autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:self.loginBtn withOffset:SMALL_MARGIN];

    [self.forgetPswBtn autoAlignAxisToSuperviewAxis:ALAxisVertical];
    [self.forgetPswBtn autoPinEdgeToSuperviewEdge:ALEdgeBottom withInset:5];

    [self updateViewConstraints];
}

#pragma mark - LoginBtn Action
- (void)loginButtonPressed
{
    WEAKSELF;
    [KBLoginManager loginWithPhone:self.phoneNumber.text password:self.pswFiled.text completion:^(KBLoginModel* model, NSError* error) {
        if (error) {
            UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:@"登录失败" message:@"" delegate:weakSelf cancelButtonTitle:nil otherButtonTitles:@"ok", nil];
            [alertView show];
        }
        else {
            UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:@"登录成功" message:model.session delegate:weakSelf cancelButtonTitle:nil otherButtonTitles:@"ok", nil];
            [alertView show];
            [weakSelf dismissViewControllerAnimated:YES completion:nil];
        }
    }];
}

@end
