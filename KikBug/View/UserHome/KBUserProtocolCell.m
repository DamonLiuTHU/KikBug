//
//  KBUserProtocolCell.m
//  KikBug
//
//  Created by DamonLiu on 16/4/25.
//  Copyright © 2016年 DamonLiu. All rights reserved.
//

#import "KBUserProtocolCell.h"

@interface KBUserProtocolCell ()
@property (strong,nonatomic) UILabel *title;
@end

@implementation KBUserProtocolCell
-(void)configSubviews
{
    self.title = [UILabel new];
    self.title.text = @"用户协议";
    [self addSubview:self.title];
    [self.title autoAlignAxisToSuperviewAxis:ALAxisHorizontal];
    [self.title autoAlignAxisToSuperviewAxis:ALAxisVertical];
}
@end
