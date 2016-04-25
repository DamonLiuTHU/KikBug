//
//  KBEmptyView.m
//  KikBug
//
//  Created by DamonLiu on 16/4/2.
//  Copyright © 2016年 DamonLiu. All rights reserved.
//

#import "KBEmptyView.h"
#import "KBUIConstant.h"
@interface KBEmptyView()
@property (strong,nonatomic) UILabel *tipLabel;
@end

@implementation KBEmptyView

- (instancetype)init
{
    if (self = [super init]) {
        self.backgroundColor = LIGHT_GRAY_COLOR;
        UILabel* textLabel = [UILabel new];
        textLabel.text = @"页面发生了错误,请重新加载";
        textLabel.textAlignment = NSTextAlignmentCenter;
        UIButton* btn = [UIButton new];
        [btn setTitle:@"重新加载" forState:UIControlStateNormal];
        [btn setBackgroundColor:[KBUIConstant themeDarkColor]];
        
        btn.layer.cornerRadius = 5;
        [btn addTarget:self action:@selector(buttonPressed) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:textLabel];
        [self addSubview:btn];
        
        [self addObserver:self forKeyPath:@"tipText" options:NSKeyValueObservingOptionNew context:nil];

        [textLabel autoAlignAxisToSuperviewAxis:ALAxisVertical];
        [textLabel autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:100];
        [textLabel autoPinEdgeToSuperviewEdge:ALEdgeLeft];
        [textLabel autoPinEdgeToSuperviewEdge:ALEdgeRight];
        textLabel.numberOfLines = 0;

        [btn autoAlignAxis:ALAxisVertical toSameAxisOfView:textLabel];
        [btn autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:textLabel withOffset:20];
        [btn autoSetDimension:ALDimensionWidth toSize:100];
        
        self.tipLabel = textLabel;
    }
    return self;
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context
{
    NSString *newtext = change[NSKeyValueChangeNewKey];
    [self.tipLabel setText:newtext];
}

- (void)dealloc
{
    [self removeObserver:self forKeyPath:@"tipText"];
}

- (void)buttonPressed
{
    if (self.block) {
        self.block();
    }
}

@end
