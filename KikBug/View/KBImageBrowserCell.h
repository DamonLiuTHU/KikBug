//
//  KBImageBrowserCell.h
//  KikBug
//
//  Created by DamonLiu on 16/4/2.
//  Copyright © 2016年 DamonLiu. All rights reserved.
//

#import "KBBaseTableViewCell.h"
@class DNTapDetectingImageView;
@interface KBImageBrowserCell : UICollectionViewCell
@property (nonatomic, strong) UIScrollView *zoomingScrollView;
@property (nonatomic, strong) DNTapDetectingImageView *photoImageView;
- (void)bindModel:(NSString *)imgUrl;
@end
