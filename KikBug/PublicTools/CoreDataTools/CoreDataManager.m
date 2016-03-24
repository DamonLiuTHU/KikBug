//
//  CoreDataManager.m
//  KikBug
//
//  Created by DamonLiu on 16/3/24.
//  Copyright © 2016年 DamonLiu. All rights reserved.
//

#import "CoreDataManager.h"
#import <CoreData/CoreData.h>

@interface CoreDataManager ()
//@property (strong, nonatomic ,getter=managedObjectModel) NSManagedObjectModel* managedObjectModel;
//@property (strong, nonatomic ,getter=managedObjectContext) NSManagedObjectContext* managedObjectContext;
//@property (strong, nonatomic ,getter=persistentStoreCoordinator) NSPersistentStoreCoordinator* persistentStoreCoordinator;
@end

@implementation CoreDataManager

SINGLETON_IMPLEMENTION(CoreDataManager, sharedManager);

//托管对象
- (NSManagedObjectModel*)managedObjectModel
{
    if (self.managedObjectModel != nil) {
        return self.managedObjectModel;
    }
    //        NSURL* modelURL=[[NSBundle mainBundle] URLForResource:@"CoreDataExample" withExtension:@"momd"];
    //        self.managedObjectModel=[[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    self.managedObjectModel = [NSManagedObjectModel mergedModelFromBundles:nil];
    //    self.
    return self.managedObjectModel;
}
//托管对象上下文
- (NSManagedObjectContext*)managedObjectContext
{
    if (self.managedObjectContext != nil) {
        return self.managedObjectContext;
    }

    NSPersistentStoreCoordinator* coordinator = [self persistentStoreCoordinator];
    if (coordinator != nil) {
        self.managedObjectContext = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSMainQueueConcurrencyType];

        [self.managedObjectContext setPersistentStoreCoordinator:coordinator];
    }
    return self.managedObjectContext;
}
//持久化存储协调器
- (NSPersistentStoreCoordinator*)persistentStoreCoordinator
{
    if (_persistentStoreCoordinator != nil) {
        return _persistentStoreCoordinator;
    }
    //    NSURL* storeURL=[[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"CoreaDataExample.CDBStore"];
    //    NSFileManager* fileManager=[NSFileManager defaultManager];
    //    if(![fileManager fileExistsAtPath:[storeURL path]])
    //    {
    //        NSURL* defaultStoreURL=[[NSBundle mainBundle] URLForResource:@"CoreDataExample" withExtension:@"CDBStore"];
    //        if (defaultStoreURL) {
    //            [fileManager copyItemAtURL:defaultStoreURL toURL:storeURL error:NULL];
    //        }
    //    }
    NSString* docs = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSURL* storeURL = [NSURL fileURLWithPath:[docs stringByAppendingPathComponent:@"CoreDataExample.sqlite"]];
    NSLog(@"path is %@", storeURL);
    NSError* error = nil;
    _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
    if (![_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error]) {
        NSLog(@"Error: %@,%@", error, [error userInfo]);
    }
    return _persistentStoreCoordinator;
}
-(NSURL *)applicationDocumentsDirectory
{
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}

@end
