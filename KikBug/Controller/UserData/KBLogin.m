//
//  KBLogin.m
//  KikBug
//
//  Created by DamonLiu on 16/2/18.
//  Copyright © 2016年 DamonLiu. All rights reserved.
//

#import "KBLogin.h"

@implementation KBLogin
+ (void)login:(NSString *)loginId password:(NSString *)password completionBlock:(DictionaryBlock)block {
    
}

+(void)markUserAsLogin {
    [[NSUserDefaults standardUserDefaults] setObject:@"YES" forKey:USER_STATUS];
}

-(void)markUserAsLogOut {
    [[NSUserDefaults standardUserDefaults] setObject:@"NO" forKey:USER_STATUS];
}
@end
