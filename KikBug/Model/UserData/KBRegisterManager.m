//
//  KBRegisterManager.m
//  KikBug
//
//  Created by DamonLiu on 16/3/19.
//  Copyright © 2016年 DamonLiu. All rights reserved.
//

#import "KBBaseModel.h"
#import "KBHttpManager.h"
#import "KBRegisterManager.h"

@implementation KBRegisterManager
+ (void)getToken:(NSString*)mobile completion:(void (^)(KBBaseModel*, NSError*))block
{
    [self storeUserPhone:mobile];
    NSString* url = GETURL_V2(@"GetToken");
    [KBHttpManager sendGetHttpReqeustWithUrl:url Params:@{ @"mobile" : NSSTRING_NOT_NIL(mobile) } CallBack:^(id responseObject, NSError* error) {
        if (!error) {
            KBBaseModel* model = [KBBaseModel mj_objectWithKeyValues:responseObject];
            block(model, nil);
        }
        else {
            block(nil, error);
        }
    }];
}

+ (void)registerUser:(NSString*)mobile token:(NSString*)token psw:(NSString*)password completion:(void (^)(KBBaseModel*, NSError*))block
{
    NSString* url = GETURL_V2(@"Register");
    [KBHttpManager sendPostHttpRequestWithUrl:url
                                       Params:@{ @"mobile" : NSSTRING_NOT_NIL(mobile),
                                           @"token" : NSSTRING_NOT_NIL(token),
                                           @"password" : NSSTRING_NOT_NIL(password) }
                                     CallBack:^(id responseObject, NSError* error) {
                                         if (!error) {
                                             KBBaseModel* model = [KBBaseModel mj_objectWithKeyValues:responseObject];
                                             block(model, nil);
                                         }
                                         else {
                                             block(nil, error);
                                         }
                                     }];
}

+ (void)storeUserPhone:(NSString*)phone
{
    [[NSUserDefaults standardUserDefaults] setObject:phone forKey:USER_PHONE];
}

@end
