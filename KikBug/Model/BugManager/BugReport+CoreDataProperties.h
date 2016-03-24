//
//  BugReport+CoreDataProperties.h
//  KikBug
//
//  Created by DamonLiu on 16/3/24.
//  Copyright © 2016年 DamonLiu. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "BugReport.h"

NS_ASSUME_NONNULL_BEGIN

@interface BugReport (CoreDataProperties)

@property (nullable, nonatomic, retain) NSNumber *reportId;
@property (nullable, nonatomic, retain) NSNumber *bugCategoryId;
@property (nullable, nonatomic, retain) NSString *imgUrl;
@property (nullable, nonatomic, retain) NSString *bugDescription;
@property (nullable, nonatomic, retain) NSNumber *severity;

@end

NS_ASSUME_NONNULL_END
