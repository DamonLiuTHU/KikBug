//
//  NSString+Safe.m
//  KikBug
//
//  Created by DamonLiu on 15/11/9.
//  Copyright © 2015年 DamonLiu. All rights reserved.
//

#import "NSString+Safe.h"

@implementation NSString (Safe)

//- (id)safeObjectAtIndex:(NSUInteger)index
//{
//    if (index >= self.count)
//        return nil;
//    
//    return [self objectAtIndex:index];
//}


+ (BOOL)isNilorEmpty:(NSString*)string;
{
    if(!string || [string isEqualToString:@""]){
        return YES;
    }
    return NO;
}
@end