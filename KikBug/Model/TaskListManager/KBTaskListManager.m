//
//  KBTaskListManager.m
//  KikBug
//
//  Created by DamonLiu on 16/2/29.
//  Copyright © 2016年 DamonLiu. All rights reserved.
//

#import "KBHttpManager.h"
#import "KBTaskListManager.h"
#import "KBTaskListModel.h"

@implementation KBTaskListManager

+ (void)fetchPublicTasksWithCompletion:(void (^)(NSArray<KBTaskListModel*>*, NSError*))block
{
    NSString* url = GETURL_V2(@"PublicTasks");
    [KBHttpManager sendGetHttpReqeustWithUrl:url Params:nil CallBack:^(id responseObject, NSError* error) {
        if (!error) {
            NSMutableArray* array = [NSMutableArray array];
            NSArray* itemsArray = [responseObject valueForKey:@"items"];
            for (NSDictionary* dic in itemsArray) {
                KBTaskListModel* model = [KBTaskListModel mj_objectWithKeyValues:dic];
                [array addObject:model];
            }
            block(array, nil);
        }
        else {
            block(nil, error);
        }
    }];
}

+ (void)fetchMyTasksWithCompletion:(void (^)(NSArray<KBTaskListModel*>*, NSError*))block
{
    NSString* userId = [[NSUserDefaults standardUserDefaults] valueForKey:USER_ID];
    NSString* url = GETURL_V2(@"GetMyTasks");
    [KBHttpManager sendGetHttpReqeustWithUrl:url Params:@{ @"userId" : NSSTRING_NOT_NIL(userId) } CallBack:^(id responseObject, NSError* error) {
        if (!error) {
            NSMutableArray* array = [NSMutableArray array];
            NSArray* itemsArray = [responseObject valueForKey:@"items"];
            for (NSDictionary* dic in itemsArray) {
                //            for (int i = 0; i < 20; i++) {
                //                NSDictionary *dic = itemsArray[0];
                KBTaskListModel* model = [KBTaskListModel mj_objectWithKeyValues:dic];
                [array addObject:model];
                model.isAccepted = YES;
            }
            block(array, nil);
        }
        else {
            block(nil, error);
        }
    }];
}

+ (void)fetchTasksFromGroupWithCompletion:(void (^)(NSArray<KBTaskListModel*>*, NSError*))block
{
    NSString* url = GETURL_V2(@"GetGroupTasks");
    NSString* userId = [[NSUserDefaults standardUserDefaults] valueForKey:USER_ID];
    url = [url stringByReplacingOccurrencesOfString:@"{userId}" withString:NSSTRING_NOT_NIL(userId)];

    [KBHttpManager sendGetHttpReqeustWithUrl:url Params:@{} CallBack:^(id responseObject, NSError* error) {
        if (!error) {
            NSMutableArray* array = [NSMutableArray array];
            NSArray* itemsArray = [responseObject valueForKey:@"items"];
            for (NSDictionary* dic in itemsArray) {
                //            for (int i = 0; i < 20; i++) {
                //                NSDictionary *dic = itemsArray[0];
                KBTaskListModel* model = [KBTaskListModel mj_objectWithKeyValues:dic];
                [array addObject:model];
                model.isAccepted = YES;
            }
            block(array, nil);
        }
        else {
            block(nil, error);
        }
    }];
}

+ (void)fetchTasksFromGroup:(NSString *)groupId WithCompletion:(void (^)(NSArray<KBTaskListModel*>*, NSError*))block
{
    NSString* url = GETURL_V2(@"PublicTasks");
    [KBHttpManager sendGetHttpReqeustWithUrl:url Params:@{@"groupId":NSSTRING_NOT_NIL(groupId)} CallBack:^(id responseObject, NSError* error) {
        if (!error) {
            NSMutableArray* array = [NSMutableArray array];
            NSArray* itemsArray = [responseObject valueForKey:@"items"];
            for (NSDictionary* dic in itemsArray) {
                KBTaskListModel* model = [KBTaskListModel mj_objectWithKeyValues:dic];
                [array addObject:model];
            }
            block(array, nil);
        }
        else {
            block(nil, error);
        }
    }];
}

@end
