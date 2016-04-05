//
//  KBBugManager.h
//  KikBug
//
//  Created by DamonLiu on 16/3/24.
//  Copyright © 2016年 DamonLiu. All rights reserved.
//

#import <Foundation/Foundation.h>
@class KBBugReport;

@interface KBBugCategoryItem : KBBaseModel
JSONSTIRNG category1;
JSONSTIRNG category2;
JSONSTIRNG category3;
JSONSTIRNG category4;
JSONSTIRNG category5;
@end

@interface KBBugCategory : KBBaseModel
@property (strong,nonatomic) KBBugCategoryItem *categories;
@end

@interface KBBugManager : NSObject

@property (strong,nonatomic) KBBugCategory *categoryDic;

SINGLETON_INTERFACE(KBBugManager, sharedInstance);
- (void)uploadBugReport:(KBBugReport*)bugReport withCompletion:(void (^)(KBBaseModel* model, NSError* error))block;
- (void)getAllBugReportsWithCompletion:(void(^)(NSArray<KBBugReport*>* reports))block;
- (void)getAllBugReportsForTask:(NSString *)taskId WithCompletion:(void (^)(NSArray<KBBugReport *> *))block;

- (void)getAllBugCategorysWithCompletion:(void(^)(KBBugCategory *category,NSError *error))block;

/**
 *  使用reportId获取所有的bug
 *
 *  @param reportId reportId description
 *  @param block        
 */
- (void)getAllBugReportsForReport:(NSString *)reportId withCompletion:(void (^)(NSArray<KBBugReport *> *,NSError *error))block;

/**
 *  通过ReportId上传报告
 *
 *  @param reportId  reportId
 *  @param bugReport bugReport description
 *  @param block     block description
 */
- (void)uploadBugReportWithReportId:(NSString *) reportId reportd:(KBBugReport*)bugReport withCompletion:(void (^)(KBBaseModel*, NSError*))block;
@end



