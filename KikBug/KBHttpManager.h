//
//  KBHttpManager.h
//  KikBug
//
//  Created by DamonLiu on 15/11/10.
//  Copyright © 2015年 DamonLiu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface KBHttpManager : NSObject
+(void)SendGetHttpReqeustWithUrl:(NSString*)url
                          Params:(NSDictionary*)param
                        CallBack:(void(^)(id responseObject,NSError* error))block;
@end
