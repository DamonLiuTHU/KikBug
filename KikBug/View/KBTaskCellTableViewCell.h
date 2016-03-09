//
//  KBTaskCellTableViewCell.h
//  KikBug
//
//  Created by DamonLiu on 15/8/11.
//  Copyright (c) 2015年 DamonLiu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KBBaseTableViewCell.h"


@class KBTaskListModel;
@interface KBTaskCellTableViewCell : KBBaseTableViewCell
-(void)fillWithContent:(KBTaskListModel*)data;

+(CGFloat)cellHeight;
@end
