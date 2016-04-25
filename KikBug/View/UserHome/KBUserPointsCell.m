//
//  KBUserPointsCell.m
//  KikBug
//
//  Created by DamonLiu on 16/3/29.
//  Copyright © 2016年 DamonLiu. All rights reserved.
//

#import "KBUserPointsCell.h"
#import "KBOnePixelLine.h"
#import "KBUserInfoModel.h"
@interface KBUserPointsCell ()
@property (strong, nonatomic) UILabel* label;
@property (strong, nonatomic) UILabel* nickName;
@end

@implementation KBUserPointsCell

- (void)configSubviews
{
    [super configSubviews];
    UILabel* label = [UILabel new];
    label.text = @"积分";
    [self addSubview:label];
    self.label = label;
    
    self.nickName = [UILabel new];
    [self addSubview:self.nickName];
    
    [self.rightArrow setHidden:YES];
    
    KBOnePixelLine* line = [[KBOnePixelLine alloc] initWithFrame:CGRectZero];
    [self addSubview:line];
    [line autoSetDimension:ALDimensionHeight toSize:1.0f];
    [line autoPinEdgeToSuperviewEdge:ALEdgeTop];
    [line autoPinEdgeToSuperviewMargin:ALEdgeLeft];
    [line autoPinEdgeToSuperviewEdge:ALEdgeRight];
}

- (void)configConstrains
{
    [super configConstrains];
    [self.label autoPinEdgeToSuperviewMargin:ALEdgeLeft];
    [self.label autoAlignAxisToSuperviewAxis:ALAxisHorizontal];
    
    [self.nickName autoPinEdge:ALEdgeRight toEdge:ALEdgeLeft ofView:self.rightArrow withOffset:-10.0f];
    [self.nickName autoAlignAxis:ALAxisHorizontal toSameAxisOfView:self.label];
    
    [super updateConstraints];
}

- (void)bindModel:(KBUserInfoModel*)model
{
    self.nickName.text = INT_TO_STIRNG(model.points);
}

+ (CGFloat)cellHeight
{
    return 50.0f;
}


@end
