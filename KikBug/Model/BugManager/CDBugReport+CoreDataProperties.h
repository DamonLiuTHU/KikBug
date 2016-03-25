//
//  CDBugReport+CoreDataProperties.h
//  KikBug
//
//  Created by DamonLiu on 16/3/25.
//  Copyright © 2016年 DamonLiu. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "CDBugReport.h"

NS_ASSUME_NONNULL_BEGIN

@interface CDBugReport (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *bugDesc;
@property (nullable, nonatomic, retain) NSNumber *bugId;
@property (nullable, nonatomic, retain) NSString *bugImgSrc;
@property (nullable, nonatomic, retain) NSNumber *reportId;

@end

NS_ASSUME_NONNULL_END
