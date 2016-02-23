//
//  KBTaskDetailViewController.h
//  KikBug
//
//  Created by DamonLiu on 15/8/11.
//  Copyright (c) 2015年 DamonLiu. All rights reserved.
//

#import <UIKit/UIKit.h>
@class KBTaskListModel;
@interface KBTaskDetailViewController : KBViewController
//@property (strong, nonatomic) UIImageView *AppIcon;
//@property (strong, nonatomic) UITextView *introduction;
//@property (strong, nonatomic) UIView *contentView;

-(void)fillWithContent:(KBTaskListModel*)data;
@end
