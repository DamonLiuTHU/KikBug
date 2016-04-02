//
//  KBReportData.m
//  KikBug
//
//  Created by DamonLiu on 16/3/22.
//  Copyright © 2016年 DamonLiu. All rights reserved.
//

#import "KBReportData.h"

@implementation KBTaskReport

+ (instancetype)fakeReport
{
    KBTaskReport* report = [[KBTaskReport alloc] init];
    report.taskId = 15;
    report.name = @"Default Task Report";
    report.logLocation = @"no log";
    report.reportLocation = @"no report";
    report.mobileBrand = @"Apple";
    report.mobileModel = @"iPhone";
    report.mobileOs = @"iOS";
//    report.bugFound = 0;
    report.timeUsed = 0;
    report.stepDescription = @"no step description";
    
    return report;
}

@end
