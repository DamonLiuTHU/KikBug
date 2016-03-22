//
//  DNBrowserCell.h
//  ImagePicker
//
//  Created by DingXiao on 15/2/28.
//  Copyright (c) 2015年 Dennis. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AssetsLibrary/AssetsLibrary.h>
@class DNPhotoBrowser;

/**
 *  DNPhotoBrowser中的Cell 负责展示图片以及对应描述
 */
@interface DNBrowserCell : UICollectionViewCell

@property (nonatomic, weak) DNPhotoBrowser *photoBrowser;

@property (nonatomic, strong) ALAsset *asset;

@end
