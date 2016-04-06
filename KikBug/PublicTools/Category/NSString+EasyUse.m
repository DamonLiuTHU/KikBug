//
//  NSString+EasyUse.m
//  KikBug
//
//  Created by DamonLiu on 15/11/9.
//  Copyright © 2015年 DamonLiu. All rights reserved.
//

#import "NSString+EasyUse.h"

@implementation NSString (EasyUse)
+ (NSString*)dateFromTimeStamp:(NSString*)timeSp
{
    double timestampval = [timeSp doubleValue];
    NSTimeInterval timestamp = (NSTimeInterval)timestampval;
    NSDate* updatetimestamp = [NSDate dateWithTimeIntervalSince1970:timestamp];
    NSDateFormatter* formatter = [NSDateFormatter new];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    return [formatter stringFromDate:updatetimestamp];
}

- (CGFloat)heightForString:(NSString*)value fontSize:(CGFloat)fontSize andWidth:(CGFloat)width //根据字符串的的长度来计算UITextView的高度
{
    CGFloat height = [[NSString stringWithFormat:@"%@\n ", value] boundingRectWithSize:CGSizeMake(width, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIFont systemFontOfSize:fontSize], NSFontAttributeName, nil] context:nil].size.height;

    return height;
}

- (CGSize)sizeForFontSize:(CGFloat)fontSize andWidth:(CGFloat)width //根据字符串的的长度来计算UITextView的高度
{
    NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
//    style.lineBreakMode = NSLineBreakByClipping;
    style.lineSpacing = 0;
    return [self boundingRectWithSize:CGSizeMake(width, CGFLOAT_MAX)
                              options:NSStringDrawingUsesLineFragmentOrigin
                           attributes:@{NSFontAttributeName:APP_FONT(fontSize),
                                        NSParagraphStyleAttributeName:style}
                              context:nil]
        .size;
}

/**
 *  将字典组合成url请求体
 *
 *  @param parameters parameters description
 *
 *  @return return value description
 */
+ (NSString*)concatenateQuery:(NSDictionary*)parameters
{
    if ([parameters count] == 0)
        return nil;
    NSMutableString* query = [NSMutableString string];
    for (NSString* parameter in [parameters allKeys])
        [query appendFormat:@"&%@=%@", [parameter stringByAddingPercentEncodingWithAllowedCharacters:NSCharacterSet.URLQueryAllowedCharacterSet], [[parameters objectForKey:parameter] stringByAddingPercentEncodingWithAllowedCharacters:NSCharacterSet.URLQueryAllowedCharacterSet]];
    return [[query substringFromIndex:1] copy];
}

/**
 *  获取字典
 *
 *  @param query query description
 *
 *  @return return value description
 */
+ (NSDictionary*)splitQuery:(NSString*)query
{
    if ([query length] == 0)
        return nil;
    NSMutableDictionary* parameters = [NSMutableDictionary dictionary];
    for (NSString* parameter in [query componentsSeparatedByString:@"&"]) {
        NSRange range = [parameter rangeOfString:@"="];
        if (range.location != NSNotFound)
            [parameters setObject:[[parameter substringFromIndex:range.location + range.length] stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding] forKey:[[parameter substringToIndex:range.location] stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
        else
            [parameters setObject:[[NSString alloc] init] forKey:[parameter stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    }
    return [parameters copy];
}
@end
