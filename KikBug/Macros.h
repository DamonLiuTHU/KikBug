//
//  Macros.h
//  KikBug
//
//  Created by DamonLiu on 15/11/9.
//  Copyright © 2015年 DamonLiu. All rights reserved.
//

#ifndef Macros_h
#define Macros_h

/***Model Definitions**/
#define JSONSTIRNG @property (copy,nonatomic,readwrite) NSString*
#define JSONINT @property (assign,nonatomic) NSInteger
#define JSONARRAY @property (strong,nonatomic) NSArray*
/***App Font Size ****/
#define APP_FONT_SIZE_MIDDLE 12
#define APP_FONT_SIZE_LARGE  14
#define APP_FONT_SIZE_SMALL  10


//获取屏幕 宽度、高度
#define IsPortrait ([UIApplication sharedApplication].statusBarOrientation == UIInterfaceOrientationPortrait || [UIApplication sharedApplication].statusBarOrientation == UIInterfaceOrientationPortraitUpsideDown)

#define SCREEN_WIDTH (IsPortrait ? MIN(([UIScreen mainScreen].bounds.size.width), ([UIScreen mainScreen].bounds.size.height)) : MAX(([UIScreen mainScreen].bounds.size.width), ([UIScreen mainScreen].bounds.size.height)))

#define SCREEN_HEIGHT (IsPortrait ? MAX(([UIScreen mainScreen].bounds.size.width), ([UIScreen mainScreen].bounds.size.height)) : MIN(([UIScreen mainScreen].bounds.size.width), ([UIScreen mainScreen].bounds.size.height)))


//weak self

#define WEAKSELF __weak __typeof(&*self)weakSelf = self;

#endif /* Macros_h */
