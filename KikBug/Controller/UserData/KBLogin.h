//
//  KBLogin.h
//  KikBug
//
//  Created by DamonLiu on 16/2/18.
//  Copyright © 2016年 DamonLiu. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void (^DictionaryBlock)(NSMutableDictionary *infoDict, NSError *error);
@interface KBLogin : NSObject
+ (void)login:(NSString*)loginId password:(NSString*)password completionBlock:(DictionaryBlock)block;

+ (void)markUserAsLogin;

- (void)markUserAsLogOut;
@end
