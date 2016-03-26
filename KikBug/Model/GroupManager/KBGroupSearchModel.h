//
//  KBGroupSearchModel.h
//  KikBug
//
//  Created by DamonLiu on 16/3/14.
//  Copyright © 2016年 DamonLiu. All rights reserved.
//

#import <Foundation/Foundation.h>
@class KBGroupSearchItem;
@interface KBGroupSearchModel : NSObject <MJKeyValue>
@property (strong, nonatomic) NSArray<KBGroupSearchItem*>* items;
JSONINT page;
JSONINT count;
@end

@interface KBGroupSearchItem : NSObject
JSONINT groupId;
JSONSTIRNG name;
JSONINT status;//状态0待审核，1通过，2拒绝
JSONSTIRNG operatorName;
@end
