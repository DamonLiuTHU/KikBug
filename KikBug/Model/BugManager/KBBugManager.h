//
//  KBBugManager.h
//  KikBug
//
//  Created by DamonLiu on 16/3/24.
//  Copyright © 2016年 DamonLiu. All rights reserved.
//

#import <Foundation/Foundation.h>
@class KBBugReport;
@interface KBBugManager : NSObject
SINGLETON_INTERFACE(KBBugManager, sharedInstance);
- (void)uploadBugReport:(KBBugReport*)bugReport withCompletion:(void (^)(KBBaseModel* model, NSError* error))block;
- (void)getAllBugReportsWithCompletion:(void(^)(NSArray<KBBugReport*>* reports))block;
- (void)getAllBugReportsForTask:(NSString *)taskId WithCompletion:(void (^)(NSArray<KBBugReport *> *))block;
@end
