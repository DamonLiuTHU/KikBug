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
    report.name = @"name";
    report.logLocation = @"testetssetsetlogLocation";
    report.reportLocation = @"asdasdfasdfasdfreportLocation";
    report.mobileBrand = @"Apple";
    report.mobileModel = @"iPhone 6s plus";
    report.mobileOs = @"iOS";
    report.bugFound = 0;
    report.timeUsed = 20;
    report.stepDescription = @"111111";
    
    return report;
}

@end
