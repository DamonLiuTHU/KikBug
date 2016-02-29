//
//  KBLogin.m
//  KikBug
//
//  Created by DamonLiu on 16/2/18.
//  Copyright © 2016年 DamonLiu. All rights reserved.
//

#import "KBHttpManager.h"
#import "KBLoginManager.h"

@implementation KBLoginManager

+ (void)loginWithPhone:(NSString*)phone password:(NSString*)password completion:(void (^)(KBLoginModel*, NSError*))block
{
    NSDictionary* params = @{ @"username" : NSSTRING_NOT_NIL(phone),
                              @"password" : NSSTRING_NOT_NIL(password) };
    [KBHttpManager sendPostHttpRequestWithUrl:GETURL_V2(@"Login") Params:params CallBack:^(id responseObject, NSError* error) {
        KBLoginModel *model = [KBLoginModel mj_objectWithKeyValues:responseObject];
        if (error) {
            block(nil,error);
        } else {
            [self markUserAsLoginWithUserId:INT_TO_STIRNG(model.userId) userPhone:phone userEmail:phone session:model.session];
            block(model,error);
        }
    }];
}

+ (void)markUserAsLoginWithUserId:(NSString *)userId userPhone:(NSString *)phone userEmail:(NSString *)email session:(NSString *)session
{
    [[NSUserDefaults standardUserDefaults] setObject:@"YES" forKey:USER_STATUS];
    if (userId) {
        [[NSUserDefaults standardUserDefaults] setObject:userId forKey:USER_ID];
    }
    
    if (phone && ![phone containsString:@"@"]) {
        [[NSUserDefaults standardUserDefaults] setObject:phone forKey:USER_PHONE];
    }

    if (email && [email containsString:@"@"]) {
        [[NSUserDefaults standardUserDefaults] setObject:email forKey:USER_EMAIL];
    }
    
    if (session) {
        [[NSUserDefaults standardUserDefaults] setObject:session forKey:SESSION];
    }
}

- (void)markUserAsLogOut
{
    [[NSUserDefaults standardUserDefaults] setObject:@"NO" forKey:USER_STATUS];
}

+ (BOOL)isUserLoggedIn
{
    return [[[NSUserDefaults standardUserDefaults] valueForKey:USER_STATUS] boolValue];
}

@end

@implementation KBLoginModel

//

@end