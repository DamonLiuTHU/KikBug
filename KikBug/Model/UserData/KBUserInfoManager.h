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



/**
 *  获取用户信息，首先从本地读 读不到从网上读。
 *
 *  @param block block description
 */
- (void)fetchUserInfoCompletion:(void (^)(KBUserInfoModel*, NSError*))block;
//- (void)fetchUserInfoWithUserId:(NSString *)userId completion:(void(^)(KBUserInfoModel *model,NSError *error))block;

//- (KBUserInfoModel *)storedUserInfoForUserId:(NSString *)userId;
//- (KBUserInfoModel*)storedUserInfo;


/**
 *  保存个人信息，先更新本地的，再更新网络的
 *
 *  @param model model description
 */
- (void)saveUserInfo:(KBUserInfoModel *)model;

/**
 *  更新用户信息
 *
 *  @param userName       用户名
 *  @param avatarLocation 头像
 *  @param block          block description
 */
//- (void)updateUserName:(NSString *)userName andAvatar:(NSString *)avatarLocation withCompletion:(void(^)(KBBaseModel *model,NSError *error))block;
@end
