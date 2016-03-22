//
//  KBReportData.h
//  KikBug
//
//  Created by DamonLiu on 16/3/22.
//  Copyright © 2016年 DamonLiu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface KBTaskReport : KBBaseModel

JSONINT taskId;
JSONSTIRNG name;
JSONSTIRNG logLocation;
JSONSTIRNG reportLocation;
JSONSTIRNG mobileBrand;
JSONSTIRNG mobileModel;
JSONSTIRNG mobileOs;
@property (assign,nonatomic) BOOL bugFound;
JSONINT timeUsed;
JSONSTIRNG stepDescription;

+ (instancetype)fakeReport;

@end
