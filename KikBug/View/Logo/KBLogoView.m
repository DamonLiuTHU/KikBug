//
//  LogoLayer.m
//  KikBug
//
//  Created by DamonLiu on 16/1/26.
//  Copyright © 2016年 DamonLiu. All rights reserved.
//

#import "KBLogoView.h"


@interface KBLogoView ()
@property (strong,nonatomic) UILabel *nameLabel;
@property (strong,nonatomic) UIView *roundView;
@end

@implementation KBLogoView  {
    CALayer      *_contentLayer;
    CAShapeLayer *_maskLayer;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self setup];
        [self setUpConstraints];
    }
    return self;
}

- (void)setUpConstraints {
    [self.nameLabel autoCenterInSuperview];
    [self.roundView autoCenterInSuperview];
    [self.roundView autoSetDimensionsToSize:CGSizeMake(110, 110)];
    [self.roundView.layer setCornerRadius:110/2];
    [self autoSetDimension:ALDimensionWidth toSize:110];
    [self autoSetDimension:ALDimensionHeight toSize:110];
}

- (void)setup
{
//    _maskLayer = [CAShapeLayer layer];
//    _maskLayer.path = [UIBezierPath bezierPathWithOvalInRect:self.bounds].CGPath;
//    _maskLayer.fillColor = [UIColor blackColor].CGColor;
//    _maskLayer.strokeColor = [UIColor redColor].CGColor;
//    _maskLayer.frame = self.bounds;
//    _maskLayer.contentsCenter = CGRectMake(0.5, 0.5, 0.1, 0.1);
//    _maskLayer.contentsScale = [UIScreen mainScreen].scale;
//    
//    _contentLayer = [CALayer layer];
//    _contentLayer.mask = _maskLayer;
//    _contentLayer.frame = self.bounds;
//    if (!_contentLayer.contents) {
//        _contentLayer.backgroundColor = THEME_COLOR.CGColor;
//    }
//    [self.layer addSublayer:_contentLayer];
    
    self.roundView = [[UIView alloc] init];
    self.roundView.backgroundColor = THEME_COLOR;
    [self addSubview:self.roundView];
    
    UILabel *appNameLabel = [[UILabel alloc] init];
    appNameLabel.text = @"Kikbug";
    appNameLabel.textColor = [UIColor whiteColor];
    [appNameLabel sizeToFit];
    [self addSubview:appNameLabel];
    self.nameLabel = appNameLabel;
}

- (void)setImage:(UIImage *)image
{
    _contentLayer.contents = (id)image.CGImage;
}

@end


