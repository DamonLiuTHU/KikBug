//
//  KBBaseModel.h
//  KikBug
//
//  Created by DamonLiu on 16/2/29.
//  Copyright © 2016年 DamonLiu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface KBBaseModel : NSObject<MJKeyValue>
JSONSTIRNG message;
JSONINT status;
@property (strong, nonatomic) NSString* data;
@end
