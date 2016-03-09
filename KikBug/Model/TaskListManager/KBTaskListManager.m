//
//  KBTaskListManager.m
//  KikBug
//
//  Created by DamonLiu on 16/2/29.
//  Copyright © 2016年 DamonLiu. All rights reserved.
//

#import "KBTaskListManager.h"
#import "KBHttpManager.h"
#import "KBTaskListModel.h"

@implementation KBTaskListManager

+ (void)fetchPublicTasksWithCompletion:(void (^)(NSArray<KBTaskListModel*>*, NSError*))block
{
    NSString *url = GETURL_V2(@"PublicTasks");
    [KBHttpManager sendGetHttpReqeustWithUrl:url Params:nil CallBack:^(id responseObject, NSError *error) {
        if (!error) {
            NSMutableArray *array = [NSMutableArray array];
            NSArray *itemsArray = [responseObject valueForKey:@"items"];
            for (NSDictionary *dic in itemsArray) {
                KBTaskListModel *model = [KBTaskListModel mj_objectWithKeyValues:dic];
                [array addObject:model];
            }
            block(array,nil);
        } else {
            
        }
    }];
}

+ (void)fetchMyTasksWithCompletion:(void (^)(NSArray<KBTaskListModel *> *, NSError *))block {
    NSString *userId = [[NSUserDefaults standardUserDefaults] valueForKey:USER_ID];
    NSString *url = GETURL_V2(@"GetMyTasks");
    [KBHttpManager sendGetHttpReqeustWithUrl:url Params:@{@"userId":NSSTRING_NOT_NIL(userId)} CallBack:^(id responseObject, NSError *error) {
        if (!error) {
            NSMutableArray *array = [NSMutableArray array];
            NSArray *itemsArray = [responseObject valueForKey:@"items"];
            for (NSDictionary *dic in itemsArray) {
                KBTaskListModel *model = [KBTaskListModel mj_objectWithKeyValues:dic];
                [array addObject:model];
                model.isAccepted = YES;
            }
            block(array,nil);
        } else {
            
        }
    }];
}

@end
