//
//  KBTaskDetailModel.m
//  KikBug
//
//  Created by DamonLiu on 15/11/9.
//  Copyright © 2015年 DamonLiu. All rights reserved.
//

#import "KBTaskDetailModel.h"

@implementation KBTaskDetailModel
+(NSDictionary *)mj_replacedKeyFromPropertyName {
    return @{@"taskdescription":@"description"};
}
@end
