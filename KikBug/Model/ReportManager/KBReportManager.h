//
//  KBReportManager.h
//  KikBug
//
//  Created by DamonLiu on 16/3/21.
//  Copyright © 2016年 DamonLiu. All rights reserved.
//

#import "DNAsset.h"
#import <Foundation/Foundation.h>
@class KBTaskReport, KBBugReport;
//@interface KBBugReportItem : KBBaseModel
//@property (strong,nonatomic) UIImage *image;
//@property (strong,nonatomic) NSString *descForImage;
//@end

@interface KBReportManager : NSObject
/**
 *  获取存储的ReportId
 *
 *  @return return value description
 */
+ (NSInteger)getReportId;

+ (void)uploadTaskReport:(KBTaskReport*)taskReport withCompletion:(void (^)(KBBaseModel* model, NSError* error))block;

@end
