//
//  KBSegmentSelectView.h
//  KikBug
//
//  Created by DamonLiu on 16/4/19.
//  Copyright © 2016年 DamonLiu. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol KBSegmentSelectViewDelegate <NSObject>

- (void)didSelectIndex:(NSInteger)index;

@end

@interface KBSegmentSelectView : UIView

@property (weak,nonatomic) id<KBSegmentSelectViewDelegate> delegate;

- (instancetype)initWithDelegate:(id<KBSegmentSelectViewDelegate>) delegate titles:(NSArray *)titles;

@end
