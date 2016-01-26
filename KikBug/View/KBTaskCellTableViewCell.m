//
//  KBTaskCellTableViewCell.m
//  KikBug
//
//  Created by DamonLiu on 15/8/11.
//  Copyright (c) 2015年 DamonLiu. All rights reserved.
//

#import "KBTaskCellTableViewCell.h"

#import "KBTaskListModel.h"
#import "NSString+Safe.h"
#import "NSString+EasyUse.h"
#import "SDWebImageManager.h"
@interface KBTaskCellTableViewCell()
@property (strong, nonatomic) UIImageView *appImage;
@property (strong, nonatomic) UILabel *taskId;
@property (strong, nonatomic) UILabel *deadLine;
@property (strong, nonatomic) UILabel *taskName;

@end

@implementation KBTaskCellTableViewCell{
    UIImage* defaultImage;
}

- (instancetype) initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.appImage = [UIImageView new];
        self.taskId = [UILabel new];
        self.deadLine = [UILabel new];
        self.taskName = [UILabel new];
        [self configSubViews];
    }
    return self;
}

- (void)configConstrains {
    [self.appImage autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsMake(5, 5, 5, 5) excludingEdge:ALEdgeRight];
    [self.appImage autoMatchDimension:ALDimensionWidth toDimension:ALDimensionHeight ofView:self.appImage];
    
    [self.taskId autoPinEdge:ALEdgeLeft toEdge:ALEdgeRight ofView:self.appImage withOffset:5];
    [self.taskId autoPinEdge:ALEdgeTop toEdge:ALEdgeTop ofView:self withOffset:5];
    
    [self.taskName autoPinEdge:ALEdgeLeft toEdge:ALEdgeRight ofView:self.appImage withOffset:5];
    [self.taskName autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:self.taskId withOffset:5];

    [self.deadLine autoPinEdge:ALEdgeLeft toEdge:ALEdgeRight ofView:self.appImage withOffset:5];
    [self.deadLine autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:self.taskName withOffset:5];
}

- (void)configSubViews {
    [self layoutSubviews];
    self.appImage.contentMode = UIViewContentModeScaleAspectFit;
    defaultImage = [UIImage imageNamed:@"appicon@2x.jpg"];
    [self addSubview:self.appImage];
    [self addSubview:self.taskId];
    [self addSubview:self.taskName];
    [self addSubview:self.deadLine];
    [self configConstrains];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)fillWithContent:(KBTaskListModel *)data{

    [self.taskId setText:data.taskId];
    [self.deadLine setText:[NSString dateFromTimeStamp:data.taskDeadLine]];
    [self.taskName setText:data.taskName];
    
    if([NSString isNilorEmpty:data.iconLocation])
    {
        self.appImage.image = defaultImage;
    }else
    {
        WEAKSELF
//        dispatch_async(dispatch_get_global_queue(0, 0), ^{
//            weakSelf.appImage.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:data.iconLocation]]];
//        });
        SDWebImageManager* manager = [SDWebImageManager sharedManager];
        [manager downloadImageWithURL:[NSURL URLWithString:data.iconLocation]
                              options:0
                             progress:^(NSInteger receivedSize, NSInteger expectedSize)
        {
            //
        }
                            completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished, NSURL *imageURL)
        {
            //
            if(image){
                weakSelf.appImage.image = image;
            }
        }];
    }
}



@end
