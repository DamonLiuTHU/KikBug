//
//  KBReportListCell.m
//  KikBug
//
//  Created by DamonLiu on 16/4/5.
//  Copyright © 2016年 DamonLiu. All rights reserved.
//

#import "KBReportListCell.h"
#import "KBReportManager.h"

@interface KBReportListCell ()

@property (strong, nonatomic) UILabel* reportNameLabel;
@property (strong, nonatomic) UILabel* dateLabel;
@property (strong, nonatomic) UILabel* bugNumberLabel;
@property (strong, nonatomic) UIView* containerView;

@end

@implementation KBReportListCell

- (void)configSubviews
{
    self.reportNameLabel = [UILabel new];
    self.dateLabel = [UILabel new];
    self.bugNumberLabel = [UILabel new];
    self.containerView = [UIView new];
    
    [self.containerView setBackgroundColor:[UIColor whiteColor]];
    [self setBackgroundColor:LIGHT_GRAY_COLOR];
    self.containerView.layer.cornerRadius = 5.0f;
    
    [self.containerView addSubview:self.reportNameLabel];
    [self.containerView addSubview:self.dateLabel];
    [self.containerView addSubview:self.bugNumberLabel];
    [self addSubview:self.containerView];
}

- (void)bindModel:(KBReportListModel*)model
{
    self.reportNameLabel.attributedText = [[NSAttributedString alloc] initWithString:[NSString stringWithFormat:@"报告名称:%@", model.name] attributes:TITLE_ATTRIBUTE];

    self.dateLabel.attributedText = [[NSAttributedString alloc] initWithString:[NSString stringWithFormat:@"日期:%@", [NSString dateFromTimeStamp:model.createDate]] attributes:SUBTITLE_ATTRIBUTE];

    self.bugNumberLabel.attributedText = [[NSAttributedString alloc] initWithString:[NSString stringWithFormat:@"Bug数量:%ld", (long)model.bugNumber] attributes:SUBTITLE_ATTRIBUTE];
}

- (void)configConstrains
{
    [super configConstrains];

    [self.containerView autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsMake(10, 10, 0, 10)];
    [self.reportNameLabel autoAlignAxisToSuperviewAxis:ALAxisHorizontal];
    [self.bugNumberLabel autoAlignAxisToSuperviewAxis:ALAxisHorizontal];
    [self.dateLabel autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:self.reportNameLabel withOffset:5.0f];

    [self.reportNameLabel autoPinEdgeToSuperviewMargin:ALEdgeLeft];
    [self.bugNumberLabel autoPinEdgeToSuperviewMargin:ALEdgeRight];
//    [self.dateLabel autoPinEdge:ALEdgeLeft toEdge:ALEdgeLeft ofView:self.reportNameLabel];
    [self.dateLabel autoPinEdgeToSuperviewMargin:ALEdgeRight];
    [super updateConstraints];
}

+ (CGFloat)cellHeight
{
    return 80;
}

@end
