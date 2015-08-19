//
//  TaskCellData.m
//  KikBug
//
//  Created by DamonLiu on 15/8/11.
//  Copyright (c) 2015年 DamonLiu. All rights reserved.
//

#import "TaskCellData.h"

@implementation TaskCellData
@synthesize introdution;
@synthesize appImage;
@synthesize jump_url;
-(id)initWithImage:(UIImage *)image Introduction:(NSString *)intro URL:(NSString *)url{
    if(self = [super init]){
        appImage = image;
        introdution = intro;
        jump_url = url;
    }
    return self;
}

@end
