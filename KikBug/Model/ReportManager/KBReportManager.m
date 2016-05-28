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

@implementation KBReportListModel

+ (NSDictionary *)mj_replacedKeyFromPropertyName
{
    return @{@"reportId":@"id",
             @"bugNumber":@"bugFound"};
}

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

+ (void)uploadTaskReport:(KBTaskReport*)taskReport
          withCompletion:(void (^)(KBBaseModel*, NSError*))block
{
    NSString* url = GETURL_V2(@"UploadTaskReport");
    NSMutableDictionary* params = [NSMutableDictionary dictionaryWithDictionary:[taskReport mj_keyValues]];
    [KBHttpManager sendPostHttpRequestWithUrl:url
                                       Params:params
                                     CallBack:^(id responseObject, NSError* error) {
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

+ (void)getAllUserReportForTaskId:(NSString*)taskId
                       completion:(void (^)(NSArray <KBReportListModel *>*, NSError*))block
{
    NSString* url = GETURL_V2(@"GetMyReports");
    [KBHttpManager sendGetHttpReqeustWithUrl:url
                                      Params:@{ @"testerId" : NSSTRING_NOT_NIL(STORED_USER_ID),
                                          @"taskId" : NSSTRING_NOT_NIL(taskId),
                                                @"count":INT_TO_STIRNG(100)}
                                    CallBack:^(id responseObject, NSError* error) {
                                        if (!error) {
                                            NSArray *array = [responseObject valueForKey:@"items"];
                                            NSMutableArray *result = [NSMutableArray array];
                                            for (id item in array) {
                                                KBReportListModel *model = [KBReportListModel mj_objectWithKeyValues:item];
                                                [result addObject:model];
                                            }
                                            block(result,nil);
                                        }
                                        else {
                                            block(nil, error);
                                        }
                                    }];
}
@end
