//
//  KBUserInfoManager.h
//  KikBug
//
//  Created by DamonLiu on 16/3/29.
//  Copyright © 2016年 DamonLiu. All rights reserved.
//

#import <Foundation/Foundation.h>
@class KBUserInfoModel;
@interface KBUserInfoManager : NSObject
@property (strong, nonatomic) NSManagedObjectContext* context;
SINGLETON_INTERFACE(KBUserInfoManager, manager);
- (void)fetchUserInfoCompletion:(void (^)(KBUserInfoModel*, NSError*))block;
- (void)fetchUserInfoWithUserId:(NSString *)userId completion:(void(^)(KBUserInfoModel *model,NSError *error))block;
- (KBUserInfoModel *)storedUserInfoForUserId:(NSString *)userId;
- (void)saveUserInfo:(KBUserInfoModel *)model;

/**
 *  更新用户信息
 *
 *  @param userName       用户名
 *  @param avatarLocation 头像
 *  @param block          block description
 */
- (void)updateUserName:(NSString *)userName andAvatar:(NSString *)avatarLocation withCompletion:(void(^)(KBBaseModel *model,NSError *error))block;
@end
