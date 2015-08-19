//
//  TaskDetailViewController.h
//  KikBug
//
//  Created by DamonLiu on 15/8/11.
//  Copyright (c) 2015年 DamonLiu. All rights reserved.
//

#import <UIKit/UIKit.h>
@class TaskCellData;
@interface TaskDetailViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIImageView *AppIcon;
@property (weak, nonatomic) IBOutlet UITextView *introduction;
@property (strong, nonatomic) IBOutlet UIView *contentView;


-(void)fillWithContent:(TaskCellData*)data;
@end
