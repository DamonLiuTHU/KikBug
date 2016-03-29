//
//  KBUserHomeCellModel.m
//  KikBug
//
//  Created by DamonLiu on 16/3/29.
//  Copyright © 2016年 DamonLiu. All rights reserved.
//

#import "KBEmptyCell.h"
#import "KBUserHomeCellModel.h"

@implementation KBUserHomeCellModel
- (instancetype)initWithClass:(Class)className cellHeight:(CGFloat)cellHeight model:(id)model
{
    if (self = [super init]) {
        self.cellClass = className;
        self.cellHeight = cellHeight;
        self.model = model;
    }
    return self;
}

+ (instancetype)emptyCellWithHeight:(CGFloat)height
{
    KBUserHomeCellModel* model = [KBUserHomeCellModel new];
    if (model) {
        model.cellClass = [KBEmptyCell class];
        model.cellHeight = height;
        model.model = nil;
    }
    return model;
}

@end
