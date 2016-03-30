//
//  KBHttpManager.h
//  KikBug
//
//  Created by DamonLiu on 15/11/10.
//  Copyright © 2015年 DamonLiu. All rights reserved.
//

#import <Foundation/Foundation.h>
@class AFHTTPRequestOperationManager;

@interface KBHttpManager : NSObject

+ (AFHTTPRequestOperationManager*)getHttpRequestManager;

+ (void)sendGetHttpReqeustWithUrl:(NSString*)url
                           Params:(NSDictionary*)param
                         CallBack:(void (^)(id responseObject, NSError* error))block;

+ (void)sendPostHttpRequestWithUrl:(NSString*)url
                            Params:(NSDictionary*)param
                          CallBack:(void (^)(id responseObject, NSError* error))block;

+ (void)sendPutHttpRequestWithUrl:(NSString*)url
                           Params:(NSDictionary*)param
                         CallBack:(void (^)(id, NSError*))block;
@end
