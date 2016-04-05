//
//  NSString+EasyUse.h
//  KikBug
//
//  Created by DamonLiu on 15/11/9.
//  Copyright © 2015年 DamonLiu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface NSString (EasyUse)
+ (NSString*)dateFromTimeStamp:(NSString*)timeSp;
- (CGFloat)heightForString:(NSString*)value fontSize:(CGFloat)fontSize andWidth:(CGFloat)width;
- (CGSize)sizeForFontSize:(CGFloat)fontSize andWidth:(CGFloat)width; //根据字符串的的长度来计算UITextView的高度
+ (NSString*)concatenateQuery:(NSDictionary*)parameters;
+ (NSDictionary*)splitQuery:(NSString*)query;
@end
