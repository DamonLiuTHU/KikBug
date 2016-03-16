//
//  KBViewController.h
//  KikBug
//
//  Created by DamonLiu on 16/1/26.
//  Copyright © 2016年 DamonLiu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface KBViewController : UIViewController

@property (strong, nonatomic) UITableView* tableView;

/**
 *  加载数据,只需要覆盖,不需要调用!
 */
- (void)loadData;

/**
 *  设置界面约束,只需要覆盖,不需要调用!
 */
- (void)configConstrains;

- (void)showLoadingView;
- (void)showLoadingViewWithText:(NSString*)text;
- (void)showLoadingViewWithText:(NSString*)text withDuration:(CGFloat)duration;
- (void)hideLoadingView;

- (void)showHudViewWithText:(NSString*)text;

- (void)showAlertViewWithText:(NSString*)text;
@end
