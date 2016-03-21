//
//  KBTaskListManager.h
//  KikBug
//
//  Created by DamonLiu on 16/2/29.
//  Copyright © 2016年 DamonLiu. All rights reserved.
//

#import <Foundation/Foundation.h>
@class KBTaskListModel;

@interface KBTaskListManager : NSObject

+ (void)fetchPublicTasksWithCompletion:(void (^)(NSArray<KBTaskListModel*>* model, NSError* error))block;

+ (void)fetchMyTasksWithCompletion:(void (^)(NSArray<KBTaskListModel*>* model, NSError* error))block;

+ (void)fetchTasksFromGroupWithCompletion:(void (^)(NSArray<KBTaskListModel*>* model, NSError* error))block;
@end
