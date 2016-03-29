//
//  KBTaskListModel.m
//  KikBug
//
//  Created by DamonLiu on 15/11/9.
//  Copyright © 2015年 DamonLiu. All rights reserved.
//

#import "KBTaskListModel.h"

@implementation KBTaskListModel

+ (NSDictionary*)mj_replacedKeyFromPropertyName
{
    return @{ @"taskId" : @"id",
        @"taskName" : @"name",
        @"taskDeadLine" : @"endDate",
        @"taskDescription" : @"description"
    };
}

@end
