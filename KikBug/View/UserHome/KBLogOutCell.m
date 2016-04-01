//
//  KBLogOutCell.m
//  KikBug
//
//  Created by DamonLiu on 16/4/1.
//  Copyright © 2016年 DamonLiu. All rights reserved.
//

#import "KBLogOutCell.h"
#import "KBOnePixelLine.h"

@implementation KBLogOutCell

- (void)configSubviews
{
    UILabel *label = [UILabel new];
    label.text = @"退出登录";
    [self addSubview:label];
    [label autoAlignAxisToSuperviewAxis:ALAxisHorizontal];
    [label autoAlignAxisToSuperviewAxis:ALAxisVertical];
    
    KBOnePixelLine* line = [[KBOnePixelLine alloc] initWithFrame:CGRectZero];
    [self addSubview:line];
    [line autoSetDimension:ALDimensionHeight toSize:1.0f];
    [line autoPinEdgeToSuperviewEdge:ALEdgeTop];
    [line autoPinEdgeToSuperviewEdge:ALEdgeLeft];
    [line autoPinEdgeToSuperviewEdge:ALEdgeRight];
    
//    KBOnePixelLine* line2 = [[KBOnePixelLine alloc] initWithFrame:CGRectZero];
//    [self addSubview:line2];
//    [line2 autoPinEdgeToSuperviewEdge:ALEdgeBottom];
//    [line2 autoSetDimension:ALDimensionHeight toSize:1.0f];
//    [line2 autoPinEdgeToSuperviewEdge:ALEdgeLeft];
//    [line2 autoPinEdgeToSuperviewEdge:ALEdgeRight];
}

+ (CGFloat)cellHeight
{
    return 45;
}

@end
