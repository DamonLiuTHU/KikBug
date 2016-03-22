//
//  KBImageManager.h
//  KikBug
//
//  Created by DamonLiu on 16/3/22.
//  Copyright © 2016年 DamonLiu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UpYun.h"

@interface KBImageManager : NSObject
+ (NSString * )getSaveKeyWith:(NSString *)suffix andIndex:(NSInteger)index;
+ (void)uploadImage:(UIImage *)image withKey:(NSString *)key completion:(void(^)(NSString *imageUrl,NSError *error))block;
@end
