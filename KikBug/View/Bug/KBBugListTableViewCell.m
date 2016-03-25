//
//  KBBugListTableViewCell.m
//  KikBug
//
//  Created by DamonLiu on 16/3/24.
//  Copyright © 2016年 DamonLiu. All rights reserved.
//

#import "KBBugListTableViewCell.h"
#import "KBReportManager.h"
#import "KBBugReport.h"

@interface KBBugListTableViewCell ()
@property (strong,nonatomic) UILabel *bugIdLabel;
@property (strong,nonatomic) UILabel *bugTypeLabel;
//@property (strong,nonatomic) UILabel *bugDescHint;
@property (strong,nonatomic) UILabel *bugDescContent;
@property (strong,nonatomic) UIImageView *arrowImg;
@property (strong,nonatomic) UIView *containerView;
@end

@implementation KBBugListTableViewCell

- (id)initWithCellIdentifier:(NSString *)cellID
{
    if (self = [super initWithCellIdentifier:cellID]) {
        self.bugIdLabel = [UILabel new];
        self.bugTypeLabel = [UILabel new];
//        self.bugDescHint = [UILabel new];
        self.bugDescContent = [UILabel new];
//        [self.bugDescContent setEditable:NO];
//        [self.bugDescContent setUserInteractionEnabled:NO];
//        self.bugDescContent.textAlignment = NSTextAlignmentNatural;
        self.bugDescContent.textAlignment = NSTextAlignmentLeft;
        self.bugDescContent.lineBreakMode = NSLineBreakByWordWrapping;
        self.bugDescContent.numberOfLines = 0;
        self.arrowImg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"photo_check_selected"]];
        self.containerView = [UIView new];
        self.containerView.layer.cornerRadius = 5.0f;
        [self.containerView setClipsToBounds:YES];
        [self setBackgroundColor:GRAY_COLOR];
        
        [self.containerView setBackgroundColor:[UIColor whiteColor]];
        [self addSubview:self.containerView];
        
        [self.containerView addSubview:self.bugDescContent];
        [self.containerView addSubview:self.bugIdLabel];
        [self.containerView addSubview:self.bugTypeLabel];
//        [self.containerView addSubview:self.bugDescHint];
        [self.containerView addSubview:self.arrowImg];
        [self configConstrains];
        
    }
    return self;
}

- (void)bindModel:(KBBugReport *)model
{
    if (![model isKindOfClass:[KBBugReport class]]) {
        return;
    }
    NSString *bugNoStr = [NSString stringWithFormat:@"Bug No.%ld",(long)model.bugId];
    NSString *bugDescHintStr = [NSString stringWithFormat:@"Bug描述:%@",model.bugDescription];
    [self.bugIdLabel setAttributedText:[[NSAttributedString alloc] initWithString:bugNoStr attributes:TITLE_ATTRIBUTE]];
//    [self.bugDescHint setAttributedText:[[NSAttributedString alloc] initWithString:bugDescHintStr attributes:TITLE_ATTRIBUTE]];
    [self.bugDescContent setAttributedText:[[NSAttributedString alloc] initWithString:bugDescHintStr attributes:SUBTITLE_ATTRIBUTE]];
}

- (void)configConstrains
{
    [self.containerView autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsMake(10, 10, 0, 10)];
    
    [self.bugIdLabel autoPinEdgeToSuperviewMargin:ALEdgeLeft];
    [self.bugIdLabel autoPinEdgeToSuperviewMargin:ALEdgeTop];
    
//    [self.bugDescHint autoPinEdge:ALEdgeLeft toEdge:ALEdgeLeft ofView:self.bugIdLabel];
//    [self.bugDescHint autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:self.bugIdLabel withOffset:10.0f];
    [self.arrowImg autoAlignAxisToSuperviewAxis:ALAxisHorizontal];
    [self.arrowImg autoPinEdgeToSuperviewMargin:ALEdgeRight];
    [self.arrowImg setContentHuggingPriority:UILayoutPriorityDefaultHigh forAxis:UILayoutConstraintAxisHorizontal];
    [self.arrowImg autoSetDimensionsToSize:CGSizeMake(35, 35)];
    
    [self.bugDescContent autoPinEdgeToSuperviewMargin:ALEdgeLeft];
    [self.bugDescContent autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:self.bugIdLabel];
    [self.bugDescContent autoSetDimension:ALDimensionHeight toSize:40.0f];
    [self.bugDescContent autoPinEdge:ALEdgeRight toEdge:ALEdgeLeft ofView:self.arrowImg];
    
    [super updateConstraints];
}

+ (CGFloat)cellHeight
{
    return 80.0f;
}


@end
