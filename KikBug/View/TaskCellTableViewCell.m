//
//  TaskCellTableViewCell.m
//  KikBug
//
//  Created by DamonLiu on 15/8/11.
//  Copyright (c) 2015年 DamonLiu. All rights reserved.
//

#import "TaskCellTableViewCell.h"

#import "KBTaskListModel.h"
#import "NSString+Safe.h"
#import "NSString+EasyUse.h"
@interface TaskCellTableViewCell()
@property (weak, nonatomic) IBOutlet UIImageView *appImage;
@property (weak, nonatomic) IBOutlet UILabel *taskId;
@property (weak, nonatomic) IBOutlet UILabel *deadLine;
@property (weak, nonatomic) IBOutlet UILabel *taskName;

@end

@implementation TaskCellTableViewCell

- (void)awakeFromNib {
    // Initialization code
//    [self.appImage sizeToFit];
    [self layoutSubviews];
    self.appImage.contentMode = UIViewContentModeScaleAspectFit;
}


-(void)layoutSubviews
{
    [super layoutSubviews];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)fillWithContent:(KBTaskListModel *)data{
//    [self.appImage setImage:[data appImage]];
//    [self.appImage sizeToFit];
//    UIImage* image = data.appImage;
//    [self.introduction setText:[];
    
    [self.taskId setText:data.taskId];
    [self.deadLine setText:[NSString dateFromTimeStamp:data.taskDeadLine]];
    [self.taskName setText:data.taskName];
    
    if([NSString isNilorEmpty:data.iconLocation])
    {
        self.appImage.image = [UIImage imageNamed:@"appicon@2x.jpg"];
    }else
    {
        self.appImage.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:data.iconLocation]]];
    }
}



@end
