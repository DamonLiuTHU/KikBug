//
//  KBGroupDetailModel.h
//  KikBug
//
//  Created by DamonLiu on 16/3/5.
//  Copyright © 2016年 DamonLiu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface KBGroupDetailModel : NSObject<MJKeyValue>
JSONINT groupId;
JSONSTIRNG name;
//JSONSTIRNG groupTesters;
//JSONSTIRNG groupApps;
JSONINT status;
JSONINT operatorId;
JSONSTIRNG operatorName;
JSONSTIRNG contact;
@end
