//
//  KBBugTypeLabel.h
//  KikBug
//
//  Created by DamonLiu on 16/4/5.
//  Copyright © 2016年 DamonLiu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface KBBugTypeLabel : UILabel 
/**
 *  获取实例
 *
 *  @param title 标题
 *  @param severity 严重程度  1~5   从黄色,橘黄色,橘红色,淡红色,红色
 *
 *  @return return value description
 */
- (void)fillLabelWithTitle:(NSString *)title severity:(NSInteger)severity;
@end
