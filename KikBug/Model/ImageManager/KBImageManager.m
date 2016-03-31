//
//  KBImageManager.m
//  KikBug
//
//  Created by DamonLiu on 16/3/22.
//  Copyright © 2016年 DamonLiu. All rights reserved.
//

#import "AFHTTPRequestOperationManager.h"
#import "KBImageManager.h"

/**
 upyunProvider.config({
 form_api_secret: '52TA3sfwGKHqsHOs+R+JjoDR5dw=',
 bucket: 'kikbug-test',
 'allow-file-type': 'jpg,jpeg,gif,png,txt,doc,docx,pdf,apk',
 });
 
 */


static NSString* UPYUNKEY = @"52TA3sfwGKHqsHOs+R+JjoDR5dw=";

@implementation KBImageManager

+ (void)uploadImage:(UIImage*)image withKey:(NSString*)key completion:(void (^)(NSString*, NSError*))block
{
    [UPYUNConfig sharedInstance].DEFAULT_BUCKET = @"kikbug-test";
    [UPYUNConfig sharedInstance].DEFAULT_PASSCODE = UPYUNKEY;
    __block UpYun* uy = [[UpYun alloc] init];
    uy.successBlocker = ^(NSURLResponse* response, id responseData) {
//        NSString* url = [responseData valueForKey:@"url"];
//        UIAlertView* alert = [[UIAlertView alloc] initWithTitle:url message:@"上传成功" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
//        [alert show];
//        NSLog(@"response body %@", responseData);
//
//        block(responseData, nil);
    };
    uy.failBlocker = ^(NSError* error) {
        NSString* message = [error.userInfo objectForKey:@"message"];
        UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"message" message:message delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
        [alert show];
        NSLog(@"error %@", message);
    };
    uy.progressBlocker = ^(CGFloat percent, int64_t requestDidSendBytes) {
        //        [_pv setProgress:percent];
    };

    // uy.uploadMethod = UPMutUPload; 分块
    //    如果 sinature 由服务端生成, 只需要将policy 和 密钥 拼接之后进行MD5, 否则就不用初始化signatureBlocker
    //    uy.signatureBlocker = ^(NSString *policy)
    //    {
    //        return @"";
    //    };

    /**
     *	@brief	根据 UIImage 上传
     */
    //    UIImage * image = [UIImage imageNamed:@"test2.png"];
    //        [uy uploadFile:image saveKey:[self getSaveKeyWith:@"jpg"]];

    //        [uy uploadFile:image saveKey:@"2016.jpg"];
    [uy uploadImage:image savekey:key];
    /**
     *	@brief	根据 文件路径 上传
     */
    //    NSString *resourcePath = [[NSBundle mainBundle] resourcePath];
    //    NSString *filePath = [resourcePath stringByAppendingPathComponent:@"image.jpg"];
    //    [uy uploadFile:filePath saveKey:@"/test2.png"];
    /**
     *	@brief	根据 NSDate  上传
     */
    //    NSData * fileData = [NSData dataWithContentsOfFile:filePath];
    //    [uy uploadFile:fileData saveKey:[self getSaveKeyWith:@"png"]];
}

/**
 *  为了保证图片名称不重复，设置规则为 /userId/dateStr/suffix
 *
 *  @param suffix suffix description
 *
 *  @return return value description
 */
+ (NSString*)getSaveKeyWith:(NSString*)suffix andIndex:(NSInteger)index
{
    /**
     *	@brief	方式1 由开发者生成saveKey
     */
    return [NSString stringWithFormat:@"/userId%@/%@-%ld.%@", STORED_USER_ID, [self getDateString], (long)index, suffix];
    /**
     *	@brief	方式2 由服务器生成saveKey
     */
//    return [NSString stringWithFormat:@"/{year}/{mon}/{day}/{filenamemd5}{.suffix}"];
    /**
     *	@brief	更多方式 参阅 http://docs.upyun.com/api/form_api/#_4
     */
}

+ (NSString*)getDateString
{
    NSDate* curDate = [NSDate date]; //获取当前日期
    NSDateFormatter* formater = [[NSDateFormatter alloc] init];
    [formater setDateFormat:@"yyyy/MM/dd"]; //这里去掉 具体时间 保留日期
    NSString* curTime = [formater stringFromDate:curDate];
    curTime = [NSString stringWithFormat:@"%@/%.0f", curTime, [curDate timeIntervalSince1970]];
    return curTime;
}

+(NSString *)uploadImage:(UIImage *)image Completion :(void (^)(NSString *, NSError *))block
{
    [UPYUNConfig sharedInstance].DEFAULT_BUCKET = @"kikbug-test";
    [UPYUNConfig sharedInstance].DEFAULT_PASSCODE = UPYUNKEY;
    __block UpYun* uy = [[UpYun alloc] init];
    uy.successBlocker = ^(NSURLResponse* response, id responseData) {
        NSString *url = [responseData valueForKey:@"url"];
        block(url, nil);
    };
    uy.failBlocker = ^(NSError* error) {
        NSString* message = [error.userInfo objectForKey:@"message"];
        UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"message" message:message delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
        [alert show];
        NSLog(@"error %@", message);
    };
    uy.progressBlocker = ^(CGFloat percent, int64_t requestDidSendBytes) {
        //        [_pv setProgress:percent];
    };
    NSString *key = [NSString stringWithFormat:@"/%@/userId%@/avatar.png",[self getDateString],STORED_USER_ID];
    [uy uploadImage:image savekey:key];
    
    return [KBImageManager fullImageUrlWithUrl:key];
}

static NSString *IMGURL_BASE_URL = @"http://kikbug-test.b0.upaiyun.com";

+ (NSString *)fullImageUrlWithUrl:(NSString *)url
{
    NSString *result = [IMGURL_BASE_URL stringByAppendingString:url];
    return result;
}
@end
