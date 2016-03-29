//
//  KBUserSimpleInfoCell.m
//  
//
//  Created by DamonLiu on 16/3/28.
//
//

#import "KBUserSimpleInfoCell.h"
#import "KBGroupSearchModel.h"

@implementation KBUserSimpleInfoCell

- (void)configSubviews
{
    self.headIcon = [UIImageView new];
    self.userName = [UILabel new];
    self.accountNumber = [UILabel new];
    self.arrowImage = [UIImageView new];
    [self addSubview:self.headIcon];
    [self addSubview:self.userName];
    [self addSubview:self.accountNumber];
    [self addSubview:self.arrowImage];
}

- (void)bindModel:(KBGroupSearchItem*)model
{
    
}

- (void)configConstrains
{
   
}

+ (CGFloat)calculateCellHeightWithData:(id)cellData
{
    return 80;
}


@end
