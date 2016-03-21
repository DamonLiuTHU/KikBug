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
/**
 *  接受任务
 *  !!!在接受任务的时候，用户必须是已经登录状态
 *  @param taskId 任务Id
 *  @param block  回调
 */
+ (void)acceptTaskWithTaskId:(NSString *)taskId completion:(void(^)(KBBaseModel *,NSError *))block;

/**
 *  获取任务详情
 *  （不需要登录）
 *  @param taskId 任务Id
 *  @param block  回调
 */
+ (void)fetchTaskDetailInfoWithTaskId:(NSString *)taskId completion:(void(^)(KBTaskDetailModel *,NSError *))block;


/**
 *  用户是否已经接受了任务
 *
 *  @param taskId taskId description
 *  @param block  block description
 */
+ (void)isUserTakenTask:(NSString *)taskId completion:(void(^)(KBBaseModel *,NSError *))block;

@end
