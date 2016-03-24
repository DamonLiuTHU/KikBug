//
//  BugReport.h
//  KikBug
//
//  Created by DamonLiu on 16/3/24.
//  Copyright © 2016年 DamonLiu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

NS_ASSUME_NONNULL_BEGIN
@class KBBugReport;
@interface BugReport : NSManagedObject

// Insert code here to declare functionality of your managed object subclass

+ (instancetype)reportWithKBBugReport:(KBBugReport *)report;

- (void)saveToCoreData;

@end

NS_ASSUME_NONNULL_END

#import "BugReport+CoreDataProperties.h"
