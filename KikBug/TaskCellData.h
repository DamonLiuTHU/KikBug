//
//  TaskCellData.h
//  KikBug
//
//  Created by DamonLiu on 15/8/11.
//  Copyright (c) 2015年 DamonLiu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface TaskCellData : NSObject
@property (strong,nonatomic) UIImage* appImage;
@property (strong,nonatomic) NSString* introdution;
@property (strong,nonatomic,readonly,getter=jumpURL) NSString* jump_url;
-(id)initWithImage:(UIImage*)image Introduction:(NSString*)intro URL:(NSString*)jump_url;
@end
