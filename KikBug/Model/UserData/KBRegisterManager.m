//
//  KBRegisterManager.m
//  KikBug
//
//  Created by DamonLiu on 16/3/19.
//  Copyright © 2016年 DamonLiu. All rights reserved.
//

#import "KBBaseModel.h"
#import "KBRegisterManager.h"
#import "KBHttpManager.h"

@implementation KBRegisterManager
+ (void)getToken:(NSString*)mobile completion:(void (^)(KBBaseModel*, NSError*))block
{
    NSString* url = GETURL_V2(@"GetToken");
    [KBHttpManager sendGetHttpReqeustWithUrl:url Params:@{ @"mobile" : NSSTRING_NOT_NIL(mobile) } CallBack:^(id responseObject, NSError* error) {
        if (!error) {
            KBBaseModel *model = [KBBaseModel mj_objectWithKeyValues:responseObject];
            block(model, nil);
        }
        else {
            block(nil, error);
        }
    }];
}

+ (void)registerUser:(NSString*)mobile token:(NSString*)token psw:(NSString*)password completion:(void (^)(KBLoginModel*, NSError*))block
{
}

@end
