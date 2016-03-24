//
//  KBBugManager.h
//  KikBug
//
//  Created by DamonLiu on 16/3/24.
//  Copyright © 2016年 DamonLiu. All rights reserved.
//

#import <Foundation/Foundation.h>
@class KBBugReport;

static NSInteger REPORT_ID = -1;

@interface KBBugManager : NSObject
+ (void)uploadBugReport:(KBBugReport*)bugReport withCompletion:(void (^)(KBBaseModel* model, NSError* error))block;
@end
