//
//  KBTaskDetailModel.h
//  KikBug
//
//  Created by DamonLiu on 15/11/9.
//  Copyright © 2015年 DamonLiu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NSObject+MJKeyValue.h"
#import "Macros.h"

@interface KBTaskDetailModel : NSObject<MJKeyValue>
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
JSONINT groupId;
JSONINT points;
JSONINT page;
JSONINT count;
@property (assign,nonatomic) BOOL isReceive;
@end
