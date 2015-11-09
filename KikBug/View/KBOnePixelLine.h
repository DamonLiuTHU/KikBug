//
//  KBOnePixelLine.h
//  KikBug
//
//  Created by DamonLiu on 15/11/9.
//  Copyright © 2015年 DamonLiu. All rights reserved.
//


#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, KBLinePosition)
{
    GSLinePositionTop = 0,
    GSLinePositionLeft = 1,
    GSLinePositionRight = 2,
    GSLinePositionBottom = 3
};

#define SINGLE_LINE_WIDTH (1/[UIScreen mainScreen].scale)
#define SINGLE_LINE_ADJUST_OFFSET ((1/[UIScreen mainScreen].scale)/2)

IB_DESIGNABLE
@interface KBOnePixelLine : UIView

@property (strong, nonatomic) IBInspectable UIColor *lineColor;
// IBInspectable 不支持枚举类型，所以用Integer代替
@property (assign, nonatomic) IBInspectable NSInteger linePosition;

@end
