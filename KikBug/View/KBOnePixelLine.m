//
//  KBOnePixelLine.m
//  KikBug
//
//  Created by DamonLiu on 15/11/9.
//  Copyright © 2015年 DamonLiu. All rights reserved.
//

#import "KBOnePixelLine.h"

@implementation KBOnePixelLine

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        [self _commonInit];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self)
    {
        [self _commonInit];
    }
    return self;
}

- (void)_commonInit
{
    self.backgroundColor = [UIColor clearColor];
    _lineColor = [UIColor blackColor];
    _linePosition = GSLinePositionTop;
}

- (void)drawRect:(CGRect)rect
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextBeginPath(context);
    switch (self.linePosition)
    {
        case GSLinePositionTop:
        {
            CGContextMoveToPoint(context, 0, SINGLE_LINE_ADJUST_OFFSET);
            CGContextAddLineToPoint(context, CGRectGetMaxX(rect),  SINGLE_LINE_ADJUST_OFFSET);
        }
            break;
        case GSLinePositionLeft:
        {
            CGContextMoveToPoint(context, SINGLE_LINE_ADJUST_OFFSET, 0);
            CGContextAddLineToPoint(context, SINGLE_LINE_ADJUST_OFFSET,  CGRectGetMaxY(rect));
            
        }
            break;
        case GSLinePositionRight:
        {
            CGContextMoveToPoint(context, CGRectGetMaxX(rect) -  SINGLE_LINE_ADJUST_OFFSET, 0);
            CGContextAddLineToPoint(context, CGRectGetMaxX(rect) -  SINGLE_LINE_ADJUST_OFFSET,  CGRectGetMaxY(rect));
        }
            
            break;
        case GSLinePositionBottom:
        {
            CGContextMoveToPoint(context, 0, CGRectGetMaxY(rect) - SINGLE_LINE_ADJUST_OFFSET);
            CGContextAddLineToPoint(context, CGRectGetMaxX(rect), CGRectGetMaxY(rect) - SINGLE_LINE_ADJUST_OFFSET);
            
        }
            break;
            
        default:
            break;
    }
    
    CGContextSetLineWidth(context, SINGLE_LINE_WIDTH);
    CGContextSetStrokeColorWithColor(context, self.lineColor.CGColor);
    CGContextStrokePath(context);
}

- (void)setLineColor:(UIColor *)lineColor
{
    _lineColor = lineColor;
    [self setNeedsDisplay];
}

- (void)setLinePosition:(NSInteger)linePosition
{
    _linePosition = linePosition;
    [self setNeedsDisplay];
}

@end

