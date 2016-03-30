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

+ (void)sendGetHttpReqeustWithUrl:(NSString*)url Params:(NSDictionary*)param CallBack:(void (^)(id responseObject, NSError* err))block
{
    AFHTTPRequestOperationManager* manager = [self getHttpRequestManager];

    [manager GET:url
        parameters:param
        success:^(AFHTTPRequestOperation* operation, id responseObject) {
            [self checkResponseObj:responseObject withBlock:block];
        }
        failure:^(AFHTTPRequestOperation* operation, NSError* error) {
            NSString* errorStr = [NSString stringWithFormat:@"%@", error];
            UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"错误" message:errorStr preferredStyle:UIAlertControllerStyleAlert];
            [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction* _Nonnull action){
                             }]];
            [UIManager showViewController:alert];
            block(operation.responseObject, error);
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
            NSString* errorStr = [NSString stringWithFormat:@"%@", error];
            UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"错误" message:errorStr preferredStyle:UIAlertControllerStyleAlert];
            [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction* _Nonnull action){
                             }]];
            [UIManager showViewController:alert];
            block(operation.responseObject, error);
        }];
}

+ (void)sendPutHttpRequestWithUrl:(NSString*)url
                           Params:(NSDictionary*)param
                         CallBack:(void (^)(id, NSError*))block
{
    AFHTTPRequestOperationManager* manager = [self getHttpRequestManager];
    [manager PUT:url
        parameters:param
        success:^(AFHTTPRequestOperation* operation, id responseObject) {
            [self checkResponseObj:responseObject withBlock:block];
        }
        failure:^(AFHTTPRequestOperation* operation, NSError* error) {
            NSString* errorStr = [NSString stringWithFormat:@"%@", error];
            UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"错误" message:errorStr preferredStyle:UIAlertControllerStyleAlert];
            [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction* _Nonnull action){
                             }]];
            [UIManager showViewController:alert];
            block(operation.responseObject, error);
        }];
}

+ (AFHTTPRequestOperationManager*)getHttpRequestManager
{
    AFHTTPRequestOperationManager* manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
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

    if ([jsonString isEqualToString:@"false"] || [jsonString isEqualToString:@"true"]) {
        NSMutableDictionary* dic = [NSMutableDictionary dictionary];
        BOOL result = [jsonString boolValue];
        [dic setValue:@(result) forKey:@"data"];
        return dic;
    }

    if (jsonString == nil) {
        return nil;
    }

    NSData* jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSError* err;
    NSDictionary* dic = [NSJSONSerialization JSONObjectWithData:jsonData
                                                        options:NSJSONReadingAllowFragments
                                                          error:&err];
    if (err) {
        NSLog(@"json解析失败：%@", err);
        return dic;
    }
    return dic;
}

+ (void)checkResponseObj:(id)responseObject withBlock:(void (^)(id responseObject, NSError* err))block
{
#if DEBUG
    NSLog(@"%@", responseObject);
#endif
    KBBaseModel* baseModel = [KBBaseModel mj_objectWithKeyValues:responseObject];
    //    switch (baseModel.status) {
    //    case 401: {
    //        //处理Session过期的情况
    //        [KBLoginManager markUserAsLogOut];
    //    } break;
    //
    //    case 200: {
    //        //一切正常

    if ([baseModel.data isKindOfClass:[NSString class]]) {
        //        NSString *jsonStr = [NSString stringWithFormat:@"%@",baseModel.data];
        NSDictionary* dataDic = [self dictionaryWithJsonString:baseModel.data];
        block(dataDic, nil);
    }
    else {
        block(baseModel.data, nil);
    }

    //    } break;
    //
    //    case 403: {
    //        //没有权限
    //
    //    } break;

    //    default:
    //        break;
    //    }
}

@end
