//
//  KBLogin.h
//  KikBug
//
//  Created by DamonLiu on 16/2/18.
//  Copyright © 2016年 DamonLiu. All rights reserved.
//

#import "NSObject+MJKeyValue.h"
#import <Foundation/Foundation.h>
@class KBLoginModel;

typedef void (^DictionaryBlock)(NSMutableDictionary* infoDict, NSError* error);

@interface KBLoginManager : NSObject

+ (void)loginWithPhone:(NSString*)phone password:(NSString*)password completion:(void (^)(KBLoginModel*, NSError*))block;

+ (void)markUserAsLoginWithUserId:(NSString *)userId userPhone:(NSString *)phone userEmail:(NSString *)email session:(NSString *)session;

+ (void)markUserAsLogOut;

+ (BOOL)isUserLoggedIn;

+ (BOOL)checkIfNeedLoginPage;


@end

@interface KBLoginModel : NSObject <MJKeyValue>
JSONSTIRNG session;
JSONINT userId;
@end
