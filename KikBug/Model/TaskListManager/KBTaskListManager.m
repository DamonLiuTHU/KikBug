//
//  KBTaskListManager.m
//  KikBug
//
//  Created by DamonLiu on 16/2/29.
//  Copyright © 2016年 DamonLiu. All rights reserved.
//

#import "KBTaskListManager.h"
#import "KBHttpManager.h"

@implementation KBTaskListManager

+ (void)fetchPublicTasksWithCompletion:(void (^)(NSArray<KBTaskListModel*>*, NSError*))block
{
    NSString *url = GETURL_V2(@"PublicTasks");
    [KBHttpManager sendGetHttpReqeustWithUrl:url Params:nil CallBack:^(id responseObject, NSError *error) {
        if (!error) {
            
        } else {
            
        }
    }];
}

@end
