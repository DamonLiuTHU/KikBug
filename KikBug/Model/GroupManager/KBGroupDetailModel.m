//
//  KBGroupDetailModel.m
//  KikBug
//
//  Created by DamonLiu on 16/3/5.
//  Copyright © 2016年 DamonLiu. All rights reserved.
//

#import "KBGroupDetailModel.h"

@implementation KBGroupDetailModel
+(NSDictionary *)mj_replacedKeyFromPropertyName {
    return @{@"groupId":@"id"};
}
@end
