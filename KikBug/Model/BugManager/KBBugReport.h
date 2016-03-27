//
//  KBBugReport.h
//  KikBug
//
//  Created by DamonLiu on 16/3/24.
//  Copyright © 2016年 DamonLiu. All rights reserved.
//

#import <Foundation/Foundation.h>
@class DNAsset;
@interface KBBugReport : KBBaseModel
JSONINT bugId;
JSONINT taskId;
JSONINT reportId;
JSONINT bugCategoryId;
JSONSTIRNG bugDescription;
JSONSTIRNG imgUrl;
JSONINT severity;
JSONSTIRNG localUrl;
//@property (strong,nonatomic) NSArray<KBBugReportItem *> *items;/*< 1~9 个item **/

+ (instancetype)reportWithDNAssets:(NSArray<DNAsset *> *)list taskId:(NSString *)taskId;;

@end
