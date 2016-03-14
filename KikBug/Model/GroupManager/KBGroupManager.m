//
//  KBGroupManager.m
//  KikBug
//
//  Created by DamonLiu on 16/3/5.
//  Copyright © 2016年 DamonLiu. All rights reserved.
//

#import "KBBaseModel.h"
#import "KBGroupDetailModel.h"
#import "KBGroupManager.h"
#import "KBGroupSearchModel.h"
#import "KBHttpManager.h"

@implementation KBGroupManager

/**
 *
 *
 *  @param groupId groupId description
 *  @param phrase  phrase description
 *  @param block
 */
+ (void)joinGroupWithGroupId:(NSString*)groupId phrase:(NSString*)phrase block:(void (^)(KBBaseModel*, NSError*))block
{
    NSString* url = GETURL_V2(@"JoinGroup");
    url = [url stringByReplacingOccurrencesOfString:@"{id}" withString:STORED_USER_ID];
    [KBHttpManager sendPostHttpRequestWithUrl:url
                                       Params:@{ @"groupId" : NSSTRING_NOT_NIL(groupId),
                                           @"phrase" : NSSTRING_NOT_NIL(phrase) }
                                     CallBack:^(id responseObject, NSError* error) {
                                         if (!error) {
                                             block(responseObject, nil);
                                         }
                                         else {
                                             block(nil, error);
                                         }
                                     }];
}

/**
 *  搜索群组
 ！！！ 搜索的时候要带上status = 1  默认设置。
 *
 *  @param keyword 关键词
 *  @param block   block description
 */
+ (void)searchGroupWithKeyword:(NSString*)keyword block:(void (^)(KBGroupSearchModel*, NSError*))block
{
    //    if ([NSString isNilorEmpty:keyword]) {
    //        return;
    //    }
    NSString* url = GETURL_V2(@"SearchGroup");
    [KBHttpManager sendGetHttpReqeustWithUrl:url
                                      Params:@{ @"userId" : NSSTRING_NOT_NIL(STORED_USER_ID),
                                          @"keyword" : NSSTRING_NOT_NIL(keyword),
                                          @"status" : @(1) }
                                    CallBack:^(id responseObject, NSError* error) {
                                        if (responseObject && !error) {
                                            KBGroupSearchModel* model = [KBGroupSearchModel mj_objectWithKeyValues:responseObject];
                                            block(model, nil);
                                        }
                                        else {
                                            block(nil, error);
                                        }
                                    }];
}

+ (void)fetchGroupDetailWithGroupId:(NSString*)groupId block:(void (^)(KBGroupDetailModel*, NSError*))block
{
    NSString* url = GETURL_V2(@"GetGroupDetail");
    url = [url stringByReplacingOccurrencesOfString:@"{groupId}" withString:NSSTRING_NOT_NIL(groupId)];
    [KBHttpManager sendGetHttpReqeustWithUrl:url
                                      Params:nil
                                    CallBack:^(id responseObject, NSError* error) {
                                        if (!error) {
                                            KBGroupDetailModel* model = [KBGroupDetailModel mj_objectWithKeyValues:responseObject];
                                            block(model, nil);
                                        }
                                        else {
                                            block(nil, error);
                                        }
                                    }];
}

+ (void)fetchMyGroupsWithBlock:(void (^)(KBGroupSearchModel *, NSError *))block
{
    NSString *url = GETURL_V2(@"GetMyGroups");
    [KBHttpManager sendGetHttpReqeustWithUrl:url
                                      Params:@{@"testerId":NSSTRING_NOT_NIL(STORED_USER_ID)}
                                    CallBack:^(id responseObject, NSError *error) {
                                        if (!error) {
                                            KBGroupSearchModel* model = [KBGroupSearchModel mj_objectWithKeyValues:responseObject];
                                            block(model, nil);
                                        }
                                        else {
                                            block(nil, error);
                                        }

                                    }];
}
@end
