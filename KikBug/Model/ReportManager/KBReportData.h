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
JSONSTIRNG name;           //报告名称
JSONSTIRNG logLocation;    //系统生成的
JSONSTIRNG reportLocation; //
JSONSTIRNG mobileBrand;//苹果
JSONSTIRNG mobileModel;//iPhone 6s
JSONSTIRNG mobileOs;   //
//@property (assign,nonatomic) NSInteger bugFound;// 发现的bug数量 = 0
JSONINT timeUsed; //以秒的形式
JSONSTIRNG stepDescription; //整个报告的描述 @『等待补充』

+ (instancetype)fakeReport;

@end
