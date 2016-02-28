//
//  KBLogin.m
//  KikBug
//
//  Created by DamonLiu on 16/2/18.
//  Copyright © 2016年 DamonLiu. All rights reserved.
//

#import "KBLogin.h"
#import "KBHttpManager.h"

@implementation KBLogin


+(void)markUserAsLogin {
    [[NSUserDefaults standardUserDefaults] setObject:@"YES" forKey:USER_STATUS];
}

-(void)markUserAsLogOut {
    [[NSUserDefaults standardUserDefaults] setObject:@"NO" forKey:USER_STATUS];
}

@end

@implementation KBLoginModel

//

@end
