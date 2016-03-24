//
//  CoreDataManager.h
//  KikBug
//
//  Created by DamonLiu on 16/3/24.
//  Copyright © 2016年 DamonLiu. All rights reserved.
//

#import <Foundation/Foundation.h>
@class NSManagedObjectContext,NSManagedObjectModel,NSPersistentStoreCoordinator;
@interface CoreDataManager : NSObject
@property (strong, nonatomic ,getter=managedObjectModel) NSManagedObjectModel* managedObjectModel;
@property (strong, nonatomic ,getter=managedObjectContext) NSManagedObjectContext* managedObjectContext;
@property (strong, nonatomic ,getter=persistentStoreCoordinator) NSPersistentStoreCoordinator* persistentStoreCoordinator;

SINGLETON_INTERFACE(CoreDataManager, sharedManager);

@end
