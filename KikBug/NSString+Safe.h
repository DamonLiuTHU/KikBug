//
//  NSString+Safe.h
//  KikBug
//
//  Created by DamonLiu on 15/11/9.
//  Copyright © 2015年 DamonLiu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Safe)

//- (id)safeObjectAtIndex:(NSUInteger)index;

+ (BOOL)isNilorEmpty:(NSString*)string;

@end

