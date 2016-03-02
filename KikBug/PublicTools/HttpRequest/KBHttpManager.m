//
//  KBHttpManager.m
//  KikBug
//
//  Created by DamonLiu on 15/11/10.
//  Copyright © 2015年 DamonLiu. All rights reserved.
//

#import "AFHTTPRequestOperationManager.h"
#import "KBBaseModel.h"
#import "KBHttpManager.h"
#import "KBLoginManager.h"

@implementation KBHttpManager

//+(AFHTTPResponseSerializer *)kb_serializer{
//    AFHTTPResponseSerializer *pt = [AFHTTPResponseSerializer serializer];
//    pt.acceptableContentTypes = [NSSet setWithObjects: @"application/json", @"text/json", @"text/javascript",@"text/plain", nil];
//    return pt;
//}

//+(void)sendGetHttpReqeustWithUrl:(NSString *)url Params:(NSDictionary *)param CallBack:(void (^)(id responseObject, NSError *err))block
//{
//    param = [KBHttpManager checkParam:param];
//    AFHTTPRequestOperationManager* manager = [AFHTTPRequestOperationManager manager];
//    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
//    manager.responseSerializer.acceptableContentTypes = [manager.responseSerializer.acceptableContentTypes setByAddingObject:@"text/plain"];
//    [manager GET:url
//      parameters:param
//         success:^(AFHTTPRequestOperation *operation, id responseObject)
//     {
//# if DEBUG
//         NSLog(@"%@", responseObject);
//# endif
//         block(responseObject,nil);
//     }
//         failure:^(AFHTTPRequestOperation *operation, NSError *error)
//     {
//         block(nil,error);
//     }];
//
//}

+ (void)sendGetHttpReqeustWithUrl:(NSString*)url Params:(NSDictionary*)param CallBack:(void (^)(id responseObject, NSError* err))block
{
    //    AFHTTPRequestOperationManager* manager = [AFHTTPRequestOperationManager manager];
    //    AFJSONRequestSerializer* jsonRequestSerializer = [AFJSONRequestSerializer serializer];
    //    [manager setRequestSerializer:jsonRequestSerializer];

    //    manager.responseSerializer.acceptableContentTypes = [manager.responseSerializer.acceptableContentTypes setByAddingObject:@"text/plain"];
    AFHTTPRequestOperationManager* manager = [self getHttpRequestManager];
    [manager GET:url
        parameters:param
        success:^(AFHTTPRequestOperation* operation, id responseObject) {
            [self checkResponseObj:responseObject withBlock:block];
        }
        failure:^(AFHTTPRequestOperation* operation, NSError* error) {
            block(nil, error);
        }];
}

+ (void)sendPostHttpRequestWithUrl:(NSString*)url
                            Params:(NSDictionary*)param
                          CallBack:(void (^)(id, NSError*))block
{

    AFHTTPRequestOperationManager* manager = [self getHttpRequestManager];

    [manager POST:url
        parameters:param
        success:^(AFHTTPRequestOperation* operation, id responseObject) {
            [self checkResponseObj:responseObject withBlock:block];
        }
        failure:^(AFHTTPRequestOperation* operation, NSError* error) {
            block(nil, error);
        }];
}

+ (AFHTTPRequestOperationManager*)getHttpRequestManager
{
    AFHTTPRequestOperationManager* manager = [AFHTTPRequestOperationManager manager];
    AFJSONRequestSerializer* jsonRequestSerializer = [AFJSONRequestSerializer serializer];
    [manager setRequestSerializer:jsonRequestSerializer];

    [manager.requestSerializer setValue:@"aaa" forHTTPHeaderField:@"App-Key"];
    [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    NSString* session = [[NSUserDefaults standardUserDefaults] valueForKey:SESSION];
    if (session) {
        [manager.requestSerializer setValue:session forHTTPHeaderField:@"Session"];
    }
    return manager;
}

//check the app key param
+ (NSDictionary*)checkParam:(NSDictionary*)param
{
    if (!param || ![[param allKeys] containsObject:@"key"]) {
        NSMutableDictionary* dic;
        if (param) {
            dic = [NSMutableDictionary dictionaryWithDictionary:param];
        }
        else {
            dic = [NSMutableDictionary dictionary];
        }
        [dic setObject:APPKEY forKey:@"key"];
        param = [NSDictionary dictionaryWithDictionary:dic];
    }
    return param;
}

+ (NSDictionary*)dictionaryWithJsonString:(NSString*)jsonString
{
    if (jsonString == nil) {
        return nil;
    }

    NSData* jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSError* err;
    NSDictionary* dic = [NSJSONSerialization JSONObjectWithData:jsonData
                                                        options:NSJSONReadingMutableContainers
                                                          error:&err];
    if (err) {
        NSLog(@"json解析失败：%@", err);
        return nil;
    }
    return dic;
}

+(void)checkResponseObj:(id)responseObject withBlock:(void (^)(id responseObject, NSError* err))block {
#if DEBUG
    NSLog(@"%@", responseObject);
#endif
    KBBaseModel* baseModel = [KBBaseModel mj_objectWithKeyValues:responseObject];
    switch (baseModel.status) {
        case 401:
        {
            //处理Session过期的情况
            [KBLoginManager markUserAsLogOut];
        }
            break;
            
        default:
            break;
    }
    NSDictionary* dataDic = [self dictionaryWithJsonString:baseModel.data];
    block(dataDic, nil);
}

@end
