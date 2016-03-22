//
//  KBReportmanager.m
//  KikBug
//
//  Created by DamonLiu on 16/3/21.
//  Copyright © 2016年 DamonLiu. All rights reserved.
//

#import "KBHttpManager.h"
#import "KBReportManager.h"
#import "KBReportData.h"

@implementation KBBugReportItem

//

@end

@implementation KBBugReport

+ (NSDictionary*)mj_replacedKeyFromPropertyName
{
    return @{ @"bugDescription" : @"description" };
}

+ (instancetype)reportWithDNAssets:(NSArray<DNAsset*>*)list
{
    KBBugReport* report = [[KBBugReport alloc] init];
    NSMutableArray<KBBugReportItem*>* array = [NSMutableArray array];
    for (DNAsset* asset in list) {
        KBBugReportItem* item = [[KBBugReportItem alloc] init];
        item.image = [asset getImageResource];
        item.descForImage = asset.userDesc;
        [array addObject:item];
    }
    report.items = array;
    return report;
}

@end

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
    [KBHttpManager sendPostHttpRequestWithUrl:url Params:[bugReport mj_keyValues] CallBack:^(id responseObject, NSError* error) {
        if (!error) {
            //
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
        }
        else {
        }
    }];
}

@end
