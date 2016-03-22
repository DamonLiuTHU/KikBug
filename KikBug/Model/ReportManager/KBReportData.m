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
    report.taskId = 8;
    report.name = @"？？name";
    report.logLocation = @"testetssetsetlogLocation";
    report.reportLocation = @"asdasdfasdfasdfreportLocation";
    report.mobileBrand = @"asdfasdfadsfamobileBrand";
    report.mobileModel = @"asdfasdfadsfamobileModel";
    report.mobileOs = @"asdfasdfadsfamobileOs";
    report.bugFound = NO;
    report.timeUsed = 999;
    report.stepDescription = @"stepDescriptionadsfladjsl;fjasdl;gghasdkl;fjadkls;fjal;dsf";
    
    return report;
}

@end
