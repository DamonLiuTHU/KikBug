//
//  KBTaskDetailModel.m
//  KikBug
//
//  Created by DamonLiu on 15/11/9.
//  Copyright © 2015年 DamonLiu. All rights reserved.
//

#import "KBTaskDetailModel.h"

@implementation KBTaskDetailModel

/***
 JSONINT taskId;
 JSONSTIRNG appSize;
 JSONSTIRNG category;
 JSONSTIRNG appLocation;
 JSONSTIRNG taskdescription;
 JSONSTIRNG driverLocation;
 JSONINT app_id;
 JSONSTIRNG addDate;
 JSONSTIRNG deadline;
 JSONSTIRNG iconLocation;
 JSONSTIRNG taskName;
 ***/
+(NSDictionary *)mj_replacedKeyFromPropertyName {
    return @{@"taskdescription":@"description",
             @"taskId":@"id",
             @"app_id":@"appId",
             @"taskName":@"name",
             @"addDate":@"createDate",
             @"deadline":@"endDate",
             @"taskdescription":@"description",};
}
@end
