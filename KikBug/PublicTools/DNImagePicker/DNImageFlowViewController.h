//
//  DNImageFlowViewController.h
//  ImagePicker
//
//  Created by DingXiao on 15/2/11.
//  Copyright (c) 2015年 Dennis. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AssetsLibrary/AssetsLibrary.h>

/**
 每一个具体的图片册的图片选取
 
 - returns: return value description
 */
@interface DNImageFlowViewController : UIViewController

- (instancetype)initWithGroupURL:(NSURL *)assetsGroupURL;
@end
