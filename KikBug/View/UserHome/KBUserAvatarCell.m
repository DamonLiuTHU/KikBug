//
//  KBUserAvatarCell.m
//  KikBug
//
//  Created by DamonLiu on 16/3/29.
//  Copyright © 2016年 DamonLiu. All rights reserved.
//

#import "KBOnePixelLine.h"
#import "KBUserAvatarCell.h"
#import "KBUserInfoManager.h"
#import "KBUserInfoModel.h"

@interface KBUserAvatarCell ()
@property (strong, nonatomic) UILabel* label;
@property (strong, nonatomic) UIImageView* avatar;
@end

@implementation KBUserAvatarCell

- (void)configSubviews
{
    [super configSubviews];
    UILabel* label = [UILabel new];
    label.text = @"头像";
    [self addSubview:label];
    self.label = label;

    self.avatar = [UIImageView new];
    self.avatar.layer.cornerRadius = 5.0f;
    self.avatar.layer.borderWidth = 1.0f;
    self.avatar.clipsToBounds = YES;
    self.avatar.layer.borderColor = [UIColor colorWithHexNumber:0xe3e3e3].CGColor;

    [self addSubview:self.avatar];

    [self.rightArrow setHidden:NO];

    KBOnePixelLine* line = [[KBOnePixelLine alloc] initWithFrame:CGRectZero];
    [self addSubview:line];
    [line autoSetDimension:ALDimensionHeight toSize:1.0f];
    [line autoPinEdgeToSuperviewEdge:ALEdgeTop];
    [line autoPinEdgeToSuperviewEdge:ALEdgeLeft];
    [line autoPinEdgeToSuperviewEdge:ALEdgeRight];
}

- (void)configConstrains
{
    [super configConstrains];
    [self.label autoPinEdgeToSuperviewMargin:ALEdgeLeft];
    [self.label autoAlignAxisToSuperviewAxis:ALAxisHorizontal];

    [self.avatar autoPinEdge:ALEdgeRight toEdge:ALEdgeLeft ofView:self.rightArrow withOffset:-10.0f];
    [self.avatar autoPinEdgeToSuperviewMargin:ALEdgeTop];
    [self.avatar autoPinEdgeToSuperviewMargin:ALEdgeBottom];
    [self.avatar autoConstrainAttribute:ALAttributeHeight toAttribute:ALAttributeWidth ofView:self.avatar];

    [super updateConstraints];
}

- (void)bindModel:(KBUserInfoModel*)model
{
    //    NSString *thumUrl = [[NSUserDefaults standardUserDefaults] valueForKey:@"THUMBNAILAVATAR"];
    if (model.avatarLocalLocation) {
        UIImage* image = [UIImage imageWithContentsOfFile:model.avatarLocalLocation];
        if (!image) {
            [self.avatar setImageWithUrl:model.avatarLocation];
            return;
        }
        self.avatar.image = image;
    }
    else {
        [self.avatar setImageWithUrl:model.avatarLocation];
    }
}

@end
