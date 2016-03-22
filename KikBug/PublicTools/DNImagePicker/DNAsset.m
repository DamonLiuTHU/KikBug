//
//  DNAsset.m
//  ImagePicker
//
//  Created by DingXiao on 15/3/6.
//  Copyright (c) 2015年 Dennis. All rights reserved.
//

#import "DNAsset.h"
#import "NSURL+DNIMagePickerUrlEqual.h"
@implementation DNAsset

+ (instancetype)assetWithALAsset:(ALAsset *)asset{
    DNAsset *instant;
    instant = [[DNAsset alloc] init];
    if (instant) {
        instant.baseAsset = asset;
        instant.url = [asset valueForProperty:ALAssetPropertyAssetURL];
    }
    return instant;
}

- (BOOL)isEqual:(id)other
{
    if (other == self) {
        return YES;
    } else if (![super isEqual:other]) {
        return NO;
    } else {
        return [self isEqualToAsset:other];
    }
}

- (BOOL)isEqualToAsset:(DNAsset *)asset
{
    if ([asset isKindOfClass:[DNAsset class]]) {
        return [self.url isEqualToOther:asset.url];
    } else {
        return NO;
    }
}

- (void)getImageUsingBlock:(void(^)(UIImage * ))block
{
    DNAsset *dnasset = self;
    ALAssetsLibrary *lib = [ALAssetsLibrary new];
//    __block CollectionViewCell *blockCell = cell;
    __weak typeof(self) weakSelf = self;
    [lib assetForURL:dnasset.url resultBlock:^(ALAsset *asset){
        __strong typeof(weakSelf) strongSelf = weakSelf;
        if (asset) {
            UIImage *image = [strongSelf getImageWithAsset:asset isFullImage:YES];
            block(image);
        } else {
            // On iOS 8.1 [library assetForUrl] Photo Streams always returns nil. Try to obtain it in an alternative way
            [lib enumerateGroupsWithTypes:ALAssetsGroupPhotoStream
                               usingBlock:^(ALAssetsGroup *group, BOOL *stop)
             {
                 [group enumerateAssetsWithOptions:NSEnumerationReverse
                                        usingBlock:^(ALAsset *result, NSUInteger index, BOOL *stop) {
                                            
                                            if([[result valueForProperty:ALAssetPropertyAssetURL] isEqual:dnasset.url])
                                            {
//                                                [strongSelf setCell:blockCell asset:result];
                                                UIImage *image = [strongSelf getImageWithAsset:result isFullImage:YES];
                                                block(image);
                                                *stop = YES;
                                            }
                                        }];
             }
                             failureBlock:^(NSError *error)
             {
//                 [strongSelf setCell:blockCell asset:nil];
                 UIImage *image = [strongSelf getImageWithAsset:nil isFullImage:YES];
                 block(image);
             }];
        }
        
    } failureBlock:^(NSError *error){
        __strong typeof(weakSelf) strongSelf = weakSelf;
        UIImage *image = [strongSelf getImageWithAsset:nil isFullImage:YES];
        block(image);
    }];
}

- (UIImage *)getImageResource
{
    return [self getImageWithAsset:self.baseAsset isFullImage:YES];
}

- (UIImage *)getImageWithAsset:(ALAsset *)asset isFullImage:(BOOL)fullImage
{
    
    if (!asset) {
        return nil;
    }
    
    UIImage *image;
//    NSString *string;
    if (fullImage) {
        NSNumber *orientationValue = [asset valueForProperty:ALAssetPropertyOrientation];
        UIImageOrientation orientation = UIImageOrientationUp;
        if (orientationValue != nil) {
            orientation = [orientationValue intValue];
        }
        
        image = [UIImage imageWithCGImage:asset.thumbnail];
        //        image = [UIImage imageWithCGImage:asset.thumbnail scale:0.1 orientation:orientation];
        
//        string = [NSString stringWithFormat:@"fileSize:%lld k\nwidth:%.0f\nheiht:%.0f",asset.defaultRepresentation.size/1000,[[asset defaultRepresentation] dimensions].width, [[asset defaultRepresentation] dimensions].height];
        
    } else {
        image = [UIImage imageWithCGImage:asset.defaultRepresentation.fullScreenImage];
        
//        string = [NSString stringWithFormat:@"fileSize:%lld k\nwidth:%.0f\nheiht:%.0f",asset.defaultRepresentation.size/1000,image.size.width,image.size.height];
    }
    return image;
}


@end
