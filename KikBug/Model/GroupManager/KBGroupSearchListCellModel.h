//
//  KBGroupSearchListCellModel.h
//  KikBug
//
//  Created by DamonLiu on 16/3/12.
//  Copyright © 2016年 DamonLiu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NSObject+MJKeyValue.h"

@interface KBGroupSearchListCellModel : NSObject<MJKeyValue>
JSONINT groupId;
JSONINT status;
JSONSTIRNG name;
@end
