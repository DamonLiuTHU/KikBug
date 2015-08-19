//
//  TaskDetailViewController.m
//  KikBug
//
//  Created by DamonLiu on 15/8/11.
//  Copyright (c) 2015年 DamonLiu. All rights reserved.
//

#import "TaskDetailViewController.h"
#import "TaskCellData.h"


@implementation TaskDetailViewController{
    TaskCellData* data;
    __weak IBOutlet UIButton *jumpButton;
    NSURL* appUrl;
    CGContextRef ctx;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    UISwipeGestureRecognizer* rec = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(backToPreviousPage)];
    [rec setDirection:UISwipeGestureRecognizerDirectionRight];
    
//    UITapGestureRecognizer* rec = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(closePage)];
    [self.contentView addGestureRecognizer:rec];
    

   }
//
//-(void)addLine:(CGPoint)start end:(CGPoint)ed{
//    CGContextMoveToPoint(ctx, start.x, start.y);
//    CGContextAddLineToPoint(ctx, ed.x, ed.y);
//}

-(void)backToPreviousPage{
//    [self dismissViewControllerAnimated:YES completion:nil];
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)fillWithContent:(TaskCellData *)idata{
    data = idata;
    [self.AppIcon setImage:[idata appImage]];
    [self.introduction setText:[idata introdution]];
    
    NSURL* url = [NSURL URLWithString:data.jumpURL];
    if([[UIApplication sharedApplication] canOpenURL:url]){
        [jumpButton setTitle:@"打开" forState:UIControlStateNormal];
        appUrl = url;
    }else{
        [jumpButton setTitle:@"去App Store下载" forState:UIControlStateNormal];
    }
    
//    [self addLine:CGPointMake(jumpButton.frame.origin.x, jumpButton.frame.origin.y+jumpButton.frame.size.height) end:CGPointMake(jumpButton.frame.origin.x+[UIScreen mainScreen].bounds.size.width, jumpButton.frame.origin.y+jumpButton.frame.size.height)];

}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
- (IBAction)jumpToNextPage:(id)sender {
    if(appUrl!=nil){
        [[UIApplication sharedApplication] openURL:appUrl];
    }else{
//        [[UIApplication sharedApplication]]
    }
}

@end
