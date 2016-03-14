//
//  KBGroupSearchTableViewCell.m
//  KikBug
//
//  Created by DamonLiu on 16/3/14.
//  Copyright © 2016年 DamonLiu. All rights reserved.
//

#import "KBGroupSearchModel.h"
#import "KBGroupSearchTableViewCell.h"

@interface KBGroupSearchTableViewCell ()
@property (strong, nonatomic) UILabel* groupNameLabel;
@end

@implementation KBGroupSearchTableViewCell

- (instancetype)initWithCellIdentifier:(NSString*)cellID
{
    if (self = [super initWithCellIdentifier:cellID]) {
        //        self.groupIdLabel = [UILabel new];
        //        self.createrLabel = [UILabel new];
        //        self.createDateLabel = [UILabel new];
        self.groupNameLabel = [UILabel new];
        [self setBackgroundColor:[UIColor clearColor]];
        //        [self.containerView setBackgroundColor:[UIColor whiteColor]];
        //        [self.containerView.layer setCornerRadius:5.0f];
        //        [self addSubview:self.containerView];
        //        [self.containerView addSubview:self.groupIdLabel];
        //        [self.containerView addSubview:self.createrLabel];
        //        [self.containerView addSubview:self.createDateLabel];
        [self addSubview:self.groupNameLabel];
        [self configConstrains];
    }
    return self;
}

- (void)bindModel:(id)model
{
    if ([model isKindOfClass:[KBGroupSearchItem class]]) {
        KBGroupSearchItem* model2 = (KBGroupSearchItem*)model;
        [self.groupNameLabel setText:model2.name];
        [self.groupNameLabel sizeToFit];
    }
}

- (void)configConstrains
{
    [self.groupNameLabel autoAlignAxisToSuperviewAxis:ALAxisHorizontal];
//    [self.groupNameLabel autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:5.0f];
    [self.groupNameLabel autoPinEdgeToSuperviewMargin:ALEdgeLeft];
    [self updateConstraints];
}

+ (CGFloat)cellHeight
{
    return 50;
}

@end
