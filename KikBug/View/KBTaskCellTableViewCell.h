//
//  KBTaskCellTableViewCell.h
//  KikBug
//
//  Created by DamonLiu on 15/8/11.
//  Copyright (c) 2015年 DamonLiu. All rights reserved.
//

#import <UIKit/UIKit.h>


@class KBTaskListModel;
@interface KBTaskCellTableViewCell : UITableViewCell
-(void)fillWithContent:(KBTaskListModel*)data;

+(CGFloat)cellHeight;
@end
