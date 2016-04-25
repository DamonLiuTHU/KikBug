//
//  KBBugReport.m
//  KikBug
//
//  Created by DamonLiu on 16/3/24.
//  Copyright © 2016年 DamonLiu. All rights reserved.
//

#import "DNAsset.h"
#import "KBBugReport.h"
#import "KBImageManager.h"

@implementation KBBugReport

+ (NSDictionary*)mj_replacedKeyFromPropertyName
{
    return @{ @"bugDescription" : @"description",
              @"bugId":@"id"};
}



@end
