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
@end