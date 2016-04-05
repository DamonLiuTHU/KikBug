
//
//  KBBugTypeLabel.m
//  KikBug
//
//  Created by DamonLiu on 16/4/5.
//  Copyright © 2016年 DamonLiu. All rights reserved.
//

#import "KBBugTypeLabel.h"

@implementation KBBugTypeLabel

- (instancetype)init
{
    if (self = [super init]) {
        self.font = APP_FONT(12);
        self.layer.cornerRadius = 2.5f;
        self.clipsToBounds = YES;
        self.textAlignment = NSTextAlignmentCenter;
        self.lineBreakMode = NSLineBreakByWordWrapping;
    }
    return self;
}

- (void)fillLabelWithTitle:(NSString *)title severity:(NSInteger)severity
{
    self.text = [NSString stringWithFormat:@"%@",title];
    UIColor *fillColor;
    switch (severity) {
        case 1:
        {
            fillColor = [UIColor colorWithHexNumber:0xffff44];
        }
            break;
        case 2:
        {
            fillColor = [UIColor colorWithHexNumber:0xffcccc];
        }
            break;
        case 3:
        {
            fillColor = [UIColor colorWithHexNumber:0xff6666];
        }
            break;
        case 4:
        {
             fillColor = [UIColor colorWithHexNumber:0xff2222];
        }
            break;
        case 5:
        {
             fillColor = [UIColor colorWithHexNumber:0xcc0033];
        }
            break;
            
        default:
            break;
    }
    [self setBackgroundColor:fillColor];
}

@end
