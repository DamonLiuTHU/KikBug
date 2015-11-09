//
//  TaskCellTableViewCell.h
//  KikBug
//
//  Created by DamonLiu on 15/8/11.
//  Copyright (c) 2015年 DamonLiu. All rights reserved.
//

#import <UIKit/UIKit.h>


@class TaskCellData;
@interface TaskCellTableViewCell : UITableViewCell
-(void)fillWithContent:(TaskCellData*)data;
@end
