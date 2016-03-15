//
//  KBBaseModel.m
//  KikBug
//
//  Created by DamonLiu on 16/2/29.
//  Copyright © 2016年 DamonLiu. All rights reserved.
//

#import "KBBaseModel.h"

@implementation KBBaseModel

@end

@implementation KBErrorModel
- (NSString *)description {
    return  [NSString stringWithFormat:@"<%@: %ld,\"%@ \">",[self class],(long)self.status,self.message];
}
@end