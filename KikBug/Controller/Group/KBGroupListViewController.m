//
//  KBGroupListViewController.m
//  KikBug
//
//  Created by DamonLiu on 16/1/8.
//  Copyright © 2016年 DamonLiu. All rights reserved.
//

#import "KBGroupListViewController.h"

@implementation KBGroupListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationController setNavigationBarHidden:NO];
}

- (void)configConstrains {
    [self.tableView autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsZero excludingEdge:ALEdgeBottom];
    [self.tableView autoPinEdgeToSuperviewEdge:ALEdgeBottom withInset:-BOTTOM_BAR_HEIGHT];
}

@end
