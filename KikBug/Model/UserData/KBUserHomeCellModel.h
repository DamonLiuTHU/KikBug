//
//  KBUserHomeCellModel.h
//  KikBug
//
//  Created by DamonLiu on 16/3/29.
//  Copyright © 2016年 DamonLiu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface KBUserHomeCellModel : NSObject
@property (strong, nonatomic) id model;
@property (strong, nonatomic) Class cellClass;
@property (assign, nonatomic) NSInteger cellHeight;

- (instancetype)initWithClass:(Class)className cellHeight:(CGFloat)cellHeight model:(id)model;
+ (instancetype)emptyCellWithHeight:(CGFloat)height;

@end
