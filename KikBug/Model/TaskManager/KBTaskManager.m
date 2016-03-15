//
//  KBTaskManager.m
//  KikBug
//
//  Created by DamonLiu on 16/2/29.
//  Copyright © 2016年 DamonLiu. All rights reserved.
//

#import "KBHttpManager.h"
#import "KBTaskDetailModel.h"
#import "KBTaskManager.h"

@implementation KBTaskManager

+ (void)fetchTaskDetailInfoWithTaskId:(NSString*)taskId completion:(void (^)(KBTaskDetailModel*, NSError*))block
{
    NSString* url = GETURL_V2(@"GetTaskDetail");
    url = [url stringByReplacingOccurrencesOfString:@"{taskId}" withString:NSSTRING_NOT_NIL(taskId)];
    [KBHttpManager sendGetHttpReqeustWithUrl:url
                                      Params:nil
                                    CallBack:^(id responseObject, NSError* error) {
                                        if (!error) {
                                            KBTaskDetailModel* model = [KBTaskDetailModel mj_objectWithKeyValues:responseObject];
                                            block(model, nil);
                                        }
                                        else {
                                            block(nil, error);
                                        }
                                    }];
}

+ (void)acceptTaskWithTaskId:(NSString*)taskId completion:(void (^)(KBBaseModel*, NSError*))block
{
    NSString* userId = [[NSUserDefaults standardUserDefaults] valueForKey:USER_ID];
    NSString* url = GETURL_V2(@"AcceptTask");
    url = [url stringByReplacingOccurrencesOfString:@"{id}" withString:NSSTRING_NOT_NIL(userId)];
    [KBHttpManager sendPostHttpRequestWithUrl:url
                                       Params:@{ @"taskId" : NSSTRING_NOT_NIL(taskId) }
                                     CallBack:^(id responseObject, NSError* error) {
                                         if (!error) {
                                             block(responseObject, nil);
                                         }
                                         else {
                                             TRANSLATE(responseObject);
                                             NSLog(@"%@",errorModel);
                                             block(nil, error);
                                         }
                                     }];
}

@end
