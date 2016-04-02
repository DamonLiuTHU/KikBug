//
//  KBEmptyView.h
//  KikBug
//
//  Created by DamonLiu on 16/4/2.
//  Copyright © 2016年 DamonLiu. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^ReloadBlock)(void);
@interface KBEmptyView : UIView
@property (copy,nonatomic) ReloadBlock block;
@property (copy,nonatomic) NSString *tipText;
@end
