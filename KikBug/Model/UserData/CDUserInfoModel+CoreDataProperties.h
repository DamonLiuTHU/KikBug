//
//  CDUserInfoModel+CoreDataProperties.h
//  KikBug
//
//  Created by 钱毅威 on 16/3/29.
//  Copyright © 2016年 DamonLiu. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "CDUserInfoModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface CDUserInfoModel (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *account;
@property (nullable, nonatomic, retain) NSString *avatarLocation; //远程地址
@property (nullable, nonatomic, retain) NSString *avatarLocalLocation; //本地地址
@property (nullable, nonatomic, retain) NSString *name;
@property (nullable, nonatomic, retain) NSNumber *points;
@property (nullable, nonatomic, retain) NSNumber *registerDate;
@property (nullable, nonatomic, retain) NSNumber *userId;

@end

NS_ASSUME_NONNULL_END
