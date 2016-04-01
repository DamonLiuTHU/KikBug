//
//  KBSimpleEditorViewController.h
//  KikBug
//
//  Created by DamonLiu on 16/3/31.
//  Copyright © 2016年 DamonLiu. All rights reserved.
//

#import "KBViewController.h"

@protocol KBSimpleEditorViewControllerDelegate <NSObject>

@required
- (void)editorDidReturnStr:(NSString*)str;

@end

@interface KBSimpleEditorViewController : KBViewController
@property (weak, nonatomic) id<KBSimpleEditorViewControllerDelegate> delegate;
@end
