//
//  KBBugManager.m
//  KikBug
//
//  Created by DamonLiu on 16/3/24.
//  Copyright © 2016年 DamonLiu. All rights reserved.
//

#import "CDBugReport.h"
#import "KBBugManager.h"
#import "KBBugReport.h"
#import "KBHttpManager.h"
#import "KBReportManager.h"

@interface KBBugManager ()
@property (strong, nonatomic) NSManagedObjectContext* context;
@end

@implementation KBBugManager

SINGLETON_IMPLEMENTION(KBBugManager, sharedInstance);

- (void)initContext
{
    // 从应用程序包中加载模型文件
    NSManagedObjectModel* model = [NSManagedObjectModel mergedModelFromBundles:nil];
    // 传入模型对象，初始化NSPersistentStoreCoordinator
    NSPersistentStoreCoordinator* psc = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:model];
    // 构建SQLite数据库文件的路径
    NSString* docs = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSURL* url = [NSURL fileURLWithPath:[docs stringByAppendingPathComponent:@"bug.data"]];
    // 添加持久化存储库，这里使用SQLite作为存储库
    NSError* error = nil;
    NSPersistentStore* store = [psc addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:url options:nil error:&error];
    if (store == nil) { // 直接抛异常
        [NSException raise:@"添加数据库错误" format:@"%@", [error localizedDescription]];
    }
    // 初始化上下文，设置persistentStoreCoordinator属性
    NSManagedObjectContext* context = [[NSManagedObjectContext alloc] init];
    context.persistentStoreCoordinator = psc;
    self.context = context;
}
/**
 *  上传bug报告
 *
 *  @param bugReport bugReport description
 *  @param block     block description
 */
- (void)uploadBugReport:(KBBugReport*)bugReport withCompletion:(void (^)(KBBaseModel*, NSError*))block
{
    NSString* url = GETURL_V2(@"UploadBug");
    if ([KBReportManager getReportId] >= 0) {
        bugReport.reportId = [KBReportManager getReportId];
    }
    else { //如果没有reportId，那么说明服务器没有返回reportId，不可以发送bug报告。
        return;
    }
    [KBHttpManager sendPostHttpRequestWithUrl:url Params:[bugReport mj_keyValues] CallBack:^(id responseObject, NSError* error) {
        if (!error) {
            bugReport.bugId = [responseObject integerValue];
            [self saveBugReport:bugReport];
            block(nil,nil);
        }
        else {
            [self saveBugReport:bugReport];
            block(nil,error);
        }
    }];
}

static NSString* entityName = @"CDBugReport";

- (void)saveBugReport:(KBBugReport*)bugReport
{
    if (!self.context) {
        [self initContext];
    }
    // 传入上下文，创建一个Person实体对象
    NSManagedObject* cdBugReport = [NSEntityDescription insertNewObjectForEntityForName:entityName inManagedObjectContext:self.context];
    [cdBugReport setValue:@(bugReport.bugId) forKey:@"bugId"];
    [cdBugReport setValue:bugReport.bugDescription forKey:@"bugDesc"];
    [cdBugReport setValue:bugReport.imgUrl forKey:@"bugImgSrc"];
    [cdBugReport setValue:@(bugReport.reportId) forKey:@"reportId"];
    // 利用上下文对象，将数据同步到持久化存储库
    NSError* error = nil;
    BOOL success = [self.context save:&error];
    if (!success) {
        [NSException raise:@"DBError" format:@"%@", [error localizedDescription]];
    }
}

- (void)getAllBugReportsWithCompletion:(void (^)(NSArray<KBBugReport*>*))block
{
    if (!self.context) {
        [self initContext];
    }
    // 初始化一个查询请求
    NSFetchRequest* request = [[NSFetchRequest alloc] init];
    // 设置要查询的实体
    request.entity = [NSEntityDescription entityForName:entityName inManagedObjectContext:self.context];
    // 设置排序（按照age降序）
    NSSortDescriptor* sort = [NSSortDescriptor sortDescriptorWithKey:@"bugId" ascending:NO];
    request.sortDescriptors = [NSArray arrayWithObject:sort];

    // 执行请求
    NSError* error = nil;
    NSArray* objs = [self.context executeFetchRequest:request error:&error];
    if (error) {
        [NSException raise:@"DBError" format:@"%@", [error localizedDescription]];
        block(nil);
        return;
    }
    NSMutableArray<KBBugReport*>* array = [NSMutableArray arrayWithCapacity:objs.count];
    // 遍历数据
    for (NSManagedObject* obj in objs) {
        KBBugReport* report = [[KBBugReport alloc] init];
        report.bugId = [[obj valueForKey:@"bugId"] integerValue];
        report.bugDescription = [obj valueForKey:@"bugDesc"];
        report.imgUrl = [obj valueForKey:@"bugImgSrc"];
        report.reportId = [[obj valueForKey:@"reportId"] integerValue];
        [array addObject:report];
    }
    block(array);
}
@end
