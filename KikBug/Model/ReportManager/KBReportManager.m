//
//  KBReportmanager.m
//  KikBug
//
//  Created by DamonLiu on 16/3/21.
//  Copyright © 2016年 DamonLiu. All rights reserved.
//

#import "KBHttpManager.h"
#import "KBReportData.h"
#import "KBReportManager.h"
#import "KBImageManager.h"

//@implementation KBBugReportItem
//
////
//
//@end

@implementation KBBugReport

+ (NSDictionary*)mj_replacedKeyFromPropertyName
{
    return @{ @"bugDescription" : @"description" };
}

+ (instancetype)reportWithDNAssets:(NSArray<DNAsset*>*)list
{
    KBBugReport* report = [[KBBugReport alloc] init];

    if (![NSString isNilorEmpty:[list firstObject].userDesc]) {
        report.bugDescription = [list firstObject].userDesc;
    } else {
        report.bugDescription = @"用户没有填写bug描述";
    }
    
    NSMutableString* imageUrl = [NSMutableString string];
    NSInteger counter = 0;
    
    for (DNAsset* asset in list) {
        counter++;
        UIImage *image = [asset getImageResource];
        NSString *key = [KBImageManager getSaveKeyWith:@"jpg" andIndex:counter];
        NSString *imgUrl = [@"http://kikbug-test.b0.upaiyun.com" stringByAppendingString:key];
        [imageUrl appendString:[imgUrl stringByAppendingString:@";"]];
        [KBImageManager uploadImage:image withKey:key completion:^(NSString *imageUrl, NSError *error) {
            
        }];
    }

    report.bugCategoryId = 0;
    report.imgUrl = imageUrl;
    report.severity = 3;
    return report;
}

@end

@interface KBReportManager ()

@end

static NSInteger REPORT_ID = -1;

@implementation KBReportManager

/**
 *  上传bug报告
 *
 *  @param bugReport bugReport description
 *  @param block     block description
 */
+ (void)uploadBugReport:(KBBugReport*)bugReport withCompletion:(void (^)(KBBaseModel*, NSError*))block
{
    NSString* url = GETURL_V2(@"UploadBug");
    REPORT_ID = 10086;//test
    if (REPORT_ID >= 0) {
        bugReport.reportId = REPORT_ID;
    }
    else { //如果没有reportId，那么说明服务器没有返回reportId，不可以发送bug报告。
        return;
    }
    [KBHttpManager sendPostHttpRequestWithUrl:url Params:[bugReport mj_keyValues] CallBack:^(id responseObject, NSError* error) {
        if (!error) {
        }
        else {
        }
    }];
}

+ (void)uploadTaskReport:(KBTaskReport*)taskReport withCompletion:(void (^)(KBBaseModel*, NSError*))block
{
    NSString* url = GETURL_V2(@"UploadTaskReport");
    [KBHttpManager sendPostHttpRequestWithUrl:url Params:[taskReport mj_keyValues] CallBack:^(id responseObject, NSError* error) {
        if (!error) {
            NSInteger i_reportId = [[responseObject valueForKey:@"reportId"] integerValue];
            REPORT_ID = i_reportId;
        }
        else {
        }
    }];
}

@end
