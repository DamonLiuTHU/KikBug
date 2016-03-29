//
//  KBUserInfoModel.h
//  KikBug
//
//  Created by DamonLiu on 16/3/29.
//  Copyright © 2016年 DamonLiu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NSObject+MJKeyValue.h"

@interface KBUserInfoModel : KBBaseModel
/**
 private long id;
 private String userName;
 private String name;
 private int registerDate;
 private String avatarLocation;
 private int points;
 */
JSONINT userId;
JSONSTIRNG account;  //账号
JSONSTIRNG name; //昵称
JSONINT registerDate;
JSONSTIRNG avatarLocation;
JSONINT points;
JSONSTIRNG avatarLocalLocation;
@end
