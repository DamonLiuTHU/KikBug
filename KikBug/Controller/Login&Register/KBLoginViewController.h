//
//  KBLoginViewController.h
//  KikBug
//
//  Created by DamonLiu on 16/1/26.
//  Copyright © 2016年 DamonLiu. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^loginSuccessBlock)(void);
@interface KBLoginViewController : KBViewController
@property (copy,nonatomic) loginSuccessBlock block;
@property (strong,nonatomic) UIBarButtonItem *closePageButton;
@end
