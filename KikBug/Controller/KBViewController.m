//
//  KBViewController.m
//  KikBug
//
//  Created by DamonLiu on 16/1/26.
//  Copyright © 2016年 DamonLiu. All rights reserved.
//

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
    [self.view setBackgroundColor:[UIColor clearColor]];
}

- (void)viewWillAppear:(BOOL)animated
{
    [self configConstrains];
    [self loadData];
}

- (void)loadData
{
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
    if (!self.hud) {
        MBProgressHUD* hud =
            [MBProgressHUD showHUDAddedTo:[self hubShowInView] animated:YES];
        if (text) {
            hud.labelText = text;
        }
        else {
            hud.labelText = @"加载中...";
        }
        [hud setMode:MBProgressHUDModeText];
        hud.removeFromSuperViewOnHide = YES;
        self.hud = hud;
    }
    if (duration != 0.0f) {
        [self.hud hide:YES afterDelay:duration];
    }
//    [self hubShowInView].userInteractionEnabled = NO;
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
