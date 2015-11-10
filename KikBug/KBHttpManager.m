//
//  KBHttpManager.m
//  KikBug
//
//  Created by DamonLiu on 15/11/10.
//  Copyright © 2015年 DamonLiu. All rights reserved.
//

#import "KBHttpManager.h"
#import "AFHTTPRequestOperationManager.h"

@implementation KBHttpManager

+(void)SendGetHttpReqeustWithUrl:(NSString *)url Params:(NSDictionary *)param CallBack:(void (^)(id responseObject, NSError *err))block
{
    param = [KBHttpManager checkParam:param];
    AFHTTPRequestOperationManager* manager = [AFHTTPRequestOperationManager manager];
    [manager GET:url
      parameters:param
         success:^(AFHTTPRequestOperation *operation, id responseObject)
     {
         block(responseObject,nil);
     }
         failure:^(AFHTTPRequestOperation *operation, NSError *error)
     {
         block(nil,error);
     }];

}

//check the app key param
+(NSDictionary*)checkParam:(NSDictionary*)param
{
    if(!param||![[param allKeys] containsObject:@"key"]){
        NSMutableDictionary* dic;
        if(param){
            dic = [NSMutableDictionary dictionaryWithDictionary:param];
        }else{
            dic = [NSMutableDictionary dictionary];
        }
        [dic setObject:APPKEY forKey:@"key"];
        param = [NSDictionary dictionaryWithDictionary:dic];
    }
    return  param;
}
@end
