//
//  KBTaskListModel.h
//  KikBug
//
//  Created by DamonLiu on 15/11/9.
//  Copyright © 2015年 DamonLiu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NSObject+MJKeyValue.h"
#import "Macros.h"


@interface KBTaskListModel : NSObject<MJKeyValue>
JSONSTIRNG taskId;
JSONSTIRNG taskDeadLine;
JSONSTIRNG taskName;
JSONSTIRNG iconLocation;/**< 图片地址 */
@end
