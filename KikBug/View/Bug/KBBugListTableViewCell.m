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
#import "KBBugTypeLabel.h"
#import "KBBugManager.h"

@interface KBBugListTableViewCell ()
@property (strong,nonatomic) UILabel *bugIdLabel;
//@property (strong,nonatomic) UILabel *bugDescHint;
@property (strong,nonatomic) UILabel *bugDescContent;
@property (strong,nonatomic) UIImageView *arrowImg;
@property (strong,nonatomic) UIView *containerView;
@property (strong,nonatomic) KBBugTypeLabel *typeLabel;
@end

@implementation KBBugListTableViewCell

- (id)initWithCellIdentifier:(NSString *)cellID
{
    if (self = [super initWithCellIdentifier:cellID]) {
        self.bugIdLabel = [UILabel new];
        self.typeLabel = [[KBBugTypeLabel alloc] init];
        self.bugDescContent = [UILabel new];

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
        [self.containerView addSubview:self.typeLabel];
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
    NSString *bugDescHintStr = [NSString stringWithFormat:@"%@",model.bugDescription];
    [self.bugIdLabel setAttributedText:[[NSAttributedString alloc] initWithString:bugNoStr attributes:TITLE_ATTRIBUTE]];
//    [self.bugDescHint setAttributedText:[[NSAttributedString alloc] initWithString:bugDescHintStr attributes:TITLE_ATTRIBUTE]];
    [self.bugDescContent setAttributedText:[[NSAttributedString alloc] initWithString:bugDescHintStr attributes:SUBTITLE_ATTRIBUTE]];
    if ([KBBugManager sharedInstance].categoryDic) {
        [self configTypeLabelWithModel:model];
    } else {
        WEAKSELF;
        [[KBBugManager sharedInstance] getAllBugCategorysWithCompletion:^(KBBugCategory *category, NSError *error) {
            [weakSelf configTypeLabelWithModel:model];
        }];
    }
    
    if (model.taskId > 0) {
        //
    } else {
        [self.imageView setHidden:YES];
    }
}

- (void)configTypeLabelWithModel:(KBBugReport *)model
{
    NSDictionary *dic = [[KBBugManager sharedInstance].categoryDic.categories mj_keyValues];
    NSString *cateName = [dic valueForKey:INT_TO_STIRNG(model.bugCategoryId)];
    [self.typeLabel fillLabelWithTitle:cateName severity:model.severity];
    [self updateConstraints];
}

- (void)configConstrains
{
    [self.containerView autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsMake(10, 10, 0, 10)];
    
    [self.bugIdLabel autoPinEdgeToSuperviewMargin:ALEdgeLeft];
    [self.bugIdLabel autoPinEdgeToSuperviewMargin:ALEdgeTop];
    
//    [self.typeLabel autoPinEdge:ALEdgeLeft toEdge:ALEdgeRight ofView:self.bugIdLabel withOffset:5.0f];
    [self.typeLabel autoPinEdgeToSuperviewMargin:ALEdgeLeft];
//    [self.typeLabel autoAlignAxis:ALAxisHorizontal toSameAxisOfView:self.bugIdLabel];
    [self.typeLabel autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:self.bugDescContent withOffset:5.0f];
    [self.typeLabel autoSetDimension:ALDimensionWidth toSize:80.0f];
    
    [self.arrowImg autoAlignAxisToSuperviewAxis:ALAxisHorizontal];
    [self.arrowImg autoPinEdgeToSuperviewMargin:ALEdgeRight];
    [self.arrowImg setContentHuggingPriority:UILayoutPriorityDefaultHigh forAxis:UILayoutConstraintAxisHorizontal];
    [self.arrowImg autoSetDimensionsToSize:CGSizeMake(35, 35)];
    
    [self.bugDescContent autoPinEdgeToSuperviewMargin:ALEdgeLeft];
    [self.bugDescContent autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:self.bugIdLabel withOffset:5.0f];
//    [self.bugDescContent autoSetDimension:ALDimensionHeight toSize:40.0f];
    [self.bugDescContent autoPinEdge:ALEdgeRight toEdge:ALEdgeLeft ofView:self.arrowImg];
    
    [super updateConstraints];
}

//+ (CGFloat)cellHeight
+ (CGFloat)calculateCellHeightWithData:(NSString *)cellData
{
    if (!cellData || ![cellData isKindOfClass:[NSString class]]) {
        return 0.0f;
    }
    CGFloat baseHeight = 68;  //除了bug报告以外的高度
    CGSize calculatedSize = [cellData sizeForFontSize:10 andWidth:304];//注意 这里的10是bugDescCOntentlabel 的内容字体大小。
    return baseHeight + calculatedSize.height;
}


@end
