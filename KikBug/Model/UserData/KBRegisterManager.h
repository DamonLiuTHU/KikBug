//
//  KBRegisterManager.h
//  KikBug
//
//  Created by DamonLiu on 16/3/19.
//  Copyright © 2016年 DamonLiu. All rights reserved.
//

#import <Foundation/Foundation.h>
@class KBLoginModel;
@interface KBRegisterManager : NSObject
+ (void)getToken:(NSString *)mobile completion:(void (^)(KBBaseModel*, NSError*))block;

+ (void)registerUser:(NSString *)mobile token:(NSString *)token psw:(NSString *)password completion:(void (^)(KBBaseModel*, NSError*))block;
@end
