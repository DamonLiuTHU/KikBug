//
//  DNAsset.h
//  ImagePicker
//
//  Created by DingXiao on 15/3/6.
//  Copyright (c) 2015年 Dennis. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreGraphics/CoreGraphics.h>
#import <AssetsLibrary/ALAssetsLibrary.h>
#import <AssetsLibrary/AssetsLibrary.h>

@interface DNAsset : NSObject
@property (nonatomic, strong) ALAsset *baseAsset;
@property (nonatomic, strong) NSURL *url;  //ALAsset url
@property (nonatomic, strong) NSString *userDesc;//用户的描述

- (BOOL)isEqualToAsset:(DNAsset *)asset;
+ (instancetype)assetWithALAsset:(ALAsset *)asset;
//- (void)getImageUsingBlock:(void(^)(UIImage * ))block;
- (UIImage *)getImageResource;
- (void)imageWithALAssetUrlWithBlock:(void(^)(UIImage *))block;
@end
