//
//  KBReportmanager.m
//  KikBug
//
//  Created by DamonLiu on 16/3/21.
//  Copyright © 2016年 DamonLiu. All rights reserved.
//

#import "KBBugManager.h"
#import "KBBugReport.h"
#import "KBHttpManager.h"
#import "KBImageManager.h"
#import "KBReportData.h"
#import "KBReportManager.h"

//@implementation KBBugReportItem
//
////
//
//@end

@interface KBReportManager ()

@end

@implementation KBReportManager

+ (void)saveReportId:(NSInteger)reportId
{
    [[NSUserDefaults standardUserDefaults] setValue:INT_TO_STIRNG(reportId) forKey:@"REPORT_ID"];
}

+ (NSInteger)getReportId
{
    return [[[NSUserDefaults standardUserDefaults] valueForKey:@"REPORT_ID"] integerValue];
}

+ (void)uploadTaskReport:(KBTaskReport*)taskReport withCompletion:(void (^)(KBBaseModel*, NSError*))block
{
    NSString* url = GETURL_V2(@"UploadTaskReport");
    NSMutableDictionary* params = [NSMutableDictionary dictionaryWithDictionary:[taskReport mj_keyValues]];
    [KBHttpManager sendPostHttpRequestWithUrl:url Params:params CallBack:^(id responseObject, NSError* error) {
        if (!error) {
            NSInteger i_reportId = [responseObject integerValue];
            [KBReportManager saveReportId:i_reportId];
            block(nil, nil);
        }
        else {
            block(nil, error);
        }
    }];
}

@end
