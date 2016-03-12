//
//  KBGroupSearchListCellModel.m
//  KikBug
//
//  Created by DamonLiu on 16/3/12.
//  Copyright © 2016年 DamonLiu. All rights reserved.
//

#import "KBGroupSearchListCellModel.h"

@implementation KBGroupSearchListCellModel
+(NSDictionary *)mj_replacedKeyFromPropertyName
{
    return @{@"groupId":@"id"};
}
@end
