//
//  KBViewController.m
//  KikBug
//
//  Created by DamonLiu on 16/1/26.
//  Copyright © 2016年 DamonLiu. All rights reserved.
//

#import "AppDelegate.h"
#import "KBViewController.h"
#import "MBProgressHUD.h"

@interface KBViewController ()
@property (strong, nonatomic) MBProgressHUD* hud;
@end

@implementation KBViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view setBackgroundColor:[UIColor whiteColor]];
//    [self configLeftBarButton];
}

- (void)viewWillAppear:(BOOL)animated
{
    [self configConstrains];
    [self loadData];
}

- (void)loadData
{
}

- (void)configLeftBarButton
{
    UIButton* btn = [UIButton new];
    btn.frame = CGRectMake(0, 0, 20, 18);
    [btn setTitle:@"left" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(showLeftDock) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem* item = [[UIBarButtonItem alloc] initWithCustomView:btn];
    self.navigationItem.leftBarButtonItem = item;
}

- (void)showLeftDock
{
//    AppDelegate* tempAppDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];

    if (UIManager.LeftSlideVC.closed) {
        [UIManager.LeftSlideVC openLeftView];
    }
    else {
        [UIManager.LeftSlideVC closeLeftView];
    }
}

- (void)configConstrains
{
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Hud Methods

- (void)hideLoadingView
{
    [self.hud hide:YES];
}

- (void)showLoadingView
{
    [self showLoadingViewWithText:TIP_LOADING];
}

- (void)showLoadingViewWithText:(NSString*)text
{
    [self showLoadingViewWithText:text withDuration:0.0f];
}

- (void)showLoadingViewWithText:(NSString*)text withDuration:(CGFloat)duration
{

    //    MBProgressHUD* hud =
    //        [MBProgressHUD showHUDAddedTo:[self hubShowInView] animated:YES];
    //
    //    if (text) {
    //        hud.labelText = text;
    //    }
    //    else {
    //        hud.labelText = @"加载中...";
    //    }
    //    [hud setMode:MBProgressHUDModeText];
    //    hud.removeFromSuperViewOnHide = YES;
    //    self.hud = hud;
    //    if (duration != 0.0f) {
    //        [self.hud hide:YES afterDelay:duration];
    //    }
    //    //    [self hubShowInView].userInteractionEnabled = NO;
    [self showHudViewWithText:text inView:[self hubShowInView] withDuration:duration];
}

/**
 *  一个Hud层，2s后消失
 *
 *  @param text 要显示的文字
 */
- (void)showHudViewWithText:(NSString*)text
{
    [self showLoadingViewWithText:text withDuration:2.0f];
}

- (void)showHudViewWithText:(NSString*)text inView:(UIView*)view
{
    CGFloat duration = 2.0f;
    [self showHudViewWithText:text inView:view withDuration:duration];
}

- (void)showHudViewWithText:(NSString*)text inView:(UIView*)view withDuration:(CGFloat)duration
{
    MBProgressHUD* hud =
        [MBProgressHUD showHUDAddedTo:view animated:YES];
    if (text) {
        hud.labelText = text;
    }
    else {
        hud.labelText = @"加载中...";
    }
    hud.removeFromSuperViewOnHide = YES;
    [hud setMode:MBProgressHUDModeText];
    self.hud = hud;
    if (duration != 0.0f) {
        [self.hud hide:YES afterDelay:duration];
    }
}

- (UIView*)hubShowInView
{
    //    UIView *inView;
    //    if (self.tableView) {
    //        inView = self.tableView;
    //    }
    //    else {
    //        inView = self.view;
    //    }
    return self.view;
}

- (void)showAlertViewWithTitle:(NSString *)title Text:(NSString*)text
{
    UIAlertController* alert = [UIAlertController alertControllerWithTitle:title message:text preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction* _Nonnull action){
    }]];
    [self.navigationController presentViewController:alert animated:YES completion:^{
        //
    }];
}

- (void)showAlertViewWithText:(NSString*)text
{
    UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"错误" message:text preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction* _Nonnull action){
                     }]];
    [self.navigationController presentViewController:alert animated:YES completion:^{
        //
    }];
}

@end
