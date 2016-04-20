//
//  KBSegmentControlCell.m
//  KikBug
//
//  Created by DamonLiu on 16/4/19.
//  Copyright © 2016年 DamonLiu. All rights reserved.
//

#import "KBSegmentControlCell.h"

@implementation KBSegmentControlCell
- (void)setIndexController:(UIViewController *)indexController{
    
    [_indexController.view removeFromSuperview];
    _indexController = indexController;
    [self.contentView addSubview:_indexController.view];
    [self layoutSubviews];
}

- (void)layoutSubviews{
    [super layoutSubviews];
    _indexController.view.frame = self.bounds;
}
@end
