//
//  TaskCellTableViewCell.m
//  KikBug
//
//  Created by DamonLiu on 15/8/11.
//  Copyright (c) 2015年 DamonLiu. All rights reserved.
//

#import "TaskCellTableViewCell.h"
#import "TaskCellData.h"
@interface TaskCellTableViewCell()
@property (weak, nonatomic) IBOutlet UIImageView *appImage;
@property (weak, nonatomic) IBOutlet UITextView *introduction;

@end

@implementation TaskCellTableViewCell

- (void)awakeFromNib {
    // Initialization code
//    [self.appImage sizeToFit];
    [self layoutSubviews];
    self.appImage.contentMode = UIViewContentModeScaleAspectFit;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)fillWithContent:(TaskCellData *)data{
    [self.appImage setImage:[data appImage]];
    [self.appImage sizeToFit];
//    UIImage* image = data.appImage;
    [self.introduction setText:[data introdution]];
}

@end
