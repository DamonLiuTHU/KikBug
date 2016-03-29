//
//  KBUserInfoManager.m
//  KikBug
//
//  Created by DamonLiu on 16/3/29.
//  Copyright © 2016年 DamonLiu. All rights reserved.
//

#import "KBHttpManager.h"
#import "KBUserInfoManager.h"
#import "KBUserInfoModel.h"

@implementation KBUserInfoManager
+ (void)fetchUserInfoWithUserId:(NSString*)userId completion:(void (^)(KBUserInfoModel*, NSError*))block
{
    NSString* url = GETURL_V2(@"PersonalInfo");
    url = [url stringByReplacingOccurrencesOfString:@"{userId}" withString:NSSTRING_NOT_NIL(userId)];
    [KBHttpManager sendGetHttpReqeustWithUrl:url Params:nil CallBack:^(id responseObject, NSError* error){
        if (!error) {
            KBUserInfoModel *model = [KBUserInfoModel mj_objectWithKeyValues:responseObject];
            block(model,nil);
        } else {
            block(nil,error);
        }
    }];
}


+ (void)fetchUserInfoCompletion:(void (^)(KBUserInfoModel*, NSError*))block
{
    [KBUserInfoManager fetchUserInfoWithUserId:STORED_USER_ID completion:block];
}

@end
