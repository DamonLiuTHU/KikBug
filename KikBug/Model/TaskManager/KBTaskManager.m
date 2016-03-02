//
//  KBTaskManager.m
//  KikBug
//
//  Created by DamonLiu on 16/2/29.
//  Copyright © 2016年 DamonLiu. All rights reserved.
//

#import "KBTaskManager.h"
#import "KBHttpManager.h"
#import "KBTaskDetailModel.h"

@implementation KBTaskManager

+ (void)fetchTaskDetailInfoWithTaskId:(NSString *)taskId completion:(void (^)(KBTaskDetailModel *, NSError *))block {
    /**
     
     10.查看具体任务信息
     curl  -H 'Session:1817ae890e8cc25031a0bf7d25c3646e'  http://localhost:9000/task/1
     {"status":200,"message":"success","data":"{\"id\":1,\"groupId\":0,\"appId\":1,\"iconLocation\":null,\"name\":\"测试\",\"createDate\":1456418438,\"endDate\":1556418438,\"description\":\"测试\",\"points\":3,\"appLocation\":\"app_location\",\"driverLocation\":\"driver\",\"groupName\":\"任务广场\"}"}
     */
    
    NSString *url = GETURL_V2(@"GetTaskDetail");
    url = [url stringByReplacingOccurrencesOfString:@"{taskId}" withString:taskId];
    [KBHttpManager sendGetHttpReqeustWithUrl:url Params:nil CallBack:^(id responseObject, NSError *error) {
        if (!error) {
            KBTaskDetailModel *model = [KBTaskDetailModel mj_objectWithKeyValues:responseObject];
            block(model,nil);
        } else {
            block(nil,error);
        }
    }];
}

@end
