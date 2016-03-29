//
//  UIImageView+EaseUse.m
//  KikBug
//
//  Created by DamonLiu on 16/3/26.
//  Copyright © 2016年 DamonLiu. All rights reserved.
//

#import "UIImageView+EaseUse.h"
#import "SDWebImageManager.h"

@implementation UIImageView (EaseUse)
- (void)setImageWithUrl:(NSString *)str
{
    if ([NSString isNilorEmpty:str]) {
        return;
    }
    WEAKSELF;
    str =[NSString stringWithString:[str stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    NSURL *url=[NSURL URLWithString:str];
    [[SDWebImageManager sharedManager]
     downloadImageWithURL:url
     options:SDWebImageAvoidAutoSetImage
     progress:^(NSInteger receivedSize, NSInteger expectedSize) {
         //        CGFloat process =
         //        ((CGFloat)receivedSize/(CGFloat)expectedSize);
         //        NSLog(@"show progress");
         //        [weakSelf.icon updateImageDownloadProgress:process];
     }
     completed:^(UIImage* image, NSError* error, SDImageCacheType cacheType,
                 BOOL finished, NSURL* imageURL) {
         if (!error && image) {
             weakSelf.image = image;
         }
     }];

}
@end
