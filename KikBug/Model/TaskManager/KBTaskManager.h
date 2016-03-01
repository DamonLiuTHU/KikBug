//
//  KBTaskManager.h
//  KikBug
//
//  Created by DamonLiu on 16/2/29.
//  Copyright © 2016年 DamonLiu. All rights reserved.
//

#import <Foundation/Foundation.h>

@class KBBaseModel,KBTaskDetailModel;

@interface KBTaskManager : NSObject
+ (void)acceptTaskWithTaskId:(NSString *)taskId completion:(void(^)(KBBaseModel *,NSError *))block;
+ (void)fetchTaskDetailInfoWithTaskId:(NSString *)taskId completion:(void(^)(KBTaskDetailModel *,NSError *))block;
@end
