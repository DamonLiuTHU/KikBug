//
//  BugReport.m
//  KikBug
//
//  Created by DamonLiu on 16/3/24.
//  Copyright © 2016年 DamonLiu. All rights reserved.
//

#import "BugReport.h"
#import "CoreDataManager.h"
#import "KBReportManager.h"

@implementation BugReport

// Insert code here to add functionality to your managed object subclass

+ (instancetype)reportWithKBBugReport:(KBBugReport*)i_report
{
    BugReport* report = [BugReport new];
    if (report) {
        report.imgUrl = i_report.imgUrl;
        report.bugCategoryId = @(i_report.bugCategoryId);
        report.bugDescription = i_report.bugDescription;
        report.reportId = @(i_report.reportId);
        report.severity = @(i_report.severity);
    }

    return report;
}

- (void)saveToCoreData
{
    BugReport* report = (BugReport*)[NSEntityDescription insertNewObjectForEntityForName:@"BugReport" inManagedObjectContext:CoreManager.managedObjectContext];
    [report setImgUrl:self.imgUrl];
    [report setBugCategoryId:self.bugCategoryId];
    [report setBugDescription:self.bugDescription];
    [report setReportId:self.reportId];
    [report setSeverity:self.severity];
    NSError* error;
    BOOL isSaveSuccess = [CoreManager.managedObjectContext save:&error];
    if (!isSaveSuccess) {
        NSLog(@"Error:%@", error);
    }
    else {
        NSLog(@"Save successful!");
    }
}

@end
