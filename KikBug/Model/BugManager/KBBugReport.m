//
//  KBBugReport.m
//  KikBug
//
//  Created by DamonLiu on 16/3/24.
//  Copyright © 2016年 DamonLiu. All rights reserved.
//

#import "KBBugReport.h"
#import "DNAsset.h"
#import "KBImageManager.h"

@implementation KBBugReport

+ (NSDictionary*)mj_replacedKeyFromPropertyName
{
    return @{ @"bugDescription" : @"description" };
}

+ (instancetype)reportWithDNAssets:(NSArray<DNAsset*>*)list taskId:(NSString *)taskId;
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
    
    report.bugCategoryId = 1;
    report.imgUrl = imageUrl;
    report.severity = 3;
    report.taskId = [taskId integerValue];
    return report;
}

@end

