//
//  DNPhotoBrowserViewController.h
//  ImagePicker
//
//  Created by DingXiao on 15/2/28.
//  Copyright (c) 2015年 Dennis. All rights reserved.
//

#import <UIKit/UIKit.h>
//#import <AssetsLibrary/AssetsLibrary.h>
#import "DNAsset.h"

@class DNImageFlowViewController;
@class DNPhotoBrowser;
@protocol DNPhotoBrowserDelegate <NSObject>

@required
- (void)sendImagesFromPhotobrowser:(DNPhotoBrowser *)photoBrowse currentAsset:(DNAsset *)asset;
- (NSUInteger)seletedPhotosNumberInPhotoBrowser:(DNPhotoBrowser *)photoBrowser;
- (BOOL)photoBrowser:(DNPhotoBrowser *)photoBrowser currentPhotoAssetIsSeleted:(DNAsset *)asset;
- (BOOL)photoBrowser:(DNPhotoBrowser *)photoBrowser seletedAsset:(DNAsset *)asset;
- (void)photoBrowser:(DNPhotoBrowser *)photoBrowser deseletedAsset:(DNAsset *)asset;
- (void)photoBrowser:(DNPhotoBrowser *)photoBrowser seleteFullImage:(BOOL)fullImage;
@end

/**
 *  图片预览
 */

@interface DNPhotoBrowser : UIViewController

@property (nonatomic, weak) id<DNPhotoBrowserDelegate> delegate;

- (instancetype)initWithPhotos:(NSArray *)photosArray
                  currentIndex:(NSInteger)index
                     fullImage:(BOOL)isFullImage;

- (void)hideControls;
- (void)toggleControls;
@end
