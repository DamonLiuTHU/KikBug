//
//  KBGroupSearchViewController.m
//  KikBug
//
//  Created by DamonLiu on 16/3/10.
//  Copyright © 2016年 DamonLiu. All rights reserved.
//

#import "KBGroupSearchViewController.h"
#import "KBGroupManager.h"

@interface KBGroupSearchViewController ()<UISearchBarDelegate,UISearchControllerDelegate>
@property (strong,nonatomic) UISearchBar *searchBar;
@property (strong,nonatomic) UISearchController *searchController;
@end

@implementation KBGroupSearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view setBackgroundColor:[UIColor whiteColor]];
    self.searchBar = [UISearchBar new];
    self.searchBar.delegate = self;
    self.searchBar.placeholder = @"输入小组关键字";
    self.searchController = [UISearchController new];
    self.searchController.delegate = self;
    
    [self.view addSubview:self.searchBar];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self.searchBar becomeFirstResponder];
}

- (void)configConstrains
{
    [self.searchBar autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsZero excludingEdge:ALEdgeBottom];
//    [self.searchBar autoSetDimension:ALDimensionHeight toSize:120];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - SearchBar delegate
-(void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
//    NSLog(@"%@",searchText);
    [KBGroupManager searchGroupWithKeyword:searchText block:^(KBBaseModel *baseMode, NSError *error) {
        
    }];
}

@end
