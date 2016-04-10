//
//  KBUserInfoManager.m
//  KikBug
//
//  Created by DamonLiu on 16/3/29.
//  Copyright © 2016年 DamonLiu. All rights reserved.
//

#import "CDUserInfoModel.h"
#import "KBHttpManager.h"
#import "KBUserInfoManager.h"
#import "KBUserInfoModel.h"

@implementation KBUserInfoManager

SINGLETON_IMPLEMENTION(KBUserInfoManager, manager);

- (void)fetchUserInfoWithUserId:(NSString*)userId completion:(void (^)(KBUserInfoModel*, NSError*))block
{
    NSString* url = GETURL_V2(@"PersonalInfo");
    url = [url stringByReplacingOccurrencesOfString:@"{userId}" withString:NSSTRING_NOT_NIL(userId)];
    [KBHttpManager sendGetHttpReqeustWithUrl:url Params:nil CallBack:^(id responseObject, NSError* error) {
        if (!error) {
            KBUserInfoModel* model = [KBUserInfoModel mj_objectWithKeyValues:responseObject];
            [[KBUserInfoManager manager] saveUserInfo:model];
            block(model, nil);
        }
        else {
            block(nil, error);
        }
    }];
}

- (void)fetchUserInfoCompletion:(void (^)(KBUserInfoModel*, NSError*))block
{
    KBUserInfoModel* model = [self storedUserInfo];
    if (model) {
        block(model, nil);
    }
    else {
        [[KBUserInfoManager manager] fetchUserInfoWithUserId:STORED_USER_ID completion:block];
    }
}

#pragma mark - Core Data Part

- (void)initContext
{
    // 从应用程序包中加载模型文件
    NSManagedObjectModel* model = [NSManagedObjectModel mergedModelFromBundles:nil];
    // 传入模型对象，初始化NSPersistentStoreCoordinator
    NSPersistentStoreCoordinator* psc = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:model];
    // 构建SQLite数据库文件的路径
    NSString* docs = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSURL* url = [NSURL fileURLWithPath:[docs stringByAppendingPathComponent:@"userInfo.data"]];
    // 添加持久化存储库，这里使用SQLite作为存储库
    NSError* error = nil;
    NSPersistentStore* store = [psc addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:url options:nil error:&error];
    if (store == nil) { // 直接抛异常
        [NSException raise:@"添加数据库错误" format:@"%@", [error localizedDescription]];
    }
    // 初始化上下文，设置persistentStoreCoordinator属性
    NSManagedObjectContext* context = [[NSManagedObjectContext alloc] init];
    context.persistentStoreCoordinator = psc;
    self.context = context;
}

static NSString* entityName = @"CDUserInfoModel";

- (KBUserInfoModel*)storedUserInfo
{
    NSString* userId = STORED_USER_ID;
    return [self storedUserInfoForUserId:userId];
}

- (KBUserInfoModel*)storedUserInfoForUserId:(NSString*)userId
{
    if (!self.context) {
        [self initContext];
    }
    // 初始化一个查询请求
    NSFetchRequest* request = [[NSFetchRequest alloc] init];
    // 设置要查询的实体
    request.entity = [NSEntityDescription entityForName:entityName inManagedObjectContext:self.context];
    // 设置排序（按照age降序）
    //    NSSortDescriptor* sort = [NSSortDescriptor sortDescriptorWithKey:@"bugId" ascending:NO];
    //    request.sortDescriptors = [NSArray arrayWithObject:sort];
    NSPredicate* predicate = [NSPredicate predicateWithFormat:@"userId==%@", userId];
    [request setPredicate:predicate];
    // 执行请求
    NSError* error = nil;
    NSArray* objs = [self.context executeFetchRequest:request error:&error];
    if (error) {
        [NSException raise:@"DBError" format:@"%@", [error localizedDescription]];
        return nil;
    }

    // 遍历数据
    for (NSManagedObject* obj in objs) {
        return [self getModelWithManagedObj:obj];
    }
    return nil;
}

- (void)saveUserInfo:(KBUserInfoModel*)model
{
    //Step1 更新本地的
    if (!self.context) {
        [self initContext];
    }
    KBUserInfoModel* stored_model = [[KBUserInfoManager manager] storedUserInfoForUserId:INT_TO_STIRNG(model.userId)];
    if (stored_model) { //找到本地存储的用户信息的话，更新
        [self updateLocalUserInfo:model];
    }
    else {
        // 传入上下文，创建一个Person实体对象
        NSManagedObject* cdBugReport = [NSEntityDescription insertNewObjectForEntityForName:entityName inManagedObjectContext:self.context];
        [self configManagedObj:cdBugReport WithModel:model];
        // 利用上下文对象，将数据同步到持久化存储库
        NSError* error = nil;
        BOOL success = [self.context save:&error];
        if (!success) {
            [NSException raise:@"DBError" format:@"%@", [error localizedDescription]];
        }
    }

    //Step2 更新网上的
    [[KBUserInfoManager manager] updateUserName:model.name andAvatar:model.avatarLocation withCompletion:^(KBBaseModel* model, NSError* error){
        //
    }];
}

/**
 *  更新本地存储的用户信息
 *
 *  @param model model
 */
- (void)updateLocalUserInfo:(KBUserInfoModel*)model
{
    if (!self.context) {
        [self initContext];
    }

    NSFetchRequest* request = [[NSFetchRequest alloc] init];
    request.entity = [NSEntityDescription entityForName:entityName inManagedObjectContext:self.context];
    NSPredicate* predicate = [NSPredicate predicateWithFormat:@"userId==%ld", (long)model.userId];
    [request setPredicate:predicate];

    NSError* error = nil;
    NSArray* objs = [self.context executeFetchRequest:request error:&error];
    if (error) {
        [NSException raise:@"DBError" format:@"%@", [error localizedDescription]];
        return;
    }

    // 遍历数据
    for (NSManagedObject* obj in objs) {
        [self configManagedObj:obj WithModel:model];
    }

    BOOL success = [self.context save:&error];
    if (!success) {
        [NSException raise:@"DBError" format:@"%@", [error localizedDescription]];
    }
}

/**
 *  使用Model来填充Core Data的模型
 *
 *  @param obj   CoreData模型
 *  @param model 实际model
 */
- (void)configManagedObj:(NSManagedObject*)obj WithModel:(KBUserInfoModel*)model
{
    [obj setValue:@(model.userId) forKey:@"userId"];
    [obj setValue:model.avatarLocation forKey:@"avatarLocation"];
    [obj setValue:model.name forKey:@"name"];
    [obj setValue:@(model.points) forKey:@"points"];
    [obj setValue:@(model.registerDate) forKey:@"registerDate"];
    [obj setValue:model.account forKey:@"account"];
    [obj setValue:model.avatarLocalLocation forKey:@"avatarLocalLocation"];
}

/**
 *  使用Core Data模型来创建Model
 *
 *  @param obj Core Data 模型
 *
 *  @return Model
 */
- (KBUserInfoModel*)getModelWithManagedObj:(NSManagedObject*)obj
{
    KBUserInfoModel* model = [[KBUserInfoModel alloc] init];
    model.userId = [[obj valueForKey:@"userId"] integerValue];
    model.name = [obj valueForKey:@"name"];
    model.avatarLocation = [obj valueForKey:@"avatarLocation"];
    model.points = [[obj valueForKey:@"points"] integerValue];
    model.registerDate = [[obj valueForKey:@"registerDate"] integerValue];
    model.account = [obj valueForKey:@"account"];
    model.avatarLocalLocation = [obj valueForKey:@"avatarLocalLocation"];
    return model;
}

- (void)updateUserName:(NSString*)userName andAvatar:(NSString*)avatarLocation withCompletion:(void (^)(KBBaseModel*, NSError*))block
{
    if ([NSString isNilorEmpty:userName] && [NSString isNilorEmpty:avatarLocation]) {
        return;
    }
    NSString* url = GETURL_V2(@"PersonalInfo");
    url = [url stringByReplacingOccurrencesOfString:@"{userId}" withString:NSSTRING_NOT_NIL(STORED_USER_ID)];
    [KBHttpManager sendPutHttpRequestWithUrl:url
                                      Params:@{ @"name" : NSSTRING_NOT_NIL(userName),
                                          @"avatarLocation" : NSSTRING_NOT_NIL(avatarLocation),
                                      }
                                    CallBack:^(id responseObject, NSError* error) {
                                        if (!error) {
                                            block(responseObject, nil);
                                        }
                                        else {
                                            block(nil, error);
                                        }
                                    }];
}

@end
