//
//  KBBaseTableViewCell.m
//  KikBug
//
//  Created by DamonLiu on 16/3/9.
//  Copyright © 2016年 DamonLiu. All rights reserved.
//

#import "KBBaseTableViewCell.h"

@implementation KBBaseTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)bindModel:(id)model
{
    
}

- (void)configSubviews
{
    self.rightArrow = [UIImageView new];
    self.rightArrow.image = [UIImage imageNamed:@"Arrow_Right"];
    [self.rightArrow setHidden:YES];
    [self addSubview:self.rightArrow];
}

+ (NSString *)cellIdentifier {
    return NSStringFromClass([self class]);
}

+ (id)cellForTableView:(UITableView *)tableView {
    NSString *cellID = [self cellIdentifier];
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell == nil) {
        cell = [[self alloc] initWithCellIdentifier:cellID];
    }
    
    return cell;
}

- (id)initWithCellIdentifier:(NSString *)cellID {
    id instant = [self initWithStyle:UITableViewCellStyleSubtitle
               reuseIdentifier:cellID];
    [instant setSelectionStyle:UITableViewCellSelectionStyleNone];
    [instant configSubviews];
    [instant configConstrains];
    return instant;
}

+ (CGFloat)calculateCellHeightWithData:(id)cellData
{
    return 0;
}

+ (CGFloat)calculateCellHeightWithData:(id)cellData containerWidth:(CGFloat)containerWidth
{
    return 0;
}

+ (CGFloat)cellHeight {
    return 0;
}

- (void)configConstrains
{
    [self.rightArrow autoSetDimensionsToSize:CGSizeMake(10, 20)];
    [self.rightArrow autoPinEdgeToSuperviewMargin:ALEdgeRight];
    [self.rightArrow autoAlignAxisToSuperviewAxis:ALAxisHorizontal];
    [super updateConstraints];
}

@end
