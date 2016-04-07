//
//  KBSimpleEditorViewController.m
//  KikBug
//
//  Created by DamonLiu on 16/3/31.
//  Copyright © 2016年 DamonLiu. All rights reserved.
//

#import "KBSimpleEditorViewController.h"

@interface KBSimpleEditorViewController ()
@property (strong, nonatomic) UITextField* editor;
@end

@implementation KBSimpleEditorViewController

- (instancetype)init
{
    if (self = [super init]) {
        self.editor = [UITextField new];
        UIView *emptyView = [UIView new];
        emptyView.backgroundColor = [UIColor clearColor];
        self.editor.leftView = emptyView;
        [emptyView autoSetDimension:ALDimensionWidth toSize:10];
        self.editor.leftViewMode = UITextFieldViewModeAlways;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view setBackgroundColor:LIGHT_GRAY_COLOR];
    self.editor.clearButtonMode = UITextFieldViewModeAlways;
    [self.view addSubview:self.editor];
}

- (void)configConstrains
{
    [super configConstrains];
    [self.editor autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsMake(20, 0, 0, 0) excludingEdge:ALEdgeBottom];
    [self.editor autoSetDimension:ALDimensionHeight toSize:50.0f];
    [self.editor setBackgroundColor:[UIColor whiteColor]];
    [super updateViewConstraints];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setParams:(NSDictionary*)params
{
    self.editor.text = params[@"text"];
}

- (void)viewWillDisappear:(BOOL)animated
{
    if (self.delegate) {
        [self.delegate editorDidReturnStr:self.editor.text];
    }
}

@end
