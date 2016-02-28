//
//  KBLogin.h
//  KikBug
//
//  Created by DamonLiu on 16/2/18.
//  Copyright © 2016年 DamonLiu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NSObject+MJKeyValue.h"

typedef void (^DictionaryBlock)(NSMutableDictionary *infoDict, NSError *error);
@interface KBLogin : NSObject

+ (void)markUserAsLogin;

- (void)markUserAsLogOut;

@end

@interface KBLoginModel : NSObject <MJKeyValue>
JSONSTIRNG message;
JSONINT status;
@property (strong,nonatomic) NSDictionary *data;    
@end
