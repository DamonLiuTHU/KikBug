//
//  KBReportManager.h
//  KikBug
//
//  Created by DamonLiu on 16/3/21.
//  Copyright © 2016年 DamonLiu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DNAsset.h"
@class KBTaskReport;
//@interface KBBugReportItem : KBBaseModel
//@property (strong,nonatomic) UIImage *image;
//@property (strong,nonatomic) NSString *descForImage;
//@end

@interface KBBugReport : KBBaseModel
JSONINT bugId;
JSONINT taskId;
JSONINT reportId;
JSONINT bugCategoryId;
JSONSTIRNG bugDescription;
JSONSTIRNG imgUrl;
JSONINT severity;
//@property (strong,nonatomic) NSArray<KBBugReportItem *> *items;/*< 1~9 个item **/

+ (instancetype)reportWithDNAssets:(NSArray<DNAsset *> *)list taskId:(NSString *)taskId;;

@end





@interface KBReportManager : NSObject

+ (void)uploadBugReport:(KBBugReport *)bugReport withCompletion:(void(^)(KBBaseModel *model,NSError *error))block;

+ (void)uploadTaskReport:(KBTaskReport *)taskReport withCompletion:(void(^)(KBBaseModel *model,NSError *error))block;

@end


