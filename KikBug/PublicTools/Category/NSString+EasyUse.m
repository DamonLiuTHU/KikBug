//
//  NSString+EasyUse.m
//  KikBug
//
//  Created by DamonLiu on 15/11/9.
//  Copyright © 2015年 DamonLiu. All rights reserved.
//

#import "NSString+EasyUse.h"

@implementation NSString (EasyUse)
+(NSString*)dateFromTimeStamp:(NSString*)timeSp
{
    double timestampval =  [timeSp doubleValue]/1000.0f;
    NSTimeInterval timestamp = (NSTimeInterval)timestampval;
    NSDate *updatetimestamp = [NSDate dateWithTimeIntervalSince1970:timestamp];
    NSDateFormatter* formatter = [NSDateFormatter new];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    return [formatter stringFromDate:updatetimestamp];
}


- (CGFloat)heightForString:(NSString *)value fontSize:(CGFloat)fontSize andWidth:(CGFloat)width//根据字符串的的长度来计算UITextView的高度
{
    CGFloat height = [[NSString stringWithFormat:@"%@\n ",value] boundingRectWithSize:CGSizeMake(width, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIFont systemFontOfSize:fontSize],NSFontAttributeName, nil] context:nil].size.height;
    
    return height;
}
@end
